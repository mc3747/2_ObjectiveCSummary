//
//  VariabelManager.h
//  泛型汇总
//
//  Created by gjfax on 2018/6/6.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VariabelManager : NSObject
/*
 1，局部变量
 1，书写位置：函数或者代码块中
 2，作用域：定义到大括号
 3，存储位置：栈区
 4，释放：系统会自动释放
 
 2，全局变量
 1，书写位置：函数和代码块外
 2，作用域：定义到文件结束
 3，存储位置：静态区
 4，释放：程序一启动就会分配存储空间, 直到程序结束才会释放
 
 3，实例变量
 1，书写位置：类声明的大括号中的变量
 2，作用域：通过对象来访问
 3，存储位置：堆区(当前对象对应的堆的存储空间中)
 4，释放：存储在堆中的数据, 不会被自动释放, 只能程序员手动释放（对象结束即消亡，ARC，）
 */
@end
