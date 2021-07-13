//
//  MJAppPresenter.m
//  Interview04-MVC-Apple
//
//  Created by MJ Lee on 2018/7/17.
//  Copyright © 2018年 MJ Lee. All rights reserved.
//

#import "MJAppPresenter.h"
#import "MJApp.h"
#import "MJAppView2.h"

@interface MJAppPresenter() <MJAppViewDelegate>
@property (weak, nonatomic) UIViewController *controller;
@end

@implementation MJAppPresenter

- (instancetype)initWithController:(UIViewController *)controller
{
    if (self = [super init]) {
        self.controller = controller;
        
        // 创建View
        MJAppView2 *appView = [[MJAppView2 alloc] init];
        appView.frame = CGRectMake(100, 100, 100, 150);
        appView.delegate = self;
        [controller.view addSubview:appView];
        
        // 加载模型数据
        MJApp *app = [[MJApp alloc] init];
        app.name = @"QQ";
        app.image = @"QQ";
        
        // 赋值数据
        [appView setName:app.name andImage:app.image];
//        appView.iconView.image = [UIImage imageNamed:app.image];
//        appView.nameLabel.text = app.name;
    }
    return self;
}

#pragma mark - MJAppViewDelegate
- (void)appViewDidClick:(MJAppView2 *)appView
{
    NSLog(@"presenter 监听了 appView 的点击");
}

@end
