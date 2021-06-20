//
//  Person.h
//  day17
//
//  Created by xiaomage on 15/6/28.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "StudentProtocol.h"

/*
 协议的编写规范:
 1.一般情况下, 当前协议属于谁, 我们就将协议定义到谁的头文件中
 2.协议的名称一般以它属于的那个类的类名开头, 后面跟上protocol或者delegate
 3.协议中的方法名称一般以协议的名称protocol之前的作为开头
 4.一般情况下协议中的方法会将触发该协议的对象传递出去
 
 5.一般情况下一个类中的代理属于的名称叫做 delegate
 
 6.当某一个类要成为另外一个类的代理的时候, 
   一般情况下在.h中用@protocol 协议名称;告诉当前类 这是一个协议.
    在.m中用#import真正的导入一个协议的声明
 */

@class Person;

@protocol PersonProtocol <NSObject>

- (void)personFindHourse:(Person *)person;

@end

@interface Person : NSObject

//@property (nonatomic, strong) id<StudentProtocol> delegete;
@property (nonatomic, strong) id<PersonProtocol> delegate;

- (void)findHourse;
@end
