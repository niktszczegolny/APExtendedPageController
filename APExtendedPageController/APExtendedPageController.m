//
//  APExtendedPageController.m
//  APExtendedPageController
//
//  Created by Andrzej on 03.04.2013.
//  Copyright (c) 2013 apuczyk. All rights reserved.
//

#import "APExtendedPageController.h"

@interface APExtendedPageController () {
    BOOL _isScrolling;
    
    UIView * _newMainView;
    NSInteger _newIndex;
}

@end

@implementation APExtendedPageController
@synthesize extendedPageControllerDelegate = _extendedPageControllerDelegate;
@synthesize mainView = _mainView;
@synthesize actualIndex = _actualIndex;
@synthesize displayBorder = _displayBorder;

- (id)initWithFrame:(CGRect)frame mainView:(UIView *)mainView extendedPageControllerDelegate:(id)extendedPageControllerDelegate
{
    self = [super initWithFrame:frame];
    if (self) {
        _extendedPageControllerDelegate = extendedPageControllerDelegate;
        _actualIndex = 0;
        _mainView = mainView;
        _displayBorder = YES;
        
        self.delegate = self;
        self.scrollEnabled = YES;
        self.pagingEnabled = YES;
        self.contentSize = CGSizeMake(self.frame.size.width * 3, self.frame.size.height);
        self.contentOffset = CGPointMake(self.frame.size.width, 0);
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.autoresizesSubviews = YES;
        
        _mainView.frame = [self _frameForMainView];
        _mainView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _mainView.autoresizesSubviews = YES;
        
        [self addSubview:_mainView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.contentSize.width/3 != self.frame.size.width) {
        self.contentSize = CGSizeMake(self.frame.size.width * 3, self.frame.size.height);
        self.contentOffset = CGPointMake(self.frame.size.width, 0);
        
        
        [self _resetView:_mainView withScaleFactor:1.];
        [self _rearrangeViews];
        
        _mainView.frame = [self _frameForMainView];
    }
}

#define maxScale        .85
#define vBorderWidth     4.

- (void)setContentOffset:(CGPoint)contentOffset {
    [super setContentOffset:contentOffset];
    
    if (contentOffset.x == self.frame.size.width) {
        _isScrolling = NO;
    }
    else {
        
        if (!_isScrolling) {
            if (contentOffset.x > self.frame.size.width) {
                _newIndex = _actualIndex + 1;
            }
            else {
                _newIndex = _actualIndex - 1;
            }
            
            if ([_extendedPageControllerDelegate respondsToSelector:@selector(extendedPageController:viewAtIndex:)]) {
                UIView * view = [_extendedPageControllerDelegate extendedPageController:self viewAtIndex:_newIndex];
                if (view) {
                    view.frame = CGRectMake((_newIndex > _actualIndex ? self.frame.size.width*2 : 0), view.frame.origin.y, view.frame.size.width, view.frame.size.height);
                    [self addSubview:view];
                }
                
                _newMainView = view;
                _newMainView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                _newMainView.autoresizesSubviews = YES;
            }
        }
        
        _isScrolling = YES;
        
        int newX = abs(self.frame.size.width - contentOffset.x);
        float newScale = 1 - (newX > 0 ? (float)newX/self.frame.size.width : 1)*(newX > 0 ? (float)newX/self.frame.size.width : 1)*2;
        
        if (newScale < 0) {
            newScale = -newScale;
        }
        if (newScale < maxScale) {
            newScale = maxScale;
        }
        if (newScale > 1.) {
            newScale = 1.;
        }
        
        [self _resetView:_mainView withScaleFactor:newScale];
        
        if (_newMainView) {
            [self _resetView:_newMainView withScaleFactor:newScale];
        }
        
        
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self _rearrangeViews];
}



#pragma mark - private methods

- (void)_rearrangeViews {
    _isScrolling = NO;
    
    if (self.contentOffset.x == self.frame.size.width) {
        [_newMainView removeFromSuperview];
        _newMainView = nil;
    }
    else {
        _actualIndex = _newIndex;
        _mainView = _newMainView;
        _newMainView = nil;
        
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
        
        [self addSubview:_mainView];
        _mainView.frame = [self _frameForMainView];
        self.contentOffset = CGPointMake(_mainView.frame.size.width, 0);
        
    }
}

- (CGRect)_frameForMainView {
    return CGRectMake(self.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (void)_resetView: (UIView *)view withScaleFactor: (float)scaleFactor {
    view.transform = CGAffineTransformMakeScale(scaleFactor, scaleFactor);
    
    if (_displayBorder) {
        float borderAlpha = 1. - (scaleFactor-maxScale) / (1. - maxScale);
        view.layer.borderColor = [UIColor colorWithWhite:1. alpha:borderAlpha].CGColor;
        view.layer.borderWidth = vBorderWidth;
    }
}

@end
