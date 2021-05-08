//
//  Person.m
//  day14
//
//  Created by xiaomage on 15/6/23.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//


#import "Person.h"

@implementation Person
{
    // 实例变量(成员变量)既可以在@interface中定义, 也可以在@implementation中定义
    // 写在@implementation中的成员变量, 默认就是私有的成员变量, 并且和利用@private修饰的不太一样, 在@implementation中定义的成员变量在其它类中无法查看, 也无法访问
    // 在@implementation中定义的私有变量只能在本类中访问
    @public
    double _score;
}

- (void)test
{
    NSLog(@"score = %f", _score);
}
@end
