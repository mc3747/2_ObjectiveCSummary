//
//  UIImageView+JMRadius.h
//  JMRoundedCornerDemo
//
//  Created by 饶志臻 on 2016/10/9.
//  Copyright © 2016年 饶志臻. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+JMRadius.h"

@interface UIImageView (JMRadius)

/**设置圆角背景图，默认 UIViewContentModeScaleAspectFill 模式*/
- (void)jm_setImageWithCornerRadius:(CGFloat)radius
                           imageURL:(NSURL *)imageURL
                        placeholder:(UIImage *)placeholder
                               size:(CGSize)size;

/**设置圆角背景图，默认 UIViewContentModeScaleAspectFill 模式*/
- (void)jm_setImageWithJMRadius:(JMRadius)radius
                       imageURL:(NSURL *)imageURL
                    placeholder:(UIImage *)placeholder
                           size:(CGSize)size;

/**设置 contentMode 模式的圆角背景图*/
- (void)jm_setImageWithCornerRadius:(CGFloat)radius
                           imageURL:(NSURL *)imageURL
                        placeholder:(UIImage *)placeholder
                        contentMode:(UIViewContentMode)contentMode
                               size:(CGSize)size;

/**设置 contentMode 模式的圆角背景图*/
- (void)jm_setImageWithJMRadius:(JMRadius)radius
                       imageURL:(NSURL *)imageURL
                    placeholder:(UIImage *)placeholder
                    contentMode:(UIViewContentMode)contentMode
                           size:(CGSize)size;

/**配置所有属性配置圆角背景图*/
- (void)jm_setImageWithJMRadius:(JMRadius)radius
                       imageURL:(NSURL *)imageURL
                    placeholder:(UIImage *)placeholder
                    borderColor:(UIColor *)borderColor
                    borderWidth:(CGFloat)borderWidth
                backgroundColor:(UIColor *)backgroundColor
                    contentMode:(UIViewContentMode)contentMode
                           size:(CGSize)size;

@end
