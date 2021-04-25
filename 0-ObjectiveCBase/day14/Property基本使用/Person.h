//
//  Person.h
//  day14
//
//  Created by xiaomage on 15/6/23.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    int _age;
    double _height;
    double _weight;
    NSString *_name;
}

/*
 setter: 
 作用: 用于给成员变量赋值
 1.一定是对象方法
 2.一定没有返回值
 3.方法名称以set开头, 后面跟上需要赋值的成员变量名称, 并且去掉下划线, 然后首字母大写
 4.一定有参数, 参数类型和需要赋值的成员变量一直, 参数名称就是需要赋值的成员变量名称去掉下划线
 */
//- (void)setAge:(int)age;
- (void)setHeight:(double)height;
- (void)setWeight:(double)weight;
- (void)setName:(NSString *)name;

/*
@porperty是一个编译器指令
 在Xocde4.4之前, 可以使用@porperty来代替getter/setter方法的声明
 也就是说我们只需要写上@porperty就不用写getter/setter方法的声明
 
 编译器只要看到@property, 就知道我们要生产某一个属性的getter/setter方法的声明
 
 - (void)setAge:(int)age;
 - (int)age;
 */
@property int age;

/*
 - (void)set_age:(int)_age;
 - (int)_age;
 */
@property int _age;

/*
 getter:
 作用: 用于获取成员变量的值
 1.一定是对象方法
 2.一定有返回值, 返回值类型和需要获取的成员变量的类型一致
 3.方法名称就是需要获取的成员变量的名称去掉下划线
 4.一定没有参数
 */
//- (int)age;
- (double)height;
- (double)weight;
- (NSString *)name;

@end
