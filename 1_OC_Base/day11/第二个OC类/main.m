//
//  main.m
//  第二个OC类
//
//  Created by xiaomage on 15/6/16.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 要求定义一个人类
 事物的名称: 人(Person)
 属性: 年龄(age), 身高(height), 体重(weight)
 行为: 吃饭(eat), 睡觉(sleep), 散步(walk)
 */

@interface Person : NSObject
{
    @public
    // 属性
    int _age;
    double _height;
    double _weight;
}
// 行为
- (void)eat:(char *)food;

- (void)sleep;

- (void)walk;

+ (void)demo;

@end

@implementation Person

- (void)eat:(char *)food
{
    NSLog(@"吃%s", food);
}

- (void)sleep
{
    NSLog(@"开始睡觉");
}

- (void)walk
{
    NSLog(@"开始遛弯");
}

+(void)demo
{
    NSLog(@"demo");
}

@end


int main(int argc, const char * argv[]) {
    
    // 1.通过类创建对象
    /*
     1.开辟存储空间, 通过new方法创建对象会在堆 内存中开辟一块存储空间
     2.初始化所有属性
     3.返回指针地址
     
     创建对象的时候返回的地址其实就是类的第0个属性的地址
     但是需要注意的是: 类的第0个属性并不是我们编写的_age, 而是一个叫做isa的属性
     isa是一个指针, 占8个字节
     
     其实类也是一个对象, 也就意味着Person也是一个对象
     平时我们所说的创建对象其实就是通过一个 类对象 来创建一个 新的对象
     类对象是系统自动帮我们创建的, 里面保存了当前对象的所有方法
     而实例对象是程序字节手动通过new来创建的, 而实例对象中有一个isa指针就指向了创建它的那个类对象
     */
    Person *p = [Person new];
    p->_age = 30;
    p->_height = 1.75;
    p->_weight = 65.0;
    
    NSLog(@"age = %i , height = %f, weight = %f", p->_age, p->_height, p->_weight);
    /*
//    NSLog(@"p = %p", p);
//    NSLog(@"&age = %p", &(p->_age));
    
    [p walk];
    [Person demo];
     */
    /*
    struct Person
    {
        int age;
        char *name;
    };
    struct Person sp;
    NSLog(@"&sp = %p", &sp);
    NSLog(@"&age = %p", &sp.age);
     */
    
    // 每次new都会创建一个新的对象, 分配一块新的存储空间
    // 如果修改A的属性不会影响到B的属性
    // 一个类可以创建多个对象
    Person *p2 = [Person new];
    p2->_age = 50;
    p2->_height = 188;
    p2->_weight = 100;
    
    return 0;
}
