//
//  Person.h
//  day16
//
//  Created by xiaomage on 15/6/26.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Dog;

@interface Person : NSObject

// MRC, A对象想拥有B对象, 需要对B对象进行一次retain
//      A对象不用B对象了, 需要对B对象进行一次release
//      property的时候进行retain, dealloc的时候进行release


// ARC, A对象想拥有B对象, 那么就需要用一个强指针指向B对象
//      A对象不用B对象了, 什么都不需要做, 编译器会自动帮我们做


// 在ARC中保存一个对象用strong, 相当于MRC中的retain
@property(nonatomic, strong)Dog *dog;

@end
