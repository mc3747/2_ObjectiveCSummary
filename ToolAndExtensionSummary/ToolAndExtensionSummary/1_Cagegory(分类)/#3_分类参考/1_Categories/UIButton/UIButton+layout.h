//
//  UIButton+layout.h
//  ToolAndExtensionSummary
//
//  Created by gjfax on 2019/12/17.
//  Copyright © 2019 macheng. All rights reserved.
//

// =====================================================
/*
 button自带的iamge和title的关系分类
 */
// =====================================================
typedef NS_ENUM(NSInteger, LYButtonLayoutStyle) {
    LYButtonLayoutStyleImagePositionLeft = 0,
    LYButtonLayoutStyleImagePositionRight,
    LYButtonLayoutStyleImagePositionTop,
    LYButtonLayoutStyleImagePositionBottom,
};

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (layout)
- (void)layoutWithStyle:(LYButtonLayoutStyle)style andSpacing:(CGFloat)spacing;

@end

NS_ASSUME_NONNULL_END
