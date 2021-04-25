//
//  Person.h
//  day14
//
//  Created by xiaomage on 15/6/23.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

/*
 如果给一个属性同时提供了getter/setter方法, 那么我们称这个属性为可读可写属性
 如果只提供了getter方法, 那么我们称这个属性为只读属性
 如果只提供了setter方法, 那么我们称这个属性为只写属性
 如果既没有提供getter也没有提供setter方法, 那么我们称这个属性为私有属性
 
 
 格式:
 @property(属性修饰符) 数据类型 变量名称;
 */
// readwrite: 代表既生成getter方法 , 也生成setter方法
// 默认情况下 @property就是readwrite的
@property(readwrite) int age;
/*
 - (void)setHeight:(double)height;
 - (double)height;
 
 - (void)setHeight:(double)height;
 - (double)abc;
 */
@property(getter=abc) double height;

/*
 - (void)setWeight:(double)weight;
 - (void)tiZhong:(double)weight;
 */
@property(setter=tiZhong:) double weight;
// readonly: 代表只生成getter方法不生成setter方法
@property(readonly) NSString * name;

// 是否已婚
// 程序员之间有一个约定, 一般情况下获取BOOL类型的属性的值, 我们都会将获取的方法名称改为isXXX
@property(getter=isMarried) BOOL married;
@end
