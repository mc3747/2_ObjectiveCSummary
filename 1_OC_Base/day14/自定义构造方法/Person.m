//
//  Person.m
//  day14
//
//  Created by xiaomage on 15/6/23.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//


#import "Person.h"

@implementation Person

- (instancetype)init
{
    if (self = [super init]) {
        _age = 10;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"age = %i, name = %@", _age, _name];
}

- (instancetype)initWithAge:(int)age
{
    if (self = [super init]) {
        _age = age;
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name
{
    if (self  =[super init]) {
        _name = name;
    }
    return self;
}

- (instancetype)initWithAge:(int)age andName:(NSString *)name
{
    if (self = [super init]) {
        _age = age;
        _name = name;
    }
    return self;
}
@end
