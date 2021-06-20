//
//  CustomFirstRateButton.m
//  GjFax
//
//  Created by yangyong on 2017/2/24.
//  Copyright © 2017年 GjFax. All rights reserved.
//

#import "CustomFirstRateClickableButton.h"
#import "UIView+Extension.h"


#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBColorAlpha(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
//按钮正常背景色
#define COMMON_CLICKABLE_COLOR1 RGBColor(240, 103, 40)
//按钮按下背景色
#define COMMON_CLICKABLE_COLOR2 RGBColor(211, 74, 30)
//按钮未激活背景色
#define COMMON_CLICKABLE_COLOR3 RGBColor(250, 209, 190)
//按钮未激活按下背景色
#define COMMON_CLICKABLE_COLOR4 RGBColorAlpha(250, 209, 190, 0.7)
//文字基本颜色
#define COMMON_WHITE_COLOR  RGBColor(255, 255, 255)
//按钮不可点击灰色
#define COMMON_CLICKABLE_COLOR5 RGBColor(163, 163, 163)


@interface CustomFirstRateClickableButton ()
//是否圆角
@property (nonatomic, assign) BOOL isCornerRadius;
//加载方式
@property (nonatomic, weak) UIView *loadingView;
//加载框蒙版
@property (nonatomic, weak) UIView *loadingMaskingView;

@end


@implementation CustomFirstRateClickableButton
#pragma mark - 颜色背景button
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title cornerRadius:(CGFloat)cornerRadius buttonStateType:(ButtonStateType)buttonStateType
{
    if (self = [super init]) {
        
        self.frame = frame;
        _buttonStateType = buttonStateType;
        [self setTitle:title cornerRadius:cornerRadius buttonStateType:buttonStateType];
    }
    
    return self;
}
#pragma mark - 图片按钮背景button
- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)title
                 buttonStateType:(ButtonStateType)buttonStateType
                  normalImage:(NSString *)normalImage
             highlightedImage:(NSString *)highlighted
                 cornerRadius:(CGFloat)cornerRadius
{
    if ([self initWithFrame:frame title:title cornerRadius:cornerRadius buttonStateType:buttonStateType]) {
        
        if (normalImage && normalImage.length > 0) {
            [self setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
        }
        if (normalImage && normalImage.length > 0) {
            [self setImage:[UIImage imageNamed:highlighted] forState:UIControlStateHighlighted];
        }
        
    }
    return self;
}

#pragma mark - 显示text（既改变文字，也改变状态）
- (void)setTitle:(NSString *)title cornerRadius:(CGFloat)cornerRadius buttonStateType:(ButtonStateType)buttonStateType
{
    _buttonStateType = buttonStateType;
//是否圆角
    if (cornerRadius > 0) {
        self.layer.cornerRadius = cornerRadius;
        self.layer.masksToBounds = YES;
        [self setColorWithState:buttonStateType];
        
    } else {
        [self setColorWithState:buttonStateType];
    };
        
    [self setTitle:title forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:18];
   
//防重复点击监听
    [self addTarget:self action:@selector(firstActionRepeatDown:) forControlEvents:UIControlEventTouchUpInside];
    _isCornerRadius = cornerRadius;
}

#pragma mark - 外部改变状态时调用:(不改变文字，只改变按钮状态)
- (void)setButtonStateType:(ButtonStateType)buttonStateType {
    _buttonStateType = buttonStateType;
    [self setColorWithState:buttonStateType];
    
}
#pragma mark - 改变button颜色信息
-  (void)setColorWithState:(ButtonStateType )buttonState {
    
    if (ButtonStateTypeNormal == buttonState) {
        self.enabled = YES;
        [self getButtonWithBackgroundColor1:COMMON_CLICKABLE_COLOR1 withBackgroundColor2:COMMON_CLICKABLE_COLOR2 withBackgroundColor3:COMMON_CLICKABLE_COLOR1 withTextColor1:COMMON_WHITE_COLOR withTextColor2:COMMON_WHITE_COLOR withTextColor3:COMMON_WHITE_COLOR];
        
    } else if (ButtonStateTypeNotActiveCanClick == buttonState ) {
        self.enabled = YES;
         [self getButtonWithBackgroundColor1:COMMON_CLICKABLE_COLOR3 withBackgroundColor2:COMMON_CLICKABLE_COLOR4 withBackgroundColor3:COMMON_CLICKABLE_COLOR4 withTextColor1:COMMON_WHITE_COLOR withTextColor2:COMMON_WHITE_COLOR withTextColor3:COMMON_WHITE_COLOR];
        
    } else if (ButtonStateTypeNotActiveNotClick == buttonState) {
        self.enabled = NO;
        [self getButtonWithBackgroundColor1:COMMON_CLICKABLE_COLOR3 withBackgroundColor2:COMMON_CLICKABLE_COLOR3 withBackgroundColor3:COMMON_CLICKABLE_COLOR3 withTextColor1:COMMON_WHITE_COLOR withTextColor2:COMMON_WHITE_COLOR withTextColor3:COMMON_WHITE_COLOR];
        
    } else if (ButtonStateTypeForbidden == buttonState) {
        self.enabled = NO;
        [self getButtonWithBackgroundColor1:COMMON_CLICKABLE_COLOR5 withBackgroundColor2:COMMON_CLICKABLE_COLOR5 withBackgroundColor3:COMMON_CLICKABLE_COLOR5 withTextColor1:COMMON_WHITE_COLOR withTextColor2:COMMON_WHITE_COLOR withTextColor3:COMMON_WHITE_COLOR];
    }
}

- (void)getButtonWithBackgroundColor1:(UIColor *)backgroundColor1
                                     withBackgroundColor2:(UIColor *)backgroundColor2
                                     withBackgroundColor3:(UIColor *)backgroundColor3
                                     withTextColor1:(UIColor *)textColor1
                                     withTextColor2:(UIColor *)textColor2
                                     withTextColor3:(UIColor *)textColor3 {
    
    [self setBackgroundColor:backgroundColor1 forState:UIControlStateNormal];
    [self setBackgroundColor:backgroundColor2 forState:UIControlStateHighlighted];
    [self setBackgroundColor:backgroundColor3 forState:UIControlStateDisabled];
    
    [self setTitleColor:textColor1 forState:UIControlStateNormal];
    [self setTitleColor:textColor2 forState:UIControlStateHighlighted];
    [self setTitleColor:textColor3 forState:UIControlStateDisabled];
}


#pragma mark - 监听重复点击
- (void)firstActionRepeatDown:(UIButton *)btn
{
    btn.enabled = NO;
    // 状态点击回调
    if (_clickHandle) {
        _clickHandle(btn);
    }
    if (ButtonStateTypeNormal == _buttonStateType) {
            [self setBackgroundColor:COMMON_CLICKABLE_COLOR2 forState:UIControlStateDisabled];
    } else if (ButtonStateTypeNotActiveCanClick == _buttonStateType) {
            [self setBackgroundColor:COMMON_CLICKABLE_COLOR4 forState:UIControlStateDisabled];
    };
    
    [self performSelector:@selector(firstBtnClick:) withObject:btn afterDelay:0.2];
}

#pragma mark -  延迟0.2s后按钮可以点击了
- (void)firstBtnClick:(UIButton *)btn
{
        btn.enabled = YES;
    if (ButtonStateTypeNormal == _buttonStateType) {
        [self setBackgroundColor:COMMON_CLICKABLE_COLOR2 forState:UIControlStateDisabled];
    } else if (ButtonStateTypeNotActiveCanClick == _buttonStateType) {
        [self setBackgroundColor:COMMON_CLICKABLE_COLOR4 forState:UIControlStateDisabled];
    };
    
}

#pragma mark - 添加加载
- (void)showLoadingStatus
{
    self.enabled = NO;
    
    [self removeLoadingView];
    
    [self addLoadingView];
    
    [self addLoadingMasking];
}

//加载视图
- (void)addLoadingView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    view.backgroundColor = RGBColor(245, 226, 197);
    [self addSubview:view];
    _loadingView = view;
    UILabel *tips = [[UILabel alloc] initWithFrame:CGRectMake(self.width / 2.0 - 30, 0, 60, self.height)];
    tips.text = @"加载中";
    tips.textColor = COMMON_WHITE_COLOR;
    [view addSubview:tips];
    
    UIActivityIndicatorView *ac = [UIActivityIndicatorView new];
    ac.center = CGPointMake(self.width / 2.0 + 40, view.centerY);
    [ac startAnimating];
    [view addSubview:ac];
}

