//
//  JKCountDownButton.m
//  JKCountDownButton
//
//  Created by Jakey on 15/3/8.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "JKCountDownDateButton.h"
@interface NSTimer (JKCountDownBlocksSupport)
+ (NSTimer *)jkcd_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                           block:(void(^)(void))block
                                         repeats:(BOOL)repeats;
@end


@interface JKCountDownDateButton(){
   
}
@end

@implementation JKCountDownDateButton
#pragma -mark touche action
- (NSDate*)beginTime{
    return _beginTime;
}
- (NSDate*)endTime{
    return _endTime;
}
- (NSTimeInterval)secondsPassed{
    return [[NSDate date] timeIntervalSinceDate:_beginTime];
}
- (NSTimeInterval)secondsRemain{
    return [_endTime timeIntervalSinceDate:[NSDate date]];
}

+ (NSDictionary*)getDHMSInfoWithSeconds:(NSTimeInterval)seconds{
    
    NSInteger day = seconds/86400;
    NSInteger hour = (seconds-(day*86400))/3600;
    NSInteger minute = (seconds-(day*86400)-(hour*3600))/60;
    NSInteger second = (seconds-(day*86400)-(hour*3600)-minute*60);
    
    return  @{@"D":@(day),@"H":@(hour),@"M":@(minute),@"S":@(second)};
}
#pragma mark -  倒计时日期
- (void)countDownWithDate:(NSDate*)date{
    [self addTarget:self action:@selector(getEvent) forControlEvents:UIControlEventTouchUpInside];
    self.userInteractionEnabled = NO;
    
    [self stop];
    _endTime = date;
    _beginTime= [NSDate date];
    __weak typeof(self) weakSelf = self;
    _timer = [NSTimer jkcd_scheduledTimerWithTimeInterval:1.0 block:^{
        typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf changeText];
    } repeats:YES];
    
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}

#pragma mark -  倒计时秒
- (void)countDownWithTimeInterval:(NSTimeInterval)timeInterval{
    [self stop];
    _endTime = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    _beginTime= [NSDate date];
    __weak typeof(self) weakSelf = self;
    _timer = [NSTimer jkcd_scheduledTimerWithTimeInterval:1.0 block:^{
        typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf changeText];
    } repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}
#pragma mark -  点击回调
- (void)getEvent {
    if (_countDownClick) {
        GJWeakSelf;
        dispatch_async(dispatch_get_main_queue(), ^{
            self->_countDownClick(weakSelf);
        });
    }
}
#pragma mark -  显示变化
- (void)changeText{
    NSDate *date = [NSDate date];
    
    NSTimeInterval deltaTime = [_endTime timeIntervalSinceDate:date];
    
    NSDictionary *DHMSInfo =  [[self class] getDHMSInfoWithSeconds:deltaTime];
    
    NSInteger D = [[DHMSInfo objectForKey:@"D"] integerValue];
    NSInteger H = [[DHMSInfo objectForKey:@"H"] integerValue];
    NSInteger M = [[DHMSInfo objectForKey:@"M"] integerValue];
    NSInteger S = [[DHMSInfo objectForKey:@"S"] integerValue];
    
    NSString *defaultText = [NSString stringWithFormat:@"%0.3zd :%0.2zd : %0.2zd : %0.2zd", D,H,M,S];
    
    
    if (deltaTime <=0.0) {
        [self stop];
        return;
    }else{
        if (_countDownChange) {
            [self setTitle:_countDownChange(self,_endTime,deltaTime,DHMSInfo,defaultText) forState:UIControlStateNormal];
        }else{
            
            [self setTitle:defaultText forState:UIControlStateNormal];
        }
    }
}
#pragma mark -  停止
- (void)stop{
    
    if (_timer) {
        if ([_timer respondsToSelector:@selector(isValid)])
        {
            if ([_timer isValid])
            {
                [_timer invalidate];
                if (_countDownFinished)
                {
                    self.userInteractionEnabled = YES;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self setTitle:self->_countDownFinished(self,self->_endTime,0,@"00 : 00 : 00 : 00") forState:UIControlStateNormal];
                    });
                }
                else
                {
                     [self setTitle:@"00 : 00 : 00 : 00" forState:UIControlStateNormal]; 
                }
            }
        }
    }
}

- (void)countDownChanging:(CountDownButtonChange)countDownChange{
    _countDownChange = [countDownChange copy];
}
- (void)countDownFinished:(CountDownButtonFinished)countDownFinished{
    _countDownFinished = [countDownFinished copy];
}

- (void)countDownClick:(CountDownButtonClick)countDownClick {
    _countDownClick = [countDownClick copy];
}
@end


@implementation NSTimer (JKCountDownBlocksSupport)
+ (NSTimer *)jkcd_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                           block:(void(^)(void))block
                                         repeats:(BOOL)repeats
{
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(jkcd_blockInvoke:)
                                       userInfo:[block copy]
                                        repeats:repeats];
}
+ (void)jkcd_blockInvoke:(NSTimer *)timer {
    void (^block)(void) = timer.userInfo;
    if(block) {
        block();
    }
}
@end
