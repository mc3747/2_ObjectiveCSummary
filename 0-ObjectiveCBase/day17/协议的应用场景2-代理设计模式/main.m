//
//  main.m
//  协议的应用场景2-代理设计模式
//
//  Created by xiaomage on 15/6/28.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Baby.h"
#import "Nanny.h"
#import "Studnet.h"
#import "Teacher.h"
#import "Dog.h"


int main(int argc, const char * argv[]) {
    // 1.创建婴儿
    Baby *b = [Baby new];
    // 2.创建保姆
//    Nanny *n = [Nanny new];
    // 3.将保姆赋值给婴儿呢
//    b.nanny = n;
    
    // 4.换保姆
//    Studnet *stu = [Studnet new];
//    b.nanny = stu;
    
    // 5.再次换保姆
//    Teacher *tea = [Teacher new];
//    b.nanny = tea;
    
    Dog *d = [Dog new];
    b.nanny = d;
    
    //4.婴儿发飙
    [b food];
    [b sleepy];
     
    return 0;
}
