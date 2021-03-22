//
//  ViewController.m
//  单例
//
//  Created by gjfax on 2017/2/16.
//  Copyright © 2017年 macheng. All rights reserved.
//

#import "SingltonVC.h"
#import "TestVC1.h"
#import "TestVC2.h"
#import "SingltonTest.h"

@interface SingltonVC ()


@end

@implementation SingltonVC



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    NSLog(@"vc单例地址%@",[SingltonTest shareInstance]);
    NSLog(@"vc元素内容%li",(long)[SingltonTest shareInstance].age);
    
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
    label1.text = @"跳转到test1";
    UITapGestureRecognizer *recognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToTest1)];
    [label1 addGestureRecognizer:recognizer1];
    label1.userInteractionEnabled = YES;
    [self.view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 200, 50)];
    label2.text = @"跳转到test2";
    UITapGestureRecognizer *recognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToTest2)];
    [label2 addGestureRecognizer:recognizer2];
    label2.userInteractionEnabled = YES;
    [self.view addSubview:label2];
}

- (void)jumpToTest1 {
    TestVC1 *controller = [[TestVC1 alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)jumpToTest2 {
    TestVC2 *controller = [[TestVC2 alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