//加载蒙版
- (void)addLoadingMasking
{
    UIWindow *keyWindow = [[[UIApplication sharedApplication] windows] lastObject];
    if ([keyWindow isKindOfClass:NSClassFromString(@"UIRemoteKeyboardWindow")]) {
        keyWindow = [[UIApplication sharedApplication] windows][([[[UIApplication sharedApplication] windows] count] -2)] ;
    }
    
    //预留 nav 高度，可点击
    UIView *windowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, keyWindow.width, keyWindow.height)];
    
    windowView.backgroundColor = [UIColor clearColor];
    
    [keyWindow addSubview:windowView];
    _loadingMaskingView = windowView;
}

#pragma mark - 隐藏加载状态
- (void)hiddenLoadingStatus
{
    [self removeLoadingBgView];
    [self removeLoadingView];
    self.enabled = YES;
}

- (void)removeLoadingView
{
    if (_loadingView) {
        [_loadingView removeFromSuperview];
    }
}

- (void)removeLoadingBgView
{
    if (_loadingMaskingView) {
        [_loadingMaskingView removeFromSuperview];
    }
}
#pragma mark -  返回纯色背景
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self setBackgroundImage:[self imageWithColor:backgroundColor] forState:state];
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
#pragma mark - 销毁
- (void)dealloc
{
    NSLog(@"dealloc %@",NSStringFromClass([self class]));
}

@end
