//
//  main.m
//  练习
//
//  Created by xiaomage on 15/6/18.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//


#import <Foundation/Foundation.h>

/*
@interface Car : NSObject
{
@public
    int wheels;
}

// 方法的生命必须写在类的声明中
- (void)run;
- (void)test;
@end



@implementation Car
- (void)test
{
    NSLog(@"测试一下车子：%i", wheels);
}

// 方法不能使用函数来实现, 方法是方法, 函数是函数
// 方法属性一个类, 函数属于一个文件
//void run()
- (void)run
{
    NSLog(@"%i个轮子的车跑起来了", wheels); // 不能在一个函数中访问类的成员变量
}

// 方法的实现只能写在@implementation和@end之间
- (void)haha
{
    NSLog(@"调用了haha");
}
@end


int main()
{
    Car *c = [Car new];
    [c run];
//    test(); // 方法不能当做函数来对象 , 对象方法只能用对象调用
    [c test];
//    haha();
    [c haha];
    
    return 0;
}
*/

/*
@interface Test : NSObject

- (int)addNum1:(int)num1 andNum2:(int)num2; // 每个参数数据类型前面都必须写上:

- (double)pi; // 没有参数就不要写:

- (void)test; // 在OC方法中()就一个作用, 用来扩住数据类型
@end

@implementation Test

- (int)addNum1:(int)num1 andNum2:(int)num2
{
    return num1 + num2;
}

- (double)pi
{
    return 3.14;
}

- (void)test
{
    
}
@end

int main()
{
    return 0;
}
*/

/*
@interface Person : NSObject
{
    @public
    int age;
    double height; // 成员变量不能在定义的时候进行初始化
}
- (void)study; // 方法只能写在{}外面

// 缺少@end
@end

@implementation Person
- (void)study
{
    NSLog(@"年龄为%d的人在学习", age);
}
@end

int main()
{
    // 地址只能使用指针保存
    Person *p = [Person new];
    p->age = 10;
    p->height = 1.78f;
    [p study];
    return 0;
}
*/