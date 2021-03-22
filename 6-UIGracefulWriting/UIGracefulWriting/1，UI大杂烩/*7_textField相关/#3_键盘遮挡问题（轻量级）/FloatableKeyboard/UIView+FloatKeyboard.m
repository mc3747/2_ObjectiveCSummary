//
//  UIView+FloatKeyboard.m
//  keyboardDemo
//
//  Created by anjohnlv on 2017/8/11.
//  Copyright © 2017年 anjohnlv. All rights reserved.
//

#import "UIView+FloatKeyboard.h"
#import <objc/runtime.h>

static const void *kFloatableKey    = @"floatableKey";

@implementation UIView (FloatKeyboard)

- (BOOL)floatable {
    return [objc_getAssociatedObject(self, kFloatableKey) boolValue];
}

- (void)setFloatable:(BOOL)floatable {
    objc_setAssociatedObject(self, kFloatableKey, [NSNumber numberWithBool:floatable], OBJC_ASSOCIATION_ASSIGN);
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGFloat keyboardHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    CGFloat screenHeight = [[[UIApplication sharedApplication]keyWindow]bounds].size.height;
    CGFloat selfBottom = [self.superview convertRect:self.frame toView:[self viewController].view].origin.y + self.frame.size.height;
    CGFloat offset = selfBottom+keyboardHeight-screenHeight;
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            [self viewController].view.frame = CGRectMake(0.0f, -offset, [self viewController].view.frame.size.width, [self viewController].view.frame.size.height);
        }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self viewController].view.frame = CGRectMake(0, 0, [self viewController].view.frame.size.width, [self viewController].view.frame.size.height);
    }];
}

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

-(BOOL)becomeFirstResponder {
    if (self.floatable) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return [super becomeFirstResponder];
}

-(BOOL)resignFirstResponder {
    BOOL b = [super resignFirstResponder];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    return b;
}

@end

