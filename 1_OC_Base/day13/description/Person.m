//
//  Person.m
//  day13
//
//  Created by xiaomage on 15/6/19.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//


#import "Person.h"

@implementation Person

- (void)setAge:(int)age
{
    _age = age;
}
- (void)setHeigth:(double)height
{
    _height = height;
}
- (void)setWeight:(double)weight
{
    _weight = weight;
}
- (void)setName:(NSString *)name
{
    _name = name;
}
- (void)setTel:(NSString *)tel
{
    _tel = tel;
}
- (void)setEmail:(NSString *)email
{
    _email = email;
}

- (int)age
{
    return _age;
}
- (double)height
{
    return _height;
}
- (double)weight
{
    return _weight;
}
- (NSString *)name
{
    return _name;
}
- (NSString *)tel
{
    return _tel;
}
- (NSString *)email
{
    return _email;
}

// 可以重写description方法, 返回我们需要打印的内容
// 只要利用%@打印对象, 就会调用description
// 如果打印的是对象就会调用-号开头的description方法
- (NSString *)description 
{
    
    /*
     访问属性有三种方式
     p->_age;
     [p age];
     p.age;
     
     self写在对象方法中就代表当前调用该方法的对象
     self.age; // [self age];
     self->age;
     [self age];
     */
    /*
//    return @"xxoo";
    NSString *str = [NSString stringWithFormat:@"age = %i, name = %@, height = %f, weight = %f, tel = %@, email = %@", _age, _name, _height, _weight, _tel, _email];
    return str;
     */
    NSLog(@"-------------");
    // 建议: 在description方法中尽量不要使用self来获取成员变量\
    因为如果你经常在description方法中使用self, 可能已不小心就写成了 %@, self
    // 如果在description方法中利用%@输出self会造成死循环
    // self == person实例对象
    return [NSString stringWithFormat:@"%@", self.name];
}

// 仅仅作为了解, 开发中99%的情况使用的都是-号开头的description
+ (NSString *)description
{
    return @"ooxx";
}
/*
 如果通过%@打印对象就会调用-号开头的
 如果通过%@打印类对象就会调用+号开头的
 */
@end
