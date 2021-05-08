//
//  Person.m
//  day13
//
//  Created by xiaomage on 15/6/19.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//


#import "Person.h"

@implementation Person

- (void)setAge:(int)age
{
    _age = age;
}

- (void)setHeight:(double)height
{
    _height = height;
}

- (void)setName:(NSString *)name
{
    _name = name;
}

- (int)age
{
    return _age;
}

- (double)height
{
    return _height;
}

- (NSString *)name
{
    return _name;
}

- (void)test
{
    NSLog(@"test");
}
@end
