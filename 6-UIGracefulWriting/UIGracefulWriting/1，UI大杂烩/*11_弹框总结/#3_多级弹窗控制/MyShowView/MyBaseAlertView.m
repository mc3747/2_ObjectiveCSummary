//
//  MyBaseAlertView.m
//  AlertViewDemo
//
//  Created by LeeMiao on 2019/8/12.
//  Copyright © 2019 LiMiao. All rights reserved.
//

#import "MyBaseAlertView.h"

@interface MyBaseAlertView()

@property (nonatomic,weak  ) UIView *contentView;    //-> 提示的弹框
@property (nonatomic,strong) UIView *grayView;       //-> 灰色半透明背景

@end

@implementation MyBaseAlertView

- (instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }
    return self;
}

- (void)showContentView:(UIView *)contentView{
    
    self.contentView = contentView;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self creatGrayBgView];
    [self creatContentView];
    
}


- (void)creatGrayBgView{
    
    CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.grayView = [[UIView alloc] initWithFrame:frame];
    self.grayView.backgroundColor = [UIColor blackColor];
    self.grayView.alpha = 0;
    [self addSubview:self.grayView];
    
    // 执行渐变动画
    [UIView animateWithDuration:0.3f animations:^{
        self.grayView.alpha = 0.25f;
    }];
}


- (void)creatContentView{
    self.contentView.alpha = 0.f;
    [self addSubview:self.contentView];
    
    switch (self.animationType) {
        case MyBaseAlertViewAnimationTypeScaleInCenter:
            [self showScaleAnimation];
            break;
        case MyBaseAlertViewAnimationTypeMoveFromTopToBottom:
        case MyBaseAlertViewAnimationTypeMoveFromTopToTop:
        case MyBaseAlertViewAnimationTypeMoveFromBottomToTop:
        case MyBaseAlertViewAnimationTypeMoveFromBottomToBottom:
            [self showMoveAnimation];
            break;

        default:
            [self showScaleAnimation];
            break;
    }
    
    
}

- (void)dissmissContentView{

    switch (self.animationType) {
        case MyBaseAlertViewAnimationTypeScaleInCenter:
            [self dissmissScaleAnimation];
            break;
            
        case MyBaseAlertViewAnimationTypeMoveFromTopToBottom:
        case MyBaseAlertViewAnimationTypeMoveFromTopToTop:
        case MyBaseAlertViewAnimationTypeMoveFromBottomToTop:
        case MyBaseAlertViewAnimationTypeMoveFromBottomToBottom:
            [self dissmissMoveAnimation];
            break;

        default:
            [self dissmissScaleAnimation];
            break;
    }

}



#pragma mark - 动画

#pragma mark - 缩放动画
- (void)showScaleAnimation{
    // view 居中
    self.contentView.center = self.grayView.center;
    // 关闭交互
    self.contentView.userInteractionEnabled = NO;
    // 设置初始缩小比例
    self.contentView.transform = CGAffineTransformMakeScale(0.f, 0.f);
    // 执行动画， 延迟0.2s 执行，动画时间1s
    [UIView animateWithDuration:1 delay:0.2 usingSpringWithDamping:0.3 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        // 执行放大动画
        self.contentView.transform = CGAffineTransformMakeScale(1.f, 1.f);
        self.contentView.alpha = 1.f;
    } completion:^(BOOL finished) {
        // 动画完毕开启交互
        self.contentView.userInteractionEnabled = YES;
    }];
}

- (void)dissmissScaleAnimation{
    // 执行消失动画
    [UIView animateWithDuration:0.2f animations:^{
        self.contentView.alpha = 0.f;
        self.grayView.alpha = 0.f;
        self.contentView.transform = CGAffineTransformMakeScale(0.75f, 0.75f);
    } completion:^(BOOL finished) {
        [self.contentView removeFromSuperview];
        [self.grayView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

#pragma mark - 移动动画
- (void)showMoveAnimation{
    
    CGPoint currentCenter = CGPointMake(0, 0);
    switch (self.animationType) {
        case MyBaseAlertViewAnimationTypeMoveFromTopToTop:
        case MyBaseAlertViewAnimationTypeMoveFromTopToBottom:
            currentCenter = CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5, -[UIScreen mainScreen].bounds.size.height * 0.5);
            break;
        default:
            currentCenter = CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5, [UIScreen mainScreen].bounds.size.height * 1.5);
            break;
    }
    
    // view 居中
    self.contentView.center = currentCenter;
    // 关闭交互
    self.contentView.userInteractionEnabled = NO;
    // 执行动画， 延迟0.2s 执行，动画时间1s
    [UIView animateWithDuration:1 delay:0.2 usingSpringWithDamping:0.3 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        // 执行位移
        self.contentView.alpha = 1.f;
        self.contentView.center = self.grayView.center;
    } completion:^(BOOL finished) {
        // 动画完毕开启交互
        self.contentView.userInteractionEnabled = YES;
    }];
    
    
}

- (void)dissmissMoveAnimation{
    CGPoint currentCenter = CGPointMake(0, 0);
    switch (self.animationType) {
        case MyBaseAlertViewAnimationTypeMoveFromTopToTop:
        case MyBaseAlertViewAnimationTypeMoveFromBottomToTop:
            currentCenter = CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5, -[UIScreen mainScreen].bounds.size.height * 0.5);
            break;
        default:
            currentCenter = CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5, [UIScreen mainScreen].bounds.size.height * 1.5);
            break;
    }
    
    // 执行消失动画
    [UIView animateWithDuration:.5f animations:^{
        self.contentView.center = currentCenter;
        self.grayView.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self.contentView removeFromSuperview];
        [self.grayView removeFromSuperview];
        [self removeFromSuperview];
    }];
    
}


- (void)dealloc{
    NSLog(@"%@ dealloc.", NSStringFromClass([self class]));
}



@end
