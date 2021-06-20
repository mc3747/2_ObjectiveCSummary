//
//  Person.m
//  day16
//
//  Created by xiaomage on 15/6/26.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//


#import "Person.h"

@implementation Person

+ (instancetype)person
{
    return [[[self alloc] init] autorelease];
}


- (instancetype)initWithAge:(int)age
{
    if (self = [super init]) {
        _age = age;                  
    }
    return self;
}

+ (instancetype)personWithAge:(int)age
{
    /*
    Person *p = [[self alloc] init];
    p.age = age;
    return [p autorelease];
     */
    return [[[self alloc] initWithAge:age] autorelease];
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
    [super dealloc];
}
@end
