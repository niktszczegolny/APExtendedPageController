//
//  APExtendedPageController.h
//  APExtendedPageController
//
//  Created by Andrzej on 03.04.2013.
//  Copyright (c) 2013 apuczyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class APExtendedPageController;
@protocol APExtendedPageControllerDelegate <NSObject>
#warning AP: You must implement this method!
- (UIView *)extendedPageController: (APExtendedPageController *)extendedPageController
                       viewAtIndex: (NSInteger)index;
@end




@interface APExtendedPageController : UIScrollView <UIScrollViewDelegate> {
    id <APExtendedPageControllerDelegate> _extendedPageControllerDelegate;
    
    UIView * _mainView;
    NSInteger _actualIndex;
    
    BOOL _displayBorder;
}

@property (nonatomic) id extendedPageControllerDelegate;
@property (nonatomic, readonly) UIView * mainView;
@property (nonatomic, readonly) NSInteger actualIndex;

@property (nonatomic) BOOL displayBorder;

-               (id)initWithFrame: (CGRect)frame
                         mainView: (UIView *)mainView
   extendedPageControllerDelegate: (id)extendedPageControllerDelegate;

@end
