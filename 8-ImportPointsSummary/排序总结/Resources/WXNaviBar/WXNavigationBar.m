//
//  WXNavigationBar.m
//  排序总结
//
//  Created by gjfax on 2020/3/12.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "WXNavigationBar.h"
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
@implementation WXNavigationBar

- (void)layoutSubviews
        {
            [super layoutSubviews];
            CGFloat systemVersion = [UIDevice currentDevice].systemVersion.floatValue;
            for (UIView *view in self.subviews) {
                if (systemVersion >= 11.0) {
                    if ([view isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
                        CGRect frame = view.frame;
                        frame.size.height = 64;
                        if (IS_IPHONE_X) {
                            frame.size.height = 88;
                        }
                        view.frame = frame;
                    }
                    if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarContentView")]) {
                        CGRect frame = view.frame;
                        frame.origin.y = 20;
                        if (IS_IPHONE_X) {
                            frame.origin.y = 44;
                        }
                        view.frame = frame;
                    }
                }
            }
        }

@end
