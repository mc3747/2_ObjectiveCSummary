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
    NSLog(@"%s", __func__);
//    [_owner release];
//    self.owner = nil;
    [super dealloc];
}
@end
