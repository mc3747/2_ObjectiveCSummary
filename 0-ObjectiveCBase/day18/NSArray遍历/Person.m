//
//  Person.m
//  day18
//
//  Created by xiaomage on 15/6/29.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//


#import "Person.h"

@implementation Person

-(void)say
{
    NSLog(@"加油");
}

- (void)sayWithName:(NSString *)name
{
    NSLog(@"%@ 加油", name);
}
@end
