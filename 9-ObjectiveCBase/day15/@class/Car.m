//
//  Car.m
//  day15
//
//  Created by xiaomage on 15/6/24.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//


#import "Car.h"
#import "Wheel.h"

@implementation Car

- (void)dealloc
{
    [_wheel release];
    [super dealloc];
}
@end
