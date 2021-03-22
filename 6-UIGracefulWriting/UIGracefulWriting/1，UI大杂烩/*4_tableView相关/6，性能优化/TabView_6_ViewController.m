//
//  TabView_6_ViewController.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/7/26.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "TabView_6_ViewController.h"

@interface TabView_6_ViewController ()

@end

@implementation TabView_6_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = MainColor;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 200, 80)];
    [button setTitle:@"点击进入" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pushVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)pushVC {
    Common_ViewController *vc = [[Common_ViewController alloc] init];
    vc.subtitleArray = @[@[@"分页加载",@"UITableView解耦"]];
    vc.vcNameArray = @[@[@"PageLoadingVC",@"KTDecouplingVC"]];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
