//
//  UIButton+Category.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/9/5.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "UIButton+Category.h"
#import <objc/runtime.h>

@implementation UIButton (Category)
/**
 *  设置纯色的背景图
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self setBackgroundImage:[UIButton imageWithColor:backgroundColor] forState:state];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark -- 增加点击事件
- (void)GJSHandleCallBack:(ButtonClickCallback)callBack {
    [self GJSHandleClickEvent:UIControlEventTouchUpInside callBack:callBack];
}

#pragma mark -  通用点击事件
static char *overViewKey;

- (void)GJSHandleClickEvent:(UIControlEvents)aEvent
                   callBack:(ButtonClickCallback)callBack
{
    objc_setAssociatedObject(self, &overViewKey, callBack, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(buttonClick) forControlEvents:aEvent];
}

- (void)buttonClick {
    ButtonClickCallback callBack = objc_getAssociatedObject(self, &overViewKey);
    if (callBack!= nil)
    {
        callBack(self);
    }
}
@end
