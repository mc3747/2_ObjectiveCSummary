//
//  PerformSelectorNoViewController.m
//  DSMessageDemo
//
//  Created by 童玉龙 on 16/8/26.
//  Copyright © 2016年 齐滇大圣. All rights reserved.
//

#import "PerformSelectorNoViewController.h"

@implementation PerformSelectorNoViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *firstBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 150, 60)];
    [firstBtn setBackgroundColor:[UIColor redColor]];
    [firstBtn setTitle:@"No afterDelay" forState:UIControlStateNormal];
    firstBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [firstBtn addTarget:self action:@selector(NoAfterDelayClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firstBtn];
    
    UIButton *secondBtn = [[UIButton alloc] initWithFrame:CGRectMake(220, 100, 150, 60)];
    [secondBtn setBackgroundColor:[UIColor redColor]];
    [secondBtn setTitle:@"AfterDelay" forState:UIControlStateNormal];
    secondBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [secondBtn addTarget:self action:@selector(AfterDelayClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secondBtn];
    
    
    UIButton *thirdBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 200, 150, 60)];
    [thirdBtn setBackgroundColor:[UIColor redColor]];
    [thirdBtn setTitle:@"AfterDelay Runloop" forState:UIControlStateNormal];
    thirdBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [thirdBtn addTarget:self action:@selector(AfterDelayRunloopClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:thirdBtn];
    
    UIButton *forthBtn = [[UIButton alloc] initWithFrame:CGRectMake(220, 200, 150, 60)];
    [forthBtn setBackgroundColor:[UIColor redColor]];
    [forthBtn setTitle:@"dispatch_after" forState:UIControlStateNormal];
    forthBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [forthBtn addTarget:self action:@selector(dispatchAfterClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forthBtn];
}

- (void)NoAfterDelayClick{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self performSelector:@selector(delayMethod) withObject:nil];
        NSLog(@"调用方法＝＝开始");
        sleep(5);
        NSLog(@"调用方法＝＝结束");
    });
}


- (void)AfterDelayClick{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0];
        NSLog(@"调用方法＝＝开始");
        sleep(5);
        NSLog(@"调用方法＝＝结束");
    });
}

- (void)AfterDelayRunloopClick{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0];
        [[NSRunLoop currentRunLoop] run];
        NSLog(@"调用方法＝＝开始");
        sleep(5);
        NSLog(@"调用方法＝＝结束");
    });
}

- (void)dispatchAfterClick{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
            if ([self respondsToSelector:@selector(delayMethod)]) {
                [self performSelector:@selector(delayMethod) withObject:nil];
            }
        });
        NSLog(@"调用方法＝＝开始");
        sleep(5);
        NSLog(@"调用方法＝＝结束");
    });
}

- (void)delayMethod
{
    NSLog(@"执行延迟方法");
}

@end
