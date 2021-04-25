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
 @synthesize是一个编译器指令, 它可以简化我们getter/setter方法的实现
 
 什么是实现:
 在声明后面写上大括号就代表着实现
 
 1.在@synthesize后面告诉编译器, 需要实现哪个@property生成的声明
 2. 告诉@synthesize, 需要将传入的值赋值给谁和返回谁的值给调用者
 
 - (void)setAge:(int)age
 {
    _age = age;
 }
 - (int)age
 {
    return _age;
 }
 */
//@synthesize age = _age;

/*
 - (void)setAge:(int)age
 {
    _number = age;
 }
 - (int)age
 {
    return _number
 ;
 }
 */
//@synthesize age = _number;


// 如果在@synthesize后面没有告诉系统将传入的值赋值给谁, 系统默认会赋值给和@synthesize后面写得名称相同的成员变量
// _age? age;
@synthesize age;

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

@end
