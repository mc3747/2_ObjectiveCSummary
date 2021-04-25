//
//  Person.h
//  day15
//
//  Created by xiaomage on 15/6/24.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Room.h"
#import "Car.h"
#import "Dog.h"

@interface Person : NSObject
{
    Room *_room;
    Car *_car;
    Dog *_dog;
}
/*
- (void)setRoom:(Room *)room;
- (void)setCar:(Car *)car;
- (void)setDog:(Dog *)dog;

- (Room *)room;
- (Car *)car;
- (Dog *)dog;
 */
@property(nonatomic, retain) Room *room;

// 1.相同类型的property修饰符不能同时使用
// 2.不同类型的property修饰符可以多个结合在一起使用, 多个之间用,号隔开
// 3.iOS开发中只要写上property, 那么就立刻写上nonatomic

/*
 - (void)setAge:(int)age;
 - (int)age;
 
 - (void)setAge:(int)age
 {
    _age = age;
 }
 - (int)age
 {
    return _age;
 }
 
 readonly: 只会生成getter方法
 readwrite: 既会生成getter也会生成setter, 默认什么都不写就是readwrite
 
 getter: 可以给生成的getter方法起一个名词
 setter: 可以给生成的setter方法起一个名词
 
 retain: 就会自动帮我们生成getter/setter方法内存管理的代码
 assign: 不会帮我们生成set方法内存管理的代码, 仅仅只会生成普通的getter/setter方法, 默认什么都不写就是assign
 
 多线程
 atomic ：性能低（默认）
 nonatomic ：性能高
 在iOS开发中99.99%都是写nonatomic
*/
@end
