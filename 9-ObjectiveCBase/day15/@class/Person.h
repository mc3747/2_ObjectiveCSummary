//
//  Person.h
//  day15
//
//  Created by xiaomage on 15/6/24.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Car.h"
// 由于import是一个预编译指令, 他会将""中的文件拷贝到import所在的位置
// 并且import有一个特点, 只有""中的文件发生了变化, 那么import就会重新拷贝一次(更新操作)
@class Car;
// @class仅仅是告诉编译器, @class后面的名称是一个类, 不会做任何拷贝操作
// 注意: 由于@class仅仅是告诉编译器后面的名称是一个类, 所以编译器并不知道这个类中有哪些属性和方法, 所以在.m中使用这个类时需要import这个类, 才能使用

/*
 总结:
 1.如果都在.h中import, 假如A拷贝了B, B拷贝了C ,  如果C被修改了, 那么B和A都需要重新拷贝. 因为C修改了那么B就会重新拷贝, 而B重新拷贝之后相当于B也被修改了, 那么A也需要重新拷贝. 也就是说如果都在.h中拷贝, 只要有间接关系都会重新拷贝
 2.如果在.h中用@class, 在.m中用import, 那么如果一个文件发生了变化, 只有和这个文件有直接关系的那个文件才会重新拷贝
 3.所以在.h中用@class可以提升编译效率
 
 */
@interface Person : NSObject

@property(nonatomic, retain)Car *car;
@end
