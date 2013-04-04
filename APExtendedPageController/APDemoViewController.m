//
//  APViewController.m
//  APExtendedPageController
//
//  Created by Andrzej on 03.04.2013.
//  Copyright (c) 2013 apuczyk. All rights reserved.
//

#import "APDemoViewController.h"

@interface APDemoViewController ()

@end

@implementation APDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView * view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor colorWithRed:100/255. green:50/255. blue:0/255. alpha:1.];
    
	_pageController = [[APExtendedPageController alloc] initWithFrame:self.view.bounds
                                                             mainView:view
                                       extendedPageControllerDelegate:self];
    
    [self.view addSubview:_pageController];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

#define randomFloat ((float)(rand()%255))/255.

- (UIView *)extendedPageController:(APExtendedPageController *)extendedPageController
                       viewAtIndex:(NSInteger)index
{
    
    if (index >= 0 && index <= 10) {
        UIView * view = [[UIView alloc] initWithFrame:extendedPageController.frame];
        view.backgroundColor = [UIColor colorWithRed:randomFloat green:randomFloat blue:randomFloat alpha:1.];
        
        UILabel * lbl = [[UILabel alloc] initWithFrame:extendedPageController.frame];
        lbl.backgroundColor = [UIColor clearColor];
        lbl.textAlignment = UITextAlignmentCenter;
        lbl.textColor = [UIColor whiteColor];
        lbl.text = [NSString stringWithFormat:@"Page no. %d", index];
        lbl.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [view addSubview:lbl];
        
        
        return view;
    }
    
    return nil;
}

@end
