//
//  Kline.m
//  day13
//
//  Created by xiaomage on 15/6/19.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//


#import "Kline.h"

@implementation Kline

- (void)setMin:(int)min
{
    _min = min;
    // 每次重新设置最小值, 那么就重新计算平均值
    _average = (_min + _max) / 2;
}

- (void)setMax:(int)max
{
    _max = max;
    // 每次重新设置最大值, 那么就重新计算平均值
    _average = (_min + _max) / 2;
}

- (void)setAverage:(int)average
{
    _average = average;
}

- (int)min
{
    return _min;
}

- (int)max
{
    return _max;
}

- (int)average
{
    return _average;
}
@end
