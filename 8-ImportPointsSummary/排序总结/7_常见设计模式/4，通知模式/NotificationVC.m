//
//  ViewController.m
//  通知
//
//  Created by gjfax on 16/7/6.
//  Copyright © 2016年 macheng. All rights reserved.
//

#import "NotificationVC.h"
#import "NavController.h"
@interface NotificationVC ()

@end

@implementation NotificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    label.text = @"跳转";
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jump)];
    [label addGestureRecognizer:recognizer];
    label.userInteractionEnabled = YES;
    [self.view addSubview:label];
    
// 注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goodbye:) name:@"goodbye" object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(welcome:) name:@"welcome" object:nil];
    
    
}

- (void)jump {
    NavController *navController = [[NavController alloc] init];
    [self.navigationController pushViewController:navController animated:YES];
}
// 通知的传值
- (void)goodbye:(NSNotification *)notification {

    NSLog(@"%@",notification.name);
    NSLog(@"%@",notification.object);
    NSLog(@"%@",notification.userInfo);
    
    
    
}

- (void)welcome:(NSNotification *)notification {
     NSLog(@"view say welcome");
    
}
// 移除通知
//- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
@end
