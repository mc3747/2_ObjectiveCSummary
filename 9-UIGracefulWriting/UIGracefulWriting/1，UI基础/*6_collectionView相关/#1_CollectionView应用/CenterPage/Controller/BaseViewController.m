//
//  BaseViewController.m
//  侧滑菜单
//
//  Created by yixiang on 15/7/18.
//  Copyright (c) 2015年 yixiang. All rights reserved.
//

#import "BaseViewController.h"
#import "SWRevealViewController.h"

@interface BaseViewController ()

@property (nonatomic , strong) NSArray *operateTitleArray;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
}

-(void)initView{
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width ,60)];
    _navBarHeight = 60;
    containerView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:containerView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 40)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [self controllerTitle];
    [containerView addSubview:label];
    
    self.view.backgroundColor = [UIColor whiteColor];

    //注册该页面可以执行滑动切换
    SWRevealViewController *revealController = self.revealViewController;
    [self.view addGestureRecognizer:revealController.panGestureRecognizer];
}

-(NSString *)controllerTitle{
    return @"默认标题";
}

@end
