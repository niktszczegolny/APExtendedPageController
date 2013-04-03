//
//  APViewController.h
//  APExtendedPageController
//
//  Created by Andrzej on 03.04.2013.
//  Copyright (c) 2013 apuczyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APExtendedPageController.h"

@interface APDemoViewController : UIViewController <APExtendedPageControllerDelegate> {
    APExtendedPageController * _pageController;
}

@end
