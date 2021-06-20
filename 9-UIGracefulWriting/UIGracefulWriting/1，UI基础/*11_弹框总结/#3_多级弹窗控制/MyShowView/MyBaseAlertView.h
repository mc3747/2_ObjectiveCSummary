//
//  MyBaseAlertView.h
//  AlertViewDemo
//
//  Created by LeeMiao on 2019/8/12.
//  Copyright © 2019 LiMiao. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 动画效果

 - MyBaseAlertViewAnimationTypeScaleInCenter: 中间缩放动画
 - MyBaseAlertViewAnimationTypeMoveFromTopToBottom: 移动动画 从上到下
 - MyBaseAlertViewAnimationTypeMoveFromBottomToTop: 移动动画 从下到上
 - MyBaseAlertViewAnimationTypeMoveFromTopToTop: 移动动画 从上到上
 - MyBaseAlertViewAnimationTypeMoveFromBottomToBottom: 移动动画 从下到下
 */
typedef NS_ENUM(NSUInteger, MyBaseAlertViewAnimationType) {
    MyBaseAlertViewAnimationTypeScaleInCenter,
    MyBaseAlertViewAnimationTypeMoveFromTopToBottom,
    MyBaseAlertViewAnimationTypeMoveFromBottomToTop,
    MyBaseAlertViewAnimationTypeMoveFromTopToTop,
    MyBaseAlertViewAnimationTypeMoveFromBottomToBottom,
};


@interface MyBaseAlertView : UIView


@property (nonatomic,assign) MyBaseAlertViewAnimationType animationType;   // 动画类型


/**
 显示

 @param contentView 弹框中的内容
 */
- (void)showContentView:(UIView *)contentView;


/**
 消失当前弹框
 */
- (void)dissmissContentView;

@end

