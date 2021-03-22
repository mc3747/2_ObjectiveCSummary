//
//  TabView_5_ViewController.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/7/26.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "TabView_5_ViewController.h"

@interface TabView_5_ViewController ()

@end

@implementation TabView_5_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Wonderful_GreenColor4;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 200, 80)];
    [button setTitle:@"点击进入" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pushVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
   
}

- (void)pushVC {
    Common_ViewController *vc = [[Common_ViewController alloc] init];
    vc.subtitleArray = @[@[@"1_点击折叠cell",@"2_滑动cell编辑",@"3_点击动画打开cell"]];
    vc.vcNameArray = @[@[@"FoldCellVC",@"SwipEditorCellVC",@"FoldCellAnimateVC"]];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
