//
//  Student.m
//  day18
//
//  Created by xiaomage on 15/6/29.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//


#import "Student.h"

@implementation Student

- (id)copyWithZone:(NSZone *)zone
{
    // 1.创建副本
//    id obj = [[self class] allocWithZone:zone];
    id obj = [super copyWithZone:zone];
    // 2.设置数据给副本
//    [obj setAge:[self age]];
//    [obj setName:[self name]];
    [obj setHeight:_height];
    
    // 3.返回副本
    return obj;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"name = %@, age = %i, height = %f", [self name], [self age], _height];
}
@end
