//
//  DefineAndTypedefManager.h
//  泛型汇总
//
//  Created by gjfax on 2018/6/6.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DefineAndTypedefManager : NSObject
/*
 *----------------------666666---------------------- *
 1，预处理：宏定义/条件编译/文件包含，都以#开头
    源代码 --> 预处理 -->汇编 -->二进制 -->可执行程序
 
 
*----------------------666666---------------------- *
 2，宏定义：
    1，直接替换（注意是直接替换，整体替换一定要带括弧）
    2，带参数和不带参数
    3，默认作用范围，为文件结束，也可以提前结束，使用#undef
        #define COUNT 6
        #undef COUNT
 
*----------------------666666---------------------- *
 3，条件编译：
     1，DEBUG全局宏，在项目设置里，用来控制调试和发布阶段；
     2，条件编译和宏定义配合使用，不能和其他不在同一生命周期的变量等使用
     3，常用写法：
 
         1，常规写法
         #if DEBUG == 0
         // 调试阶段
         #else
         // 发布阶段
         #endif
 
         2，是否定义了宏：#ifdef SCORE ；
         3，是否没有定义宏：#ifndef SCORE；
         4，是否定义了宏：#if defined(SCORE)；
         5，是否没有定义宏：#if !defined(SCORE)
 
*----------------------666666---------------------- *
  4，文件包含
    1，import比incule，防止重复拷贝，循环拷贝
    2，<>:会先去编译器环境下查找, 找不到再去系统的环境下查找
    3，“”：会先在当前文件目录查找, 找不到再去编译器环境下查找, 找不到再去系统的环境下查找
 
 
*----------------------666666---------------------- *
  5，typedef：起别名
 经常用的场合：1，枚举
     typedef NS_ENUM(NSInteger, UserState) {
     UserState0 = 0,
     UserState1,
     UserState2,
     };
        2，block
    typedef void(^UIButtonClickHandle)(UIButton *view);
        3，强弱引用
    #define GJWeakSelf  __weak typeof(self) weakSelf = self;
    #define GJStrongSelf __strong typeof(weakSelf) strongSelf = weakSelf;
 */
@end
