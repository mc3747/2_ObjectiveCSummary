//
//  ViewController.m
//  JX_GCDTimer
//
//  Created by Joeyxu on 6/18/15.
//  Copyright (c) 2015 com.joeyxu. All rights reserved.
//

#import "CustomTimerVC.h"
#import "JX_GCDTimerManager.h"

@interface CustomTimerVC ()
@end

static NSString *myTimer = @"MyTimer";

@implementation CustomTimerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    //使用封装好了的GCD的timer功能：启动一个timer，每隔1秒执行一次
    __weak typeof(self) weakSelf = self;
    // 提供ActionOption之前，需要手动cancel去掉上一个timer，再重新schedule
    [[JX_GCDTimerManager sharedInstance] cancelTimerWithName:myTimer];
    [[JX_GCDTimerManager sharedInstance] scheduledDispatchTimerWithName:myTimer
                                                           timeInterval:1.0
                                                                  queue:nil
                                                                repeats:YES   //是否重复
                                                           actionOption:AbandonPreviousAction
                                                                 action:^{
                                                                     [weakSelf doSomethingEveryTwoSeconds];
                                                                 }];
}

/* timer每次执行打印一条log记录，在执行到n==10的时候cancel掉timer */
- (void)doSomethingEveryTwoSeconds
{
    static NSUInteger n = 0;
    NSLog(@"myTimer runs %lu times!", (unsigned long)n++);
    
    if (n >= 10) {
        [[JX_GCDTimerManager sharedInstance] cancelTimerWithName:myTimer];
    }
}



/* 持有timerManager的对象销毁时，将其中的timer全部撤销 */
- (void)dealloc
{
    [[JX_GCDTimerManager sharedInstance] cancelTimerWithName:myTimer];
}

@end
