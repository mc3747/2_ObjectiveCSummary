//
//  ViewController.m
//  ToolAndExtensionSummary
//
//  Created by gjfax on 2018/6/7.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Practical.h"
#import "UIButton+Category.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *testBtn1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [_testBtn1 addTarget:self action:@selector(test1) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark -   按钮扩大点击范围
- (void)test1 {
    UIButton *testBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 150, 50, 50)];
    [testBtn setImage:[UIImage imageNamed:@"home_ad_1"] forState:UIControlStateNormal];
    [testBtn setBackgroundColor:[[UIColor yellowColor] colorWithAlphaComponent:0.5] ];
    [testBtn enlargeClickAreaWithGap:20];
    [self.view addSubview:testBtn];
}


@end
