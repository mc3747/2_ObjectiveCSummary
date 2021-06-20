//
//  StackViewLayoutVC.m
//  WHLatticeDemo
//
//  Created by gjfax on 2019/12/13.
//  Copyright © 2019 remember17. All rights reserved.
//

#import "StackViewLayoutVC.h"
// =====================================================
/*
 UIStackView适用于：
 1，静态的缩放，横竖屏，屏幕适配等
 2，等宽高，均分等
 */
// =====================================================
@interface StackViewLayoutVC ()
@property (nonatomic, strong) UIStackView *stackView;
@end

@implementation StackViewLayoutVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 150, 30)];
    button1.backgroundColor = [UIColor greenColor];
    [button1 setTitle:@"增加第一行高度" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal] ;
    button1.titleLabel.adjustsFontSizeToFitWidth = YES;
    [button1 addTarget:self action:@selector(increaseAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(170, 100, 150, 30)];
    [button2 setTitle:@"减少第一行高度" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal] ;
     button2.titleLabel.adjustsFontSizeToFitWidth = YES;
    button2.backgroundColor = [UIColor redColor];
    [button2 addTarget:self action:@selector(reduceAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIStackView *containerView = [self returnHorizonalStack];
    containerView.frame = CGRectMake(0, 150, CGRectGetWidth(self.view.bounds), 100);
    //    ⚠️UIStackView没有backgroundColor属性，
       UIView *backgroundView = [[UIView alloc] initWithFrame:containerView.bounds];
       backgroundView.backgroundColor = [UIColor orangeColor];
       [containerView addSubview:backgroundView];
    [containerView sendSubviewToBack:backgroundView];
    _stackView = containerView;
    [self.view addSubview:containerView];
}

- (void)increaseAction:(UIButton *)button{
    for (UILabel *label in _stackView.subviews) {
        if (label.tag == 1000) {
//            [UIView animateWithDuration:1  animations:^{
//
//
//
//            }];
//            label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width, label.frame.size.height + 20);
            label.hidden = YES;
        }
    }
}

- (void)reduceAction:(UIButton *)button{
     for (UILabel *label in _stackView.subviews) {
    if (label.tag == 1000) {
//             label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width, label.frame.size.height - 20);
        
         label.hidden = NO;
         }
     }
}

#pragma mark -  基本使用
/*
 1，axis(轴向) 属性决定了 stack 的朝向，只有垂直或水平；
 2，distribution(分布) 属性决定了其管理的视图在沿着其轴向上的布局；
 Fill : 铺满
 Fill Equal ： 等高铺满
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

#pragma mark -  返回一个横向布局的stackView
- (UIStackView *)returnHorizonalStack {
    UIStackView *containerView = [[UIStackView alloc]init];
    //子视图布局方向：水平或垂直
    containerView.axis = UILayoutConstraintAxisVertical;
    //子控件依据何种规矩布局
    containerView.distribution = UIStackViewDistributionFillProportionally;
    //子控件的对齐方式
    containerView.alignment = UIStackViewAlignmentLeading;
    //子控件之间的最小间距
    containerView.spacing = 0;
  
    NSArray *tempArray = @[@"了是东风科技",@"开始的疯狂活动是多久发货的开发环境放多久发货谁开的房间水电费地方就好看是东风科技",@"老师的开发接口都是附近看到快快快快快快快快快"
        ,@"好看"];
    for (NSInteger i = 0; i < 4; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor darkGrayColor];
        label.numberOfLines = 0;
        label.adjustsFontSizeToFitWidth = YES;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = tempArray[i];
        label.tag = 1000 + i;
        [containerView addArrangedSubview:label];
        
    }
    return containerView;
}

@end
