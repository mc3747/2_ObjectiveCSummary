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
    // 封装还有一个好处: 监听属性的变化
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
//    NSLog(@"重新计算平均值");
    // 最大值和最小值, 再次期间并没有发生变化
    // 只有最大值和最小值发生变化的时候才需要重新计算
//    return (_max + _min) / 2;
    return _average;
}
@end
