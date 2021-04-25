//
//  Person.m
//  day15
//
//  Created by xiaomage on 15/6/24.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//


#import "Person.h"

@implementation Person


- (void)dealloc
{
//    NSLog(@"Person dealloc");
    NSLog(@"%s", __func__);
    
    [super dealloc];
}
@end
