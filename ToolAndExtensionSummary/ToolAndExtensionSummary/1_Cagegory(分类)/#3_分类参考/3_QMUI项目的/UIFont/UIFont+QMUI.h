//
//  UIFont+QMUI.h
//  qmui
//
//  Created by ZhoonChen on 15/7/20.
//  Copyright (c) 2015年 QMUI Team. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, QMUIFontWeight) {
    QMUIFontWeightLight,
    QMUIFontWeightNormal,
    QMUIFontWeightBold
};

@interface UIFont (QMUI)

/**
 *  返回系统字体的细体
 *
 *  @param fontSize 字体大小
 *
 *  @return 变细的系统字体的 UIFont 对象
 */
+ (UIFont *)qmui_lightSystemFontOfSize:(CGFloat)fontSize;

/**
 *  根据需要生成一个 UIFont 对象并返回
 *  @param size     字号大小
 *  @param weight   字体粗细
 *  @param italic   是否斜体
 */
+ (UIFont *)qmui_systemFontOfSize:(CGFloat)size
                           weight:(QMUIFontWeight)weight
                           italic:(BOOL)italic;

/**
 *  根据需要生成一个支持响应动态字体大小调整的 UIFont 对象并返回
 *  @param  size    字号大小
 *  @param  weight  字重
 *  @param  italic  是否斜体
 *  @return         支持响应动态字体大小调整的 UIFont 对象
 */
+ (UIFont *)qmui_dynamicSystemFontOfSize:(CGFloat)size
                                  weight:(QMUIFontWeight)weight
                                  italic:(BOOL)italic;

/**
 *  返回支持动态字体的UIFont，支持定义最小和最大字号
 *
 *  @param pointSize        默认的size
 *  @param upperLimitSize   最大的字号限制
 *  @param lowerLimitSize   最小的字号显示
 *  @param weight           字重
 *  @param italic           是否斜体
 *
 *  @return                 支持响应动态字体大小调整的 UIFont 对象
 */
+ (UIFont *)qmui_dynamicSystemFontOfSize:(CGFloat)pointSize
                          upperLimitSize:(CGFloat)upperLimitSize
                          lowerLimitSize:(CGFloat)lowerLimitSize
                                  weight:(QMUIFontWeight)weight
                                  italic:(BOOL)italic;

@end
