//
//  Person.m
//  day15
//
//  Created by xiaomage on 15/6/24.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//


#import "Person.h"
#import "Dog.h"

@implementation Person


- (void)dealloc
{
    NSLog(@"%s", __func__);
//    [_dog release];
    self.dog = nil;
    [super dealloc];
}
@end
