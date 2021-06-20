//
//  Person+NJ.h
//  day16
//
//  Created by xiaomage on 15/6/26.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import "Person.h"

// 1.分类是用于给原有类添加方法的, 它只能添加方法, 不能添加属性(成员变量)
@interface Person (NJ)
//{
//    double _height;
//}

// 2.分类中的@property, 只会生成setter/getter方法的声明, 不会生成实现以及私有的成员变量
//@property (nonatomic, assign) double height;

- (void) hello;

/*
 方法的调用顺序:
 1.分类
 2.本类
 3.父类
 */
@end
