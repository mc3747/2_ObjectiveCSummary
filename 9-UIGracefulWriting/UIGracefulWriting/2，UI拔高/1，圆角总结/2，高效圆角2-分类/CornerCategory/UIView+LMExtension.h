//
//  UIView+Extension.h
//  CornerViewDemo
//
//  Created by lemon on 2018/8/29.
//  Copyright © 2018年 Lemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LMExtension)
- (void)lm_addCorner:(CGFloat)radius;
- (void)lm_addCorner:(CGFloat)radius
         borderWidth:(CGFloat)borderWidth
         borderColor:(UIColor *)borderColor
     backGroundColor:(UIColor*)bgColor;
@end
