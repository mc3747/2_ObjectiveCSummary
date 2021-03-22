//
//  StaticAndExternManager.h
//  泛型汇总
//
//  Created by gjfax on 2018/6/6.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StaticAndExternManager : NSObject
/*
 1，外部全局变量：可以被其它文件访问的全局变量，指向同一块存储空间
 2，内部全局变量：只能被当前文件访问的全局变量，
 3，extern关键字用来声明修饰外部全局变量，在使用的地方，调用别的文件的变量
    注意: 声明全局变量和声明函数一样, 仅仅是告诉系统我们有这个全局变量, 但并不会真在的开辟存储空间
 4， static:用于定义一个内部全局变量，会开辟唯一存储空间，值可以被修改
 5，全局变量用static和extern修饰，为了更好的使用和修改权限
 */
+ (void)overallVariableTest;


/*
 1， 当使用static来修饰局部变量, 会延长局部变量的生命周期, 并且会更改局部变量存储的位置 , 将局部变量从栈转移到静态区中，只有程序结束才会释放该存储空间
 2， 当某个方法的调用频率非常高, 而该方法中更有些变量的值是固定不变的
    那么这个时候就可以使用static来修饰该变量, 让该变量只开辟一次存储空间
    这样可以提高程序的效率和性能
 */
+ (void)partVariableTest;


/*
 1，外部函数：可以被其它文件访问的函数，返回值前加extern;
    由于默认就是外部函数, 所以在开发中一般情况extern没人写
 2，内部函数：只能在当前文件中访问的函数，返回值前加static
    在.h中声明一个内部函数没有任何意义

 */
+ (void)functionTest;

@end
