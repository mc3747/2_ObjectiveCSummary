//
//  UIImageView+Extension.m
//  CornerViewDemo
//
//  Created by lemon on 2018/8/29.
//  Copyright © 2018年 Lemon. All rights reserved.
//

#import "UIImageView+LMExtension.h"
#import "UIView+LMExtension.h"


@interface UIImage (LMExtension)
- (UIImage *)lm_drawRectWithRoundedCorner:(CGFloat)radius
                                     size:(CGSize)size;
@end

@implementation UIImage (LMExtension)
- (UIImage *)lm_drawRectWithRoundedCorner:(CGFloat)radius
                                     size:(CGSize)size{
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, false, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CGContextAddPath(context, path.CGPath);
    
    CGContextClip(context);
    
    [self drawInRect:rect];
    CGContextDrawPath(context, kCGPathFillStroke);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  image;
}
@end

@implementation UIImageView (LMExtension)
- (void)lm_addCorner:(CGFloat)radius{
    if (self.image){
        self.image = [self.image lm_drawRectWithRoundedCorner:radius size:self.bounds.size];
    }
}
@end

