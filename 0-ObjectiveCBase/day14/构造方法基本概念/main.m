//
//  main.m
//  构造方法基本概念
//
//  Created by xiaomage on 15/6/23.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    /*
     在OC中init开头的方法, 我们称之为构造方法
     构造方法的用途: 用于初始化一个对象, 让某个对象一创建出来就拥有某些属性和值
     */
    Person *p = [[Person alloc] init];
//    p.age = 6;
    NSLog(@"%i", p.age);
    
    Person *p2 = [[Person alloc] init];
//    p2.age = 6;
    NSLog(@"%i", p2.age);
    
    Person *p3 = [[Person alloc] init];
//    p3.age = 6;
    NSLog(@"%i", p3.age);
    
    return 0;
}
