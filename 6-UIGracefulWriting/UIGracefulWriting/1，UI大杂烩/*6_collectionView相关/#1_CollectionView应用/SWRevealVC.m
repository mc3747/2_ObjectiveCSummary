//
//  SWRevealVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/4/11.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "SWRevealVC.h"
#import "LeftViewController.h"
#import "Demo1ViewController.h"
#import "RightViewController.h"

@interface SWRevealVC ()

@end

@implementation SWRevealVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //左侧菜单栏
    LeftViewController *leftViewController = [[LeftViewController alloc] init];
    
    //首页
    Demo1ViewController *centerView1Controller = [[Demo1ViewController alloc] init];
    
    //右侧菜单栏
    RightViewController *rightViewController = [[RightViewController alloc] init];
    
    self.rearViewController = leftViewController;
    self.frontViewController = centerView1Controller;
    self.rightViewController = rightViewController;
    
    //浮动层离左边距的宽度
    self.rearViewRevealWidth = 230;
    //    revealViewController.rightViewRevealWidth = 230;
    
    //是否让浮动层弹回原位
    //mainRevealController.bounceBackOnOverdraw = NO;
    [self setFrontViewPosition:FrontViewPositionLeft animated:YES];
}



@end
