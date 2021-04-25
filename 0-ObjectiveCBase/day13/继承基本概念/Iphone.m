//
//  Iphone.m
//  day13
//
//  Created by xiaomage on 15/6/19.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//


#import "Iphone.h"

@implementation Iphone
/*
- (void)signalWithNumber:(NSString *)number
{
    NSLog(@"利用iPhone手机打电话给%@", number);
}

- (void)sendMessageWithNumber:(NSString *)number andContent:(NSString *)content
{
    NSLog(@"利用iPhone手机发短信给%@, 内容是%@", number, content);
}
 */

- (void)setCpu:(int)cpu
{
    _cpu = cpu;
}

- (int)cpu
{
    return _cpu;
}
@end
