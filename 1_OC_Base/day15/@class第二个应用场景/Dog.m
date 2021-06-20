//
//  Dog.m
//  day15
//
//  Created by xiaomage on 15/6/24.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//


#import "Dog.h"
#import "Person.h"

@implementation Dog

-(void)dealloc
{
    [_owner release];
    NSLog(@"%s", __func__);
    [super dealloc];
}
@end
