//
//  Dog.m
//  day16
//
//  Created by xiaomage on 15/6/26.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//


#import "Dog.h"

@implementation Dog

- (void)dealloc
{
    [_bone release];
    [super dealloc];
}
@end
