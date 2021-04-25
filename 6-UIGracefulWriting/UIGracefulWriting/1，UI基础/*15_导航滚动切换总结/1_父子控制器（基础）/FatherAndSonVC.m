//
//  FatherAndSonVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/9/6.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "FatherAndSonVC.h"
#import "Son1_ViewController.h"
#import "Son2_ViewController.h"
#import "Son3_ViewController.h"

@interface FatherAndSonVC ()
/** 正在显示的控制器 */
@property (nonatomic, weak) UIViewController *showingVc;
/** 用来存放子控制器的view */
@property (nonatomic, weak) UIView *contentView;
@end

@implementation FatherAndSonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    顶部button
    UIButton *btn1 = [self makeNormalButton:CGRectMake(0, 64, SCREEN_WIDTH / 3.f, 60) title:@"One"];
    UIButton *btn2 = [self makeNormalButton:CGRectMake(SCREEN_WIDTH / 3.f, 64, SCREEN_WIDTH / 3.f, 60) title:@"Two"];
    UIButton *btn3 = [self makeNormalButton:CGRectMake(SCREEN_WIDTH * 2 / 3.f, 64, SCREEN_WIDTH / 3.f, 60) title:@"Three"];
    GJWeakSelf;
    [btn1 GJSHandleCallBack:^(UIButton *button) {
        [weakSelf clickAction:button];
    }];
    [btn2 GJSHandleCallBack:^(UIButton *button) {
        [weakSelf clickAction:button];
    }];
    [btn3 GJSHandleCallBack:^(UIButton *button) {
        [weakSelf clickAction:button];
    }];
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
    [self.view addSubview:btn3];
    
    [self addChildViewController:[[Son1_ViewController alloc] init]];
    [self addChildViewController:[[Son2_ViewController alloc] init]];
    [self addChildViewController:[[Son3_ViewController alloc] init]];
    
//    内容view
    UIView *contentView = [[UIView alloc] init];
    contentView.frame = CGRectMake(0, 124, self.view.frame.size.width, self.view.frame.size.height - 124);
    // 默认显示
    [contentView addSubview:self.childViewControllers[0].view];
    [self.view addSubview:contentView];
    self.contentView = contentView;
}

- (void)clickAction:(UIButton *)button {
    
    // 移除其他控制器的view（以下两种方法均可以）
//    [self.showingVc.view removeFromSuperview];
    [self.showingVc.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 获得控制器的位置（索引）
    NSUInteger index = [button.superview.subviews indexOfObject:button];
    
    // 当前控制器的索引
    NSUInteger oldIndex = [self.childViewControllers indexOfObject:self.showingVc];
    
    // 添加控制器的view
    self.showingVc = self.childViewControllers[index];
    self.showingVc.view.frame = self.contentView.bounds;
    [self.contentView addSubview:self.showingVc.view];
    
    // 动画
    CATransition *animation = [CATransition animation];
    animation.type = @"cube";
    animation.subtype = index > oldIndex ? kCATransitionFromRight : kCATransitionFromLeft;
    animation.duration = 0.5;
    [self.contentView.layer addAnimation:animation forKey:nil];
}

#pragma mark -  创建按钮
- (UIButton *)makeNormalButton:(CGRect)frame title:(NSString *)title{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [btn setBackgroundColor:LBRandomColor forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    return btn;
}
@end
