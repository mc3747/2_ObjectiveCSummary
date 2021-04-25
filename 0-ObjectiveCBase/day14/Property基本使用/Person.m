//
//  Person.m
//  day14
//
//  Created by xiaomage on 15/6/23.
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

- (void)setWeight:(double)weight
{
    _weight = weight;
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
- (double)weight
{
    return _weight;
}
- (NSString *)name
{
    return _name;
}
@end
