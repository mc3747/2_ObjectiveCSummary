//
//  ViewController.m
//  BSYLoading
//
//  Created by 白仕云 on 2018/5/17.
//  Copyright © 2018年 BSY.com. All rights reserved.
//

#import "LightLoadingVC.h"
#import "BSYLoading.h"

@interface LightLoadingVC ()

@end

@implementation LightLoadingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightBLue];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [btn setTitle:@"添加" forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 100, 100);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(Click) forControlEvents:UIControlEventTouchUpInside];


    UIButton *btnQ = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [btnQ setTitle:@"隐藏" forState:UIControlStateNormal];
    btnQ.frame = CGRectMake(0, 250, 100, 100);
    [self.view addSubview:btnQ];
    [btnQ addTarget:self action:@selector(ClickQQQQ) forControlEvents:UIControlEventTouchUpInside];
}

- (void)ClickQQQQ {
    [BSYLoading hidenCrazyCircleAnimation];
}
- (void)Click {
    [BSYLoading showCrazyCircleWithText:nil];
}

@end
