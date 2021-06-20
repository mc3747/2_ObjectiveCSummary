//
//  Person.m
//  day14
//
//  Created by xiaomage on 15/6/23.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//


#import "Person.h"

@implementation Person

/*
+ (instancetype)person
{
    Person *p = [Person alloc];
    Person *p1 = [p init];
    return p1;
}
 */
+ (instancetype)person
{
    return [[Person alloc] init];
}

+ (instancetype)personWithAge:(int)age
{
    Person *p = [[Person alloc] init];
    p.age = age;
    return p;
}

@end
