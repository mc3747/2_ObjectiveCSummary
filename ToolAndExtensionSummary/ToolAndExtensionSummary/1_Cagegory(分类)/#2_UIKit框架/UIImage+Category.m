//
//  UIImage+Category.m
//  ToolAndExtensionSummary
//
//  Created by gjfax on 2018/6/15.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)
// 颜色返回纯色图片
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
@end
