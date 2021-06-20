//
//  ConstManager.h
//  泛型汇总
//
//  Created by gjfax on 2018/6/6.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConstManager : NSObject
/*
 1，const修饰指针：3种情形
    int num = 10;
    int *p = &num;
    1，const int *p = &num;（值不能变，所指变量指向可以变，内存空间可以变）
       如果const写在指针类型的左边, 那么意味着指向的内存空间中的值不能改变, 但是指针的指向可以改变
    2，int const *p = &num;（值能变，所指变量指向不可以变，内存空间可以变）
       如果const写在指针的数据类型和*号之间, 那么意味着指向的内存空间中的值不能改变, 但是指针的指向可以改变
    3, int* const p = &num;（值能变，所指变量指向可以变，内存空间不可以变）
       如果const写在指针的右边(数据类型 * const), 那么意味着指针的指向不可以改变, 但是指针指向的存储空间中的值可以改变
 
 2，const修饰变量
    1，const对基本数据类型的作用, 可以让基本数据类型的变量变为常量
    2，放在类型的左右都可以
        int const num = 10;
        const int num = 10;
    3，常用的应用场合：多次使用的内部全局常量（优于宏的使用：1，开辟的存储空间；2，不可修改性；3，更新维护方便）
        static int const num = 10;
        static NSString * const BASE_URL  =  @"“;
 */
@end
