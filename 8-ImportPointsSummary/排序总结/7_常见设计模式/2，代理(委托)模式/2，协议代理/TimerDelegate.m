//
//  TimerDelegate.m
//  排序总结
//
//  Created by gjfax on 2018/9/10.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "TimerDelegate.h"

@implementation TimerDelegate

- (void)startTheTimer
{
    
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(timerProc) userInfo:nil repeats:NO];
}

- (void) timerProc
{
    [self.delegate updateAlert];//委托更新UI
    

}
@end
