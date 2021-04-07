//
//  WXNavigationBar.m
//  排序总结
//
//  Created by gjfax on 2020/3/12.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "WXNavigationBar.h"
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)



///MARK:  iPhone X 刘海屏系列宏定义判断（适用目前所有的iPhone刘海屏）
#define INTERFACE_IS_IPHONEX  (@available(iOS 11.0, *) && ([UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom > 0)?YES:NO)


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
                        if (INTERFACE_IS_IPHONEX) {
                            frame.size.height = 88;
                        }
                        view.frame = frame;
                    }
                    if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarContentView")]) {
                        CGRect frame = view.frame;
                        frame.origin.y = 20;
                        if (INTERFACE_IS_IPHONEX) {
                            frame.origin.y = 44;
                        }
                        view.frame = frame;
                    }
                }
            }
        }

@end
