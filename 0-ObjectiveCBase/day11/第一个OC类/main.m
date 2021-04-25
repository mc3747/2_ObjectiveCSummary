//
//  main.m
//  第一个OC类
//
//  Created by xiaomage on 15/6/16.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 事物名称: iPhone
 属性: 颜色, 型号, cpu, 尺寸   == 成员变量
 行为:打电话, 发短信, 上网     == 成员方法

 C语言中函数分为声明和实现
 OC中定义一个类也分为声明和实现, 也就是说以后我们在OC中定义类, 就是在写类的声明和实现
 */

// 1.如果编写类的声明
// 以@interface开头 , 以@end结尾, 然后再class name对应的地方写上 事物名称, 也就是类名即可
// 注意: 类名的首字符必须大写
// 声明一个类的目的就是为了告诉系统, 我们这个类中有哪些属性和行为

// OC类声明中属性只能在写@interface和@end之间的{}中
// 注意: 编写OC类属性的时, 建议将所有属性的名称前面都加上_


// 类名后面的 :NSObject 是为了让我们的Iphone类具备创建对象的能力
@interface Iphone : NSObject
{
//    注意: 默认情况下, OC对象中的属性是不能直接访问的
    @public  // 只要让类中的属性公开, 以后就可以直接通过一个指向结构体的指针来操作对象中的属性
    float _model; // 型号  0
    int _cpu; // cup   0
    double _size; // 尺寸  0
    int _color; // 颜色  0
}

// 行为
@end

// 2.如何编写类的实现
// 以@implementation开头, 以@end结尾, 然后在class对应的地方写上声明时声明的类的名称, 必须和声明的类名一模一样
@implementation Iphone
// 行为的实现

@end


int main(int argc, const char * argv[]) {
    // 如何通过一个类来创建对象
    // 在OC中想要通过一个类来创建一个对象, 必须给类发送一个消息(好比C语言中调用方法一样)
    // 如何发送消息?   在OC中只要想要发送消息就先写上 [类名称/对象名称 方法名称];
    // 发送什么消息(调用什么方法)可以创建一个对象呢? new
    
    /*
     只要通过一个类调用类的new方法, 也就是给类发送一个叫做new的消息之后
     系统内部就会做3件事情
     1. 为Iphone类创建出来得对象分配存储空间
     2. 初始化Iphone类创建出来的对象中的属性
     3. 返回Iphone类创建出来的对象对应的地址
     */
    
    // 通过一个Iphone类型的指针接收了 Iphone对象的地址
    // 如果使用给一个指针保存了某一个对象的地址, 那么我们就称这个指针位之为某个类型的对象
    // 利用Iphone类型的指针保存了Iphone对象的地址, 那么我们就称Iphone类型的指针p之为Iphone对象
   Iphone *p = [Iphone new];
    p->_size = 3.5;
    p->_color = 0;
    p->_model = 4;
    p->_cpu = 1;
    
    // OC中的类其实本质就是一个结构体, 所以p这个指针其实就是指向了一个结构体
    NSLog(@"size = %f, color = %i, model = %f, cpu = %i", p->_size, p->_color, p->_model, p->_cpu);
    /*
    struct Person
    {
        int age;
        char *name;
    };
    struct Person sp;
    struct Person *sip = &sp;
    
//    (*sip).age = 30;
//    (*sip).name = "lnj";
    
    sip->age = 30;
    sip->name = "lnj";
    
    printf("age = %i, name = %s\n", sip->age,  sip->name );
    */
    
    // 什么是用于保存地址的? 指针

    return 0;
}
