//
//  UIButton+Category.h
//  UIGracefulWriting
//
//  Created by gjfax on 2018/9/5.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonClickCallback)(UIButton* button);

@interface UIButton (Category)
/**
 *  设置纯色的背景图
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

/**
 *  增加UIButton的通用事件
 */
- (void)GJSHandleClickEvent:(UIControlEvents)aEvent
                   callBack:(ButtonClickCallback)callBack;

/**
 *  增加UIButton的点击事件
 */
- (void)GJSHandleCallBack:(ButtonClickCallback)callBack;
@end
