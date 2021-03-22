//
//  UIView+Util.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/6/26.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "UIView+Util.h"

@implementation UIView (Util)

- (void)removeAllSubviews {
    for (__strong UIView *subView in self.subviews) {
        [subView removeFromSuperview];
        subView = nil;
    }
}

@end
