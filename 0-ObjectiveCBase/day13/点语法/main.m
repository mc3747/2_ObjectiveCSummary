//
//  main.m
//  点语法
//
//  Created by xiaomage on 15/6/19.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    
    Person *p = [Person new];
    /*
    p->_age = 30;
    p->_name = @"lnj";
    p->_height = 1.75;
    
    NSLog(@"age = %i, name = %@, height = %f", p->_age, p->_name, p->_height);
     */
    
    /*
    [p setName:@"lnj"];
    [p setAge:30];
    [p setHeight:1.75];
    NSLog(@"age = %i, name = %@, height = %f", [p age], [p name], [p height]);
     */
    
    // 如果给属性提供了getter和setter方法, 那么访问属性就又多了一种访问方式 , 点语法
    // 点语法其实它的本质是调用了我们的setter和getter方法
    // 点语法是一个编译器的特性, 会在程序翻译成二进制的时候将.语法自动转换为setter和getter方法
    // 如果点语法在=号的左边, 那么编译器会自动转换为setter方法
    // 如果点语法在=号的右边, 或者没有等号, 那么编译器就会自动转换为getter方法
    p.name = @"lnj";
//  [p setName:@"lnj"];
    p.age = 30;
    p.height = 1.75;
    NSLog(@"age = %i, name = %@, height = %f", p.age, p.name, p.height);
//     p.age
//    [p age];
    
    /*
     点语法的注意点:
     点语法一般用于给成员变量赋值, 如果不是给成员变量赋值一般情况下不建议使用, 但是也可以使用
     
     */
    p.test; // [p test];
    return 0;
}
