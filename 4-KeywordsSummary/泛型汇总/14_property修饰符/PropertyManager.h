//
//  PropertyManager.h
//  泛型汇总
//
//  Created by gjfax on 2018/6/8.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PropertyManager : NSObject
/*
 1，读写属性： （readwrite/readonly）
    readwrite：getter方法和setter方法都生成，默认
    readonly：生成getter方法不生成setter方法
 
 2，getter/setter语意：
    //@property(nonatomic, assign, getter=isVip)BOOL vip;
    getter: 可以给生成的getter方法起一个名词
    setter: 可以给生成的setter方法起一个名词
 
 3，内存管理：（assign/retain/copy）
    assign: 进行赋值（基本类型，c语言类型，id类型）
    weak：引用计数器不变化，也不持有对象，对象消失后，指针自动变成nil（delegate的代理属性，UI控件）。
    strong：引用计数器会+1。
    copy: 建立一个引用计数为1的对象，（NSString，NSArray，NSDictionary，和block，）
 
    retain: MRC中用retain，ARC中用strong。
    unsafe_unretained：和weak类似，但是引用计数为0，变量不会置为nil
 
 4，原子性： （atomicity/nonatomic）
    atomic ：属性赋值的时候加锁（性能低（默认））；
    nonatomic ：属性赋值的时候不加锁（性能高）
 */
@end
