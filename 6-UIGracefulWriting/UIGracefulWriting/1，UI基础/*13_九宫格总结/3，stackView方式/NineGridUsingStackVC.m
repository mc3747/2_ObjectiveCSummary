//
//  NineGridUsingStackVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/10/30.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "NineGridUsingStackVC.h"
#import "OAUIStackViewViewController.h"

@interface NineGridUsingStackVC ()
@property (nonatomic, weak) UIStackView *containerView;;
@end

@implementation NineGridUsingStackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showBaseUse];
    [self showGrid];
}

#pragma mark -  基本使用
/*
 1，axis(轴向) 属性决定了 stack 的朝向，只有垂直或水平；
 2，distribution(分布) 属性决定了其管理的视图在沿着其轴向上的布局；
 Fill : 铺满
 Fill Equal ： 等宽铺满
 Fill Proportionally : 等比例铺满
 Equal Spacing ：等距离放置
 Equal Centering ：各个试图的中心距离保持一致，不够放置则压缩后面的试图距离；
 3，alignment(对齐) 属性决定了其管理的视图在垂直于其轴向上的布局；
 Fill : 垂直方向上铺满
 Top : 沿顶端对齐
 Center : 沿中心线对其
 Bottom : 沿底部对齐
 First Baseline : 按照第一个子视图的文字的第一行对齐，同时保证高度最大的子视图底部对齐（只在axis为水平方向有效）
 Last Baseline : 按照最后一个子视图的文字的最后一行对齐，同时保证高度最大的子视图顶部对齐（只在axis为水平方向有效）
 4，spacing(空隙) 属性决定了其管理的视图间的最小间隙；
 5，baselineRelativeArrangement 属性决定了其视图间的垂直间隙是否根据基线测量得到，选中 Baseline Relative 将根据subview的基线调整垂直间距；
 6，layoutMarginsRelativeArrangement 属性决定了 stack 视图平铺其管理的视图时是否要参照它的布局边距，选中 Layout Margins Relative 将相对于标准边界空白来调整subview位置；
 
 */
- (void)showBaseUse {
    UIStackView *containerView = [self returnHorizonalStack];
    containerView.frame = CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), 100);
    [self.view addSubview:containerView];
    _containerView = containerView;
    
//    添加按钮
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 220, SCREEN_WIDTH * 0.5, 50)];
    [addButton setTitle:@"添加" forState:UIControlStateNormal];
    [addButton setBackgroundColor:LBRandomColor forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    
//    添加按钮
    UIButton *deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5, 220, SCREEN_WIDTH * 0.5, 50)];
    [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [deleteButton setBackgroundColor:LBRandomColor forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteButton];
    
//    跳转到xib演示按钮
    UIButton *pushButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 280, SCREEN_WIDTH , 50)];
    [pushButton setTitle:@"跳转到xib" forState:UIControlStateNormal];
    [pushButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [pushButton setBackgroundColor:LBRandomColor forState:UIControlStateNormal];
    [pushButton addTarget:self action:@selector(pushAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton];
}

- (void)addAction:(id)sender {
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor orangeColor];
    label.text = @"东风科技胜利大街";
    label.numberOfLines = 0;
    [_containerView addArrangedSubview:label];
}

- (void)deleteAction:(id)sender {
    //removeArrangedSubview， 只会把子控件从arrangedSubviews数组中移除，
    //不会从subviews中移除，如果需要可调用removeFromSuperview
    UIView *view = [_containerView.subviews lastObject];
    [_containerView removeArrangedSubview:view];
    [view removeFromSuperview];
}

- (void)pushAction:(id)sender {
    OAUIStackViewViewController *vc = [[OAUIStackViewViewController alloc] initWithNibName:@"OAUIStackViewViewController" bundle:nil];
    GJSPushViewController(vc, YES);
}

#pragma mark -  九宫格
- (void)showGrid {
    UIStackView *containerView = [[UIStackView alloc]initWithFrame:CGRectMake(0, 360, SCREEN_WIDTH, 200)];
    containerView.backgroundColor = LBRandomColor;
    //子视图布局方向：水平或垂直
    containerView.axis = UILayoutConstraintAxisVertical;//垂直布局
    //子控件依据何种规矩布局
    containerView.distribution = UIStackViewDistributionFillEqually;//子控件均分
    //子控件之间的最小间距
    containerView.spacing = 10;
    //子控件的对齐方式
    containerView.alignment = UIStackViewAlignmentFill;
    for (NSInteger i = 0; i < 3; i++) {
        UIStackView *stack = [self returnHorizonalStack];
        
        [containerView addArrangedSubview:stack];
    }
    
    [self.view addSubview:containerView];
}

#pragma mark -  返回一个横向布局的stackView
- (UIStackView *)returnHorizonalStack {
    UIStackView *containerView = [[UIStackView alloc]init];
    containerView.backgroundColor = LBRandomColor;
    //子视图布局方向：水平或垂直
    containerView.axis = UILayoutConstraintAxisHorizontal;//水平布局
    //子控件依据何种规矩布局
    containerView.distribution = UIStackViewDistributionFillEqually;//子控件均分
    //子控件之间的最小间距
    containerView.spacing = 10;
    //子控件的对齐方式
    containerView.alignment = UIStackViewAlignmentFill;
    NSArray *tempArray = @[@"了是东风科技",@"开始的疯狂活动是多久发货的开发环境放多久发货谁开的房间水电费地方就好看是东风科技",@"老师的开发接口都是附近看到快快快快快快快快快",@"好看"];
    for (NSInteger i = 0; i < 4; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = LBRandomColor;
        label.numberOfLines = 0;
        label.adjustsFontSizeToFitWidth = YES;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = tempArray[i];
        [containerView addArrangedSubview:label];
        
    }
    return containerView;
}
@end
