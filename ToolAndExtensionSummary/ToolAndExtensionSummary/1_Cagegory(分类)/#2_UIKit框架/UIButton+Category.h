//
//  UIButton+Category.h
//  ToolAndExtensionSummary
//
//  Created by gjfax on 2018/6/14.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <UIKit/UIKit.h>
struct ClickSize {
    CGFloat top;
    CGFloat left;
    CGFloat bottom;
    CGFloat right;
};
typedef struct ClickSize ClickSize;

CG_INLINE ClickSize
ClickSizeMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
{

    ClickSize clickSize;
    clickSize.top = top;
    clickSize.left = left;
    clickSize.bottom = bottom;
    clickSize.right = right;
    return clickSize;
};

/*
知识点：
 1，自定义结构体，简化入参
 2，按钮扩大点击范围
 3，按钮点击事件，传递多个参数
 4，按钮防重复点击
 5，
 */
@interface UIButton (Category)

 //扩大button的点击范围（2种方法都可以）
- (void)enlargeClickAreaWithSize:(UIEdgeInsets)size;
//- (void)enlargeClickAreaWithSize:(ClickSize)size;

 //周围的距离相等
- (void)enlargeClickAreaWithGap:(CGFloat)gap;
@end
