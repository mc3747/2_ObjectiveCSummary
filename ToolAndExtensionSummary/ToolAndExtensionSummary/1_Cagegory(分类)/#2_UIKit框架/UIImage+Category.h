//
//  UIImage+Category.h
//  ToolAndExtensionSummary
//
//  Created by gjfax on 2018/6/15.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)

// 颜色返回纯色图片（无尺寸）
+ (UIImage *)imageWithColor:(UIColor *)color;

// 返回纯色图片（有尺寸）
+ (UIImage *)js_createImageWithColor:(UIColor *)color withSize:(CGSize)imageSize;

// 返回圆角图片
+ (UIImage *)js_imageWithOriginalImage:(UIImage *)originalImage andCornerRadius:(CGFloat)cornerRadius;

// 返回纯色+圆角图片
+ (UIImage *)js_createRoundedImageWithColor:(UIColor *)color andCornerRadius:(CGFloat)cornerRadius withSize:(CGSize)imageSize;

//生成带圆环的圆角图片: originalImage 原始图片 + borderColor   圆环颜色 +borderWidth   圆环宽度
+ (UIImage *)js_imageWithOriginalImage:(UIImage *)originalImage withBorderColor:(UIColor *)borderColor withBorderWidth:(CGFloat)borderWidth;

//生成背景图：带阴影，模糊效果
+ (UIImage *) imageWithBackgroundColor:(UIColor *)bgColor
                           shadeAlpha1:(CGFloat)alpha1
                           shadeAlpha2:(CGFloat)alpha2
                           shadeAlpha3:(CGFloat)alpha3
                           shadowColor:(UIColor *)shadowColor
                          shadowOffset:(CGSize)shadowOffset
                            shadowBlur:(CGFloat)shadowBlur
                                 image:(UIImage *)originalImage;
//生成背景图：带阴影，模糊效果
+ (UIImage *)imageWithShadowColor:(UIColor *)shadowColor
                     shadowOffset:(CGSize)shadowOffset
                       shadowBlur:(CGFloat)shadowBlur
                            image:(UIImage *)originalImage;
@end
