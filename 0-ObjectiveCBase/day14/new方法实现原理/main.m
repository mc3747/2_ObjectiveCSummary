//
//  main.m
//  new方法实现原理
//
//  Created by xiaomage on 15/6/23.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {

    /*
     new做了三件事情
     1.开辟存储空间  + all®oc 方法
     2.初始化所有的属性(成员变量) - init 方法
     3.返回对象的地址
     */
//    Person *p = [Person new];®
    // alloc做了什么事情: 1.开辟存储空间 2.将所有的属性设置为0 3.返回当前实例对象的地址
    Person *p1 = [Person alloc];
    NSLog(@"%d", p1.age);
    // 1.初始化成员变量, 但是默认情况下init的实现是什么都没有做 2.返回初始化后的实例对象地址
    Person *p2 =  [p1 init];
    // [[Person alloc] init];
    
    // 注意: alloc返回的地址, 和init返回的地址是同一个地址
    NSLog(@"p1 = %p, p2 = %p", p1, p2);
    
    // [[Person alloc] init]; == [Person new];
    // 建议大家以后创建一个对象都使用 alloc init, 这样可以统一编码格式
    Person *p3 = [[Person alloc] init];
    
    return 0;
}
