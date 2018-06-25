//
//  ViewController.m
//  ToolAndExtensionSummary
//
//  Created by gjfax on 2018/6/7.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Practical.h"
#import "CustomBannerScrollView.h"
#import "UIButton+Category.h"
#import "BannerDemoVC.h"
#import "SDViewController.h"
#import "LeftViewController.h"
#import "Demo1ViewController.h"
#import "RightViewController.h"
#import "SWRevealViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *testBtn1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [_testBtn1 addTarget:self action:@selector(test5) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark -   按钮扩大点击范围
- (void)test1 {
    UIButton *testBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 150, 50, 50)];
    [testBtn setImage:[UIImage imageNamed:@"home_ad_1"] forState:UIControlStateNormal];
    [testBtn setBackgroundColor:[[UIColor yellowColor] colorWithAlphaComponent:0.5] ];
    [testBtn enlargeClickAreaWithGap:20];
    [self.view addSubview:testBtn];
}

#pragma mark -   普通滚动图片
- (void)test2 {
        CustomBannerScrollView *bannerView = [[CustomBannerScrollView alloc] initWithFrame:CGRectMake(0, 100, MAIN_SCREEN_WIDTH, 250) ];
        [bannerView configPictures:@[@"home_ad_1",@"home_ad_2",@"home_ad_3"]];
        [self.view addSubview:bannerView];
}
#pragma mark -  循环滚动
- (void)test3 {
    SDViewController *vc = [[SDViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -  复杂滚动
- (void)test4 {
    BannerDemoVC *vc = [[BannerDemoVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -  collectionView
- (void)test5 {
    
    //左侧菜单栏
    LeftViewController *leftViewController = [[LeftViewController alloc] init];
    
    //首页
    Demo1ViewController *centerView1Controller = [[Demo1ViewController alloc] init];
    
    //右侧菜单栏
    RightViewController *rightViewController = [[RightViewController alloc] init];
    
    SWRevealViewController *revealViewController = [[SWRevealViewController alloc] initWithRearViewController:leftViewController frontViewController:centerView1Controller];
    revealViewController.rightViewController = rightViewController;
    
    //浮动层离左边距的宽度
    revealViewController.rearViewRevealWidth = 230;
    //    revealViewController.rightViewRevealWidth = 230;
    
    //是否让浮动层弹回原位
    //mainRevealController.bounceBackOnOverdraw = NO;
    [revealViewController setFrontViewPosition:FrontViewPositionLeft animated:YES];
    
    [self.navigationController pushViewController:revealViewController animated:YES];
}
@end
