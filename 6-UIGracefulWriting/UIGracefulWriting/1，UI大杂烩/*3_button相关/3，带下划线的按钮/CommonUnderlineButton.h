//
//  CommonUnderlineButton.h
//  GjFax
//
//  Created by gjfax on 2018/4/13.
//  Copyright © 2018年 GjFax. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommonUnderlineButton;
typedef void(^UnderlineButtonClickBlock)(CommonUnderlineButton *button);

@interface CommonUnderlineButton : UIButton
//下划线普通颜色
@property (nonatomic, strong) UIColor *lineNormalColor;
//下划线高亮颜色
@property (nonatomic, strong) UIColor *lineHighlightColor;
//下划线距离按钮文字的距离
@property (nonatomic, assign) CGFloat underDistance;
//回调block
@property (nonatomic, copy) UnderlineButtonClickBlock clickBlock;

//自定义初始化方法
- (instancetype)initWithButtonFrame:(CGRect)frame
                    textNormalColor:(UIColor *)textNormalColor
                 textHighlightColor:(UIColor *)textHighlightColor
                    lineNormalColor:(UIColor *)lineNormalColor
                 lineHighlightColor:(UIColor *)lineHighlightColor
                      underDistance:(CGFloat)underDistance
                         clickBlock:(UnderlineButtonClickBlock)clickBlock;
@end
