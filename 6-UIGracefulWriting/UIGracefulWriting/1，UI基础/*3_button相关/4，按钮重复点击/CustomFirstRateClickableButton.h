//
//  CustomFirstRateButton.h
//  GjFax
//
//  Created by yangyong on 2017/2/24.
//  Copyright © 2017年 GjFax. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ButtonStateType)
{
    //    类型（1：正常状态（可点击）；2：未激活状态（可点击）；3：未激活状态（不可点击）；4：执灰状态（不可点击））
    ButtonStateTypeNormal                   = 1,
    ButtonStateTypeNotActiveCanClick        = 2,
    ButtonStateTypeNotActiveNotClick        = 3,
    ButtonStateTypeForbidden                = 4,
};

typedef void(^UIButtonClickHandle)(UIButton *view);

@interface CustomFirstRateClickableButton : UIButton
//回调block
@property (nonatomic, copy) UIButtonClickHandle clickHandle;
//按钮状态
@property (nonatomic, assign) ButtonStateType buttonStateType;

- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)title
                 cornerRadius:(CGFloat)cornerRadius
              buttonStateType:(ButtonStateType)buttonStateType                       ;

- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)title
              buttonStateType:(ButtonStateType)buttonStateType
                  normalImage:(NSString *)normalImage
             highlightedImage:(NSString *)highlighted
                 cornerRadius:(CGFloat)cornerRadius;


- (void)setTitle:(NSString *)title cornerRadius:(CGFloat)cornerRadius  buttonStateType:(ButtonStateType)buttonStateType;


/**显示加载状态*/
- (void)showLoadingStatus;

/**隐藏加载状态*/
- (void)hiddenLoadingStatus;

@end
