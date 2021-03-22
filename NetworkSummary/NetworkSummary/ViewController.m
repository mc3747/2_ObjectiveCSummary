//
//  ViewController.m
//  NetworkSummary
//
//  Created by gjfax on 2018/8/23.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "ViewController.h"
#import "MultiThreadingVC.h"
#import "CacheVC.h"
#import "DifferentTypeFilesVC.h"
#import "WKWebViewStudyVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"重难点各个击破";
}
//内存缓存
- (IBAction)demo3:(id)sender {
    CacheVC *vc = [[CacheVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
//信息采集
- (IBAction)demo4:(id)sender {
    
}
//多线程
- (IBAction)demo5:(id)sender {
    MultiThreadingVC *vc = [[MultiThreadingVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
//文件
- (IBAction)demo6:(id)sender {
    DifferentTypeFilesVC *vc = [[DifferentTypeFilesVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
//WKWebView
- (IBAction)demo7:(id)sender {
    WKWebViewStudyVC *vc = [[WKWebViewStudyVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
