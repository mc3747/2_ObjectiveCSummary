//
//  JKCountDownButton.h
//  JKCountDownButton
//
//  Created by Jakey on 15/3/8.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JKCountDownDateButton;

typedef  NSString* (^CountDownButtonChange)(JKCountDownDateButton *countDownLable,NSDate *endTime,NSTimeInterval seconds,NSDictionary *DHMSInfo,NSString *defaultText);

typedef NSString* (^CountDownButtonFinished)(JKCountDownDateButton *countDownLable,NSDate *endTime,NSTimeInterval seconds,NSString *defaultText);

typedef void (^CountDownButtonClick)(JKCountDownDateButton *countDownButton);

@interface JKCountDownDateButton : UIButton
{
    NSTimer *_timer;
    NSDate *_endTime;
    NSDate *_beginTime;
    CountDownButtonChange _countDownChange;
    CountDownButtonFinished _countDownFinished;
    CountDownButtonClick _countDownClick;
}
//倒计时开始时间
- (NSDate*)beginTime;
//倒计时结束时间
- (NSDate*)endTime;
//倒计时过去了N秒
- (NSTimeInterval)secondsPassed;
//倒计时还有N秒
- (NSTimeInterval)secondsRemain;
///截止日期
- (void)countDownWithDate:(NSDate*)date;
///距离当前时间timeInterval秒的截止日期
- (void)countDownWithTimeInterval:(NSTimeInterval)timeInterval;
///根据秒获取天,时,分,秒信息  key分别是 D H M S,value为NSIntger的NSNumber类型.
+ (NSDictionary*)getDHMSInfoWithSeconds:(NSTimeInterval)seconds;


//倒计时时间改变回调
- (void)countDownChanging:(CountDownButtonChange)countDownChanging;

//倒计时结束回调
- (void)countDownFinished:(CountDownButtonFinished)countDownFinished;

///倒计时按钮点击回调
- (void)countDownClick:(CountDownButtonClick)countDownClick;
@end



