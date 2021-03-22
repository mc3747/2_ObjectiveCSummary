//
//  Test3ViewController.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/11/23.
//  Copyright © 2018 macheng. All rights reserved.
//

#import "Test3ViewController.h"

@interface Test3ViewController ()

@end

@implementation Test3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 100, 200, 50)];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setBackgroundColor:[UIColor goldColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
