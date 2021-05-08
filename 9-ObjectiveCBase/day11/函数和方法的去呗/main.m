//
//  main.m
//  函数和方法的去呗
//
//  Created by xiaomage on 15/6/16.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 函数和方法的区别
 1.函数属于整个文件, 方法属于某一个类
 方法如果离开类就不行
 2.函数可以直接调用, 方法必须用对象或者类来调用
 注意: 虽然函数属于整个文件, 但是如果把函数写在类的声明中会不识别
 3.不能把函数当做方法来调用, 也不能把方法当做函数来调用
 
 方法的注意点:
 >方法可以没有声明只有实现
 >方法可以只有声明没有实现, 编译不会报错, 但是运行会报错
 如果方法只有声明没有实现, 那么运行时会报: 
 reason: '+[Person demo]: unrecognized selector sent to class 0x100001140'
 发送了一个不能识别的消息, 在Person类中没有+开头的demo方法
 reason: '-[Person test]: unrecognized selector sent to instance 0x100400000'
 
 
 类也有一个注意点:
 类可以只有实现没有声明
 注意: 在开发中不建议这样写
 
 */

//@interface Person : NSObject
//// 对象方法声明
//- (void)test;
//// 类方法声明
//+ (void)demo;
//
//@end

@implementation Person : NSObject
// 对象方法实现
- (void)test
{
    NSLog(@"test");
}
// 类方法实现
+ (void)demo
{
    NSLog(@"demo");
}

@end



// 外部函数的声明
extern void sum();
// 内部函数的声明
static void minus();
// 外部函数
extern void sum()
{
    printf("sum");
}
// 内部函数
static void minus()
{
    printf("minus");
}


int main(int argc, const char * argv[]) {
    sum();
//    [Person demo];
//    demo();
//    [Person sum];
//    [Person demo];
    Person *p = [Person new];
    [p test];
    
    return 0;
}
