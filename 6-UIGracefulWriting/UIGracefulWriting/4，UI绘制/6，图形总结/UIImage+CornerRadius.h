//
//  UIImage+CornerRadius.h
//  WHLatticeDemo
//
//  Created by gjfax on 2019/2/22.
//  Copyright © 2019 remember17. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (CornerRadius)

- (UIImage *)roundedCornerImageWithCornerRadius:(CGFloat)cornerRadius;

/* On-screen-renderring绘制UIImage矩形圆角 */
- (UIImage *)imageWithCornerRadius:(CGFloat)radius ofSize:(CGSize)size;

//圆角
- (UIImage *)circleImage;

@end

NS_ASSUME_NONNULL_END
