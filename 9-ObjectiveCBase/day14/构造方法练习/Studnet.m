//
//  Studnet.m
//  day14
//
//  Created by xiaomage on 15/6/23.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//


#import "Studnet.h"

@implementation Studnet

- (instancetype)init
{
    if (self = [super init]) {
//        [self setAge:10];
        _no = 1;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"age = %i , no = %i", [self age], _no];
}
@end
