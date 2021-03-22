//
//  UIViewController+RFPresentPopover.h
//  AssociatedObjectDemo
//
//  Created by 王若风 on 4/14/16.
//  Copyright © 2016 王若风. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (RFPresentPopover)

- (void)rf_presentPopoverWithViewController:(UIViewController *)viewController
                                   fromRect:(CGRect)fromRect
                                     inView:(UIView *)inView
                   permittedArrowDirections:(UIPopoverArrowDirection)permittedArrowDirections
                                   animated:(BOOL)aimated;

- (void)rf_dismissPopoverAnimated:(BOOL)animated;

@end
