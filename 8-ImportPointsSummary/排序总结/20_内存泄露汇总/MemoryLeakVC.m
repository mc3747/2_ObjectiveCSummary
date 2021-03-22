//
//  MemoryLeakVC.m
//  排序总结
//
//  Created by gjfax on 2019/1/24.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "MemoryLeakVC.h"
#import "UIWebViewVC.h"
#import "WKWebViewVC.h"

@interface MemoryLeakVC ()

@end

@implementation MemoryLeakVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark -  1，内存泄露简易说明


#pragma mark -  2，内存泄露调试方法


#pragma mark -  3，内存泄露常见场景


#pragma mark -  4，内存泄露解决办法

- (IBAction)uiWebViewAction:(id)sender {
    UIWebViewVC *vc = [[UIWebViewVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)wkWebViewAction:(id)sender {
    WKWebViewVC *vc = [[WKWebViewVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
