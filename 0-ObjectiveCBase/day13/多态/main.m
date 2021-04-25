//
//  main.m
//  多态
//
//  Created by xiaomage on 15/6/19.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dog.h"
#import "Cat.h"
#import "Animal.h"
#import "Person.h"
#import "Pig.h"

int main(int argc, const char * argv[]) {

    /*
    Dog *d = [Dog new];
    [d eat];
    
    Cat *c = [Cat new];
    [c eat];
     */
    
    /*
    // 多态: 事物的多种表现形态
    // 动态类型: 在编译的时候编译器只会检查当前类型对应的类中有没有需要调用的方法
    //          在运行时,系统会自动判断a1的真实类型
    Animal *a1 = [Dog new];
    [a1 eat];
    
    // 注意点: 在多态中, 如果想调用子类特有的方法必须强制类型转换为子类才能调用
//    [a1 kanJia];
    Dog *d1 = (Dog *)a1;
    [d1 kanJia];
     */
    
    Dog *d = [Dog new];
    Cat *c = [Cat new];
    Pig *p = [Pig new];
    
    [Person food:d];
    [Person food:c];
    [Person food:p];
    /*
     什么是多态:
     事物的多种表现形态
     
     在程序中如何表现:
     父类指针指向子类对象
     
     优点:
     提高了代码的扩展性
     
     注意点:
     如果父类指针指向子类对象, 如果需要调用子类特有的方法, 必须先强制类型转换为子类才能调用
    */
    
    
    return 0;
}
