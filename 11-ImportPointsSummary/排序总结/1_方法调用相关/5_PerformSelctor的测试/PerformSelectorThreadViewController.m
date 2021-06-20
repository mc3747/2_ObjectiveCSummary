//
//  PerformSelectorThreadViewController.m
//  DSMessageDemo
//
//  Created by 童玉龙 on 16/8/26.
//  Copyright © 2016年 齐滇大圣. All rights reserved.
//

#import "PerformSelectorThreadViewController.h"

@implementation PerformSelectorThreadViewController

- (void)viewDidLoad {
 
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *firstBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 150, 60)];
    [firstBtn setBackgroundColor:[UIColor redColor]];
    [firstBtn setTitle:@"InBackground" forState:UIControlStateNormal];
    firstBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [firstBtn addTarget:self action:@selector(inBackgroundClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firstBtn];
    
    UIButton *secondBtn = [[UIButton alloc] initWithFrame:CGRectMake(220, 100, 150, 60)];
    [secondBtn setBackgroundColor:[UIColor redColor]];
    [secondBtn setTitle:@"onMainThread YES" forState:UIControlStateNormal];
    secondBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [secondBtn addTarget:self action:@selector(onMainThreadWaitYesClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secondBtn];
    
    
    UIButton *thirdBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 200, 150, 60)];
    [thirdBtn setBackgroundColor:[UIColor redColor]];
    [thirdBtn setTitle:@"onMainThread NO" forState:UIControlStateNormal];
    thirdBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [thirdBtn addTarget:self action:@selector(onMainThreadWaitNoClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:thirdBtn];
    
    
    UIButton *forthBtn = [[UIButton alloc] initWithFrame:CGRectMake(220, 200, 150, 60)];
    [forthBtn setBackgroundColor:[UIColor redColor]];
    [forthBtn setTitle:@"simple" forState:UIControlStateNormal];
    forthBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [forthBtn addTarget:self action:@selector(simpleClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forthBtn];
    
    UIButton *fifthBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 300, 150, 60)];
    [fifthBtn setBackgroundColor:[UIColor redColor]];
    [fifthBtn setTitle:@"simple delay" forState:UIControlStateNormal];
    fifthBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [fifthBtn addTarget:self action:@selector(simpleDelayClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fifthBtn];
}

- (void)inBackgroundClick{
    
    [self performSelectorInBackground:@selector(delayMethod) withObject:nil];
    NSLog(@"调用方法＝＝开始");
    sleep(5);
    NSLog(@"调用方法＝＝结束");
}


- (void)onMainThreadWaitYesClick{
    
    [self performSelectorOnMainThread:@selector(delayMethod) withObject:nil waitUntilDone:YES];
    NSLog(@"调用方法＝＝开始");
    sleep(5);
    NSLog(@"调用方法＝＝结束");
}

- (void)onMainThreadWaitNoClick{
    
    [self performSelectorOnMainThread:@selector(delayMethod) withObject:nil waitUntilDone:NO];
    NSLog(@"调用方法＝＝开始");
    sleep(5);
    NSLog(@"调用方法＝＝结束");
}

- (void)simpleClick{
    
    [self performSelector:@selector(delayMethod) withObject:nil];
    NSLog(@"调用方法＝＝开始");
    sleep(5);
    NSLog(@"调用方法＝＝结束");
}

- (void)simpleDelayClick{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        if ([self respondsToSelector:@selector(delayMethod)]) {
            [self performSelector:@selector(delayMethod) withObject:nil];
        }
    });
    
    NSLog(@"调用方法＝＝开始");
    sleep(5);
    NSLog(@"调用方法＝＝结束");
}

- (void)delayMethod
{
    NSLog(@"执行selector方法");
}

@end
