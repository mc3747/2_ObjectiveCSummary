//
//  BSYLoading.h
//  BSYLoading
//
//  Created by 白仕云 on 2018/5/17.
//  Copyright © 2018年 BSY.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BSYLoading : NSObject

// #############################################   无文本信息       ###################################

/**
 隐藏菊花
 */
+(void)hidenCrazyCircleAnimation;

/**
 菊花
 */
+(void)showCrazyCircle;

/**
 菊花颜色自定义
  @param CircleColor 菊花颜色
 */
+(void)showCrazyCircleWithColor:(UIColor *)CircleColor;

/**
 菊花颜色自定义  背景颜色自定义
 @param BgColor 背景颜色
 @param CircleColor 菊花颜色
 */
+(void)showCrazyCircleWithColor:(UIColor *)CircleColor BgColor:(UIColor *)BgColor;

// #############################################   有文本信息       ###################################

/**
 文字和菊花
@param text 文本信息
 */
+(void)showCrazyCircleWithText:(NSString *)text;


/**
  文字和菊花
 @param CircleColor 菊花颜色
 @param text 文本信息
 */
+(void)showCrazyCircleWithColor:(UIColor *)CircleColor Text:(NSString *)text;

/**
 文字和菊花
 @param CircleColor 菊花颜色
 @param text 文本信息
 @param TextColor 文本颜色
 */
+(void)showCrazyCircleWithColor:(UIColor *)CircleColor Text:(NSString *)text TextColor:(UIColor *)TextColor;


/**
 文字菊花效果
 @param CircleColor 菊花颜色
 @param BgColor 波浪背景颜色
 @param text 文本信息
 @param TextColor 文本颜色
 */
+(void)showCrazyCircleWithColor:(UIColor *)CircleColor BgColor:(UIColor *)BgColor Text:(NSString *)text TextColor:(UIColor *)TextColor;

/**
 文字和菊花
 @param CircleColor 菊花颜色
 @param BgColor 波浪背景颜色
 @param text 文本信息
 @param TextColor 文本颜色
 @param TextFont 文本字体
 */

+(void)showCrazyCircleWithColor:(UIColor *)CircleColor BgColor:(UIColor *)BgColor Text:(NSString *)text TextColor:(UIColor *)TextColor TextFont:(CGFloat)TextFont;

/**
 文字和菊花
 @param CircleColor 菊花颜色
 @param BgColor 波浪背景颜色
 @param text 文本信息
 @param TextColor 文本颜色
 @param TextFont 文本字体
 @param TextAlignment 文本对其方法
 */
+(void)showCrazyCircleWithColor:(UIColor *)CircleColor BgColor:(UIColor *)BgColor Text:(NSString *)text TextColor:(UIColor *)TextColor TextFont:(CGFloat)TextFont TextAlignment:(NSTextAlignment)TextAlignment;
@end
