//
//  main.m
//  局部变量和全局变量以及成员变量的区别
//
//  Created by xiaomage on 15/6/16.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Person : NSObject
{
    // 写在类声明的大括号中的变量, 我们称之为 成员变量(属性, 实例变量)
    // 成员变量只能通过对象来访问
    // 注意: 成员变量不能离开类, 离开类之后就不是成员变量 \
            成员变量不能在定义的同时进行初始化
    // 存储: 堆(当前对象对应的堆的存储空间中)
    // 存储在堆中的数据, 不会被自动释放, 只能程序员手动释放
    int age;
}
@end

@implementation Person


@end

// 写在函数和大括号外部的变量, 我们称之为全局变量
// 作用域: 从定义的那一行开始, 一直到文件末尾
// 局部变量可以先定义在初始化, 也可以定义的同时初始化
// 存储: 静态区
// 程序一启动就会分配存储空间, 直到程序结束才会释放
int a;
int b = 10;

int main(int argc, const char * argv[]) {
    // 写在函数或者代码块中的变量, 我们称之为局部变量
    // 作用域: 从定义的那一行开始, 一直到遇到大括号或者return
    // 局部变量可以先定义再初始化, 也可以定义的同时初始化
    // 存储 : 栈
    // 存储在栈中的数据有一个特点, 系统会自动给我们释放
    int num = 10;
    {
        int value;
    }
    return 0;
}
