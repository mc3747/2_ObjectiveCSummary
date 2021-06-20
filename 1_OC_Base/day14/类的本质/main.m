//
//  main.m
//  类的本质
//
//  Created by xiaomage on 15/6/23.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Car.h"
void demo(Class c);

int main(int argc, const char * argv[]) {

    /*
     类的本质:
     类其实也是一个对象, 这个对象会在这个类第一次被使用的时候创建
     只要有了类对象, 将来就可以通过类对象来创建实例对象
     实例对象中有一个isa指针, 指向创建自己的类对象
     
     类对象中保存了当前对象所有的对象方法
     当给一个实例对象方法消息的时候, 会根据实例对象中的isa指针去对应的类对象中查找
     */
    /*
    Person *p = [[Person alloc] init];
    [p setAge:30];
    [Person test];
     */
    
    // 1.如何获取类对象
    // [实例对象 class];  [类名 class];
    Person *p1 = [[Person alloc] init];
    Person *p2 = [[Person alloc] init];
    // 一个类再内存中只有一份类对象
    Class c1 = [p1 class];
    Class c2 = [p2 class];
    Class c3 = [Person class];
    NSLog(@"c1 = %p, c2 = %p, c3 = %p", c1, c2, c3);
    
    // 2.类对象的应用场景
    // 2.1用于创建实例对象
    Person *p3 = [[c1 alloc] init];
    p3.age = 30;
    NSLog(@"%i", p3.age);
    // 2.2用于调用类方法
//    [Person test];
    [c1 test];
    
    
    demo(c1);
    demo([Car class]);
    return 0;
}


void demo(Class c)
{
    id obj = [[c alloc] init];
    NSLog(@"%@", obj);
}