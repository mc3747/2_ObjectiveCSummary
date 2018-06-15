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

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *testBtn1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
//    [self test1];
//    [self test2];
    [_testBtn1 addTarget:self action:@selector(test3) forControlEvents:UIControlEventTouchUpInside];
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
#pragma mark -  复杂滚动
- (void)test3 {
    BannerDemoVC *vc = [[BannerDemoVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
