//
//  UIViewController+RFPresentPopover.m
//  AssociatedObjectDemo
//
//  Created by 王若风 on 4/14/16.
//  Copyright © 2016 王若风. All rights reserved.
//

#import "UIViewController+RFPresentPopover.h"
#import <objc/runtime.h>

#pragma clang diagnostic ignored "-Wdeprecated-declarations"

static const char kPopoverController;

@interface UIViewController (RFPresentPopoverHidden)<UIPopoverControllerDelegate>

@property (nonatomic, strong) UIPopoverController *rf_poperController;

@end

@implementation UIViewController (RFPresentPopoverHidden)

- (void)setRf_poperController:(UIPopoverController *)rf_poperController
{
    objc_setAssociatedObject(self, &kPopoverController, rf_poperController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIPopoverController *)rf_poperController
{
    return objc_getAssociatedObject(self, &kPopoverController);
}

@end

@implementation UIViewController (RFPresentPopover)

- (void)rf_presentPopoverWithViewController:(UIViewController *)viewController
                                   fromRect:(CGRect)fromRect
                                     inView:(UIView *)inView
                   permittedArrowDirections:(UIPopoverArrowDirection)permittedArrowDirections
                                   animated:(BOOL)animated
{
    self.rf_poperController = [[UIPopoverController alloc] initWithContentViewController:viewController];
    self.rf_poperController.delegate = self;
    
    [self.rf_poperController presentPopoverFromRect:fromRect inView:inView permittedArrowDirections:permittedArrowDirections animated:animated];
}

- (void)rf_dismissPopoverAnimated:(BOOL)animated
{
    [self.rf_poperController dismissPopoverAnimated:animated];
}

#pragma mark - UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.rf_poperController = nil;
}

@end