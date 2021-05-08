//
//  Iphone.m
//  day13
//
//  Created by xiaomage on 15/6/19.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//


#import "Iphone.h"

@implementation Iphone

- (void)setCpu:(int)cpu
{
    _cpu = cpu;
}

- (int)cpu
{
    return _cpu;
}


- (void)signalWithNumber:(NSString *)number
{
    NSLog(@"利用 iphone 打电话给 %@", number);
}

+ (void)brand
{
    NSLog(@"iPhone手机");
}

@end
