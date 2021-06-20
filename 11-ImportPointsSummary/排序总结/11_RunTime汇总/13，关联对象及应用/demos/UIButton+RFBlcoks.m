//
//  UIButton+RFBlcoks.m
//  AssociatedObjectDemo
//
//  Created by 王若风 on 4/14/16.
//  Copyright © 2016 王若风. All rights reserved.
//

#import "UIButton+RFBlcoks.h"
#import <objc/runtime.h>

static char kButttonClickBlockKey;

@implementation UIButton (RFBlcoks)

- (RFButtonClickBlock)rf_buttonClickBlock
{
    return objc_getAssociatedObject(self, &kButttonClickBlockKey);
}

- (void)setRf_buttonClickBlock:(RFButtonClickBlock)rf_buttonClickBlock
{
    objc_setAssociatedObject(self, &kButttonClickBlockKey, rf_buttonClickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClicked
{
    if (self.rf_buttonClickBlock) {
        self.rf_buttonClickBlock(self);
    }
}

@end
