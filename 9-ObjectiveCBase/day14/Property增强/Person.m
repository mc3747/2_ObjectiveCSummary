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
 - (void)setAge:(int)age
 {
    _age = age;
 }
 - (int)age
 {
    return _age;
 }
 */

// 如果重写了setter方法, 那么property就只会生成getter方法
// 如果重写了getter方法, 那么property就只会生成setter方法
// 如果同时重写了getter/setter方法, 那么property就不会自动帮我们生成私有的成员变量
- (void)setAge:(int)age
{
    if (age < 0) {
        age = 0;
    }
    _age = age;
}

//- (int)age
//{
//    return _age;
//}
@end
