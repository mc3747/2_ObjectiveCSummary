//
//  main.m
//  day11
//
//  Created by xiaomage on 15/6/16.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#include <stdio.h>

// Foundation.h我们称之为主头文件, 主头文件中又拷贝了该工具箱中所有工具的头文件, 我们只需要导入主头文件就可以使用该工具箱中所有的工具, 避免了每次使用都要导入一个对应的头文件
// 工具箱的地址: /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/System/Library/Frameworks
// 规律: 所有的主头文件的名称都和工具箱的名称一致
//      所有的主头文件都是导入了该工具箱中所有工具的头文件

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>


/*
 import 的功能和 include一样, 是将右边的文件拷贝到当前import的位置
 为了降低程序员的负担, 防止重复导入, 避免程序员去书写 头文件卫士, 那么OC给出来一个新的预处理指令import
 import优点: 会自动防止重复拷贝
 */

/*
 因为OC完全兼容C, 所以可以在OC程序中编写C语言代码
 并且可以将C语言的源文件和OC的源文件组合在一起生成可执行文件
 */
#import "zs.h"

int main(int argc, const char * argv[]) {
    // 1.OC是兼容C的
    printf("c hello world\n");
    printf("c hello world\n");
    /*
     printf和NSLog的区别:
     NSLog会自动换行
     NSLog在输出内容时会附加一些系统信息
     NSLog和printf接收的参数不一样
     */
    NSLog(@"OC hello World");
    NSLog(@"OC hello World");
    
    NSLog(@"sum = %i", sum(20, 10));
    return 0;
}
