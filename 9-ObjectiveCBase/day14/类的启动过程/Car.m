//
//  Car.m
//  day14
//
//  Created by xiaomage on 15/6/23.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//


#import "Car.h"

@implementation Car
+ (void)load
{
    NSLog(@"Car类被加载到内存了");
}
+ (void)initialize
{
    NSLog(@"Car initialize");
}
@end
