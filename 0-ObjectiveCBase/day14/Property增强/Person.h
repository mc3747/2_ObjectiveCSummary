//
//  Person.h
//  day14
//
//  Created by xiaomage on 15/6/23.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
/*
{
    @public
    int _age;
    int age;
}
 */

/*
 从Xcode4.4以后apple对@property进行了一个增强, 以后只要利用一个@property就可以同时生产setter/getter方法的声明和实现
 没有告诉@property要将传入的参数赋值给谁, 默认@property会将传入的属性赋值给_开头的成员变量
 
 @property有一个弊端: 它只会生成最简单的getter/setter方法的声明和实现, 并不会对传入的数据进行过滤
 如果想对传入的数据进行过滤, 那么我们就必须重写getter/setter方法
 如果不想对传入的数据进行过滤, 仅仅是提供一个方法给外界操作成员变量, 那么就可以使用@property
 
 如果利用@property来生成getter/setter方法, 那么我们可以不写成员变量, 系统会自动给我们生成一个_开头的成员变量
 注意: @property自动帮我们生成的成员变量是一个私有的成员变量, 也就是说是在.m文件中生成的, 而不是在.h文件中生成的
 */
// age? _age;
/*
 - (void)setAge:(int)age;
 - (int)age;
 */
@property int age;

@end
