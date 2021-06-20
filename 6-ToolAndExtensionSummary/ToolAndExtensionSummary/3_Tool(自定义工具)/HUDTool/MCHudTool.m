//
//  ChaosStatusBarHUD.m
//  SmartMedicalPlatformIM
//
//  Created by gjfax on 2019/3/11.
//  Copyright © 2019 SevenShare. All rights reserved.
//


#import "MCHudTool.h"

#define ChaosWindowH 20
#define ChaosScreenW [UIScreen mainScreen].bounds.size.width

@implementation MCHudTool
static NSTimer *timer_;
static UIWindow *window_;


+ (void)showWindow
{
    // 首先结束之前的定时器
    [timer_ invalidate];
    UIWindow *window = [[UIWindow alloc] init];
    window.backgroundColor = UIColorFromRGBHex(0x20c786);
    window.windowLevel = UIWindowLevelStatusBar;
    window.hidden = NO;
    window_ = window;
    window.frame = CGRectMake(0, -ChaosWindowH, ChaosScreenW, ChaosWindowH);
    
    // 动画效果
    [UIView animateWithDuration:0.25 animations:^{
        
        window.frame = CGRectMake(0, 0, ChaosScreenW, ChaosWindowH);
    }];
}
/** 自定义图标 文字 */
+ (void)showMessage:(NSString *)str withImage:(UIImage *)image
{
    // 创建窗体
    [self showWindow];
    // 添加按钮
    UIButton *button = [[UIButton alloc] init];
    button.frame = window_.bounds;
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:str forState:UIControlStateNormal];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [window_ addSubview:button];
    
    // 两秒后结束动画
    timer_ = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(hide) userInfo:nil repeats:NO];
}

/** 显示纯文本 */
+ (void)showMessage:(NSString *)str
{
    [self showMessage:str withImage:nil];
}

/** 显示成功信息 */
+ (void)showSuccess:(NSString *)str
{
    [self showMessage:str withImage:[UIImage imageNamed:@"success"]];
}

/** 显示失败信息 */
+ (void)showError:(NSString *)str
{
    [self showMessage:str withImage:[UIImage imageNamed:@"error"]];
}

/** 显示正在加载的信息 */
+ (void)showLoading:(NSString *)str
{
    // 停止定时器
    [timer_ invalidate];
    timer_ = nil;
    // 创建窗口
    [self showWindow];
    // 添加按钮
    UIButton *button = [[UIButton alloc] init];
    button.frame = window_.bounds;
    [button setTitle:str forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [window_ addSubview:button];
    // 计算按钮文字宽度
    CGFloat titleWidth = [str sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]}].width;
    // 计算菊花的X值
    CGFloat x = (ChaosScreenW - 2 * titleWidth) * 0.5;
    // 计算loadingView的Y值
    CGFloat y = window_.frame.size.height * 0.5;
    UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [loadingView startAnimating];
    [window_ addSubview:loadingView];
    loadingView.center = CGPointMake(x, y);
}

/** 隐藏 */
+ (void)hide
{
    // 动画效果
    [UIView animateWithDuration:0.25 animations:^{
        
        window_.frame = CGRectMake(0, -20, ChaosScreenW, ChaosWindowH);
    } completion:^(BOOL finished) {
        
        timer_ = nil;
        window_ = nil;
    }];
}

@end
