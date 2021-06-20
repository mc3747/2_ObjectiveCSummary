//
//  UIColor+Category.h
//  UIGracefulWriting
//
//  Created by gjfax on 2018/9/28.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, MACColorType) {
    MACColorTypeRed   = 1,
    MACColorTypeGreen = 2,
    MACColorTypeBlue  = 3,
    MACColorTypeAlpha = 4
};

@interface UIColor (Category)
//颜色的色彩空间：即使用的色彩标准
- (CGColorSpaceModel) colorSpaceModel;

//将任意颜色的RGBA取出
- (CGFloat) red;
- (CGFloat) green;
- (CGFloat) blue;
- (CGFloat) alpha;

//取出一种颜色的对比色
- (UIColor *)reverseColor;
//打印一种颜色的RGBA值
- (NSString *)printDetail;

//增加或者减小RGBA中的任意元素值
- (UIColor *)up:(MACColorType)type num:(NSInteger)num;
- (UIColor *)down:(MACColorType)type num:(NSInteger)num;

@end


