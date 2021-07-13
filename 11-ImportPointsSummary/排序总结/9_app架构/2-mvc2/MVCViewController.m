//
//  ViewController.m
//  Interview04-MVC-Apple
//
//  Created by MJ Lee on 2018/7/17.
//  Copyright © 2018年 MJ Lee. All rights reserved.
//

#import "MVCViewController.h"
#import "MJApp.h"
#import "MJAppView.h"

@interface MVCViewController () <MJAppViewDelegate>

@end

@implementation MVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建view
    MJAppView *appView = [[MJAppView alloc] init];
    appView.frame = CGRectMake(100, 100, 100, 150);
    appView.delegate = self;
    [self.view addSubview:appView];
    
    // 加载模型数据
    MJApp *app = [[MJApp alloc] init];
    app.name = @"QQ";
    app.image = @"QQ";
    
    // 设置数据到view上
    appView.app = app;
    
//    appView.iconView.image = [UIImage imageNamed:app.image];
//    appView.nameLabel.text = app.name;
}

#pragma mark - MJAppViewDelegate
- (void)appViewDidClick:(MJAppView *)appView
{
    NSLog(@"控制器监听到了appView的点击");
}

@end
