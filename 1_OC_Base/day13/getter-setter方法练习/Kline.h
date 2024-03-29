//
//  Kline.h
//  day13
//
//  Created by xiaomage on 15/6/19.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Kline : NSObject
{
    int _min;// 最小值
    int _max; // 最大值
    int _average;// 平均值
}
/*
 setter方法
 1. 一定是对象方法
 2. 一定没有返回值
 3. 方法名称一定以set开头, 后面跟上成员变量的名称并且去掉下划线, 然后首字母大写
 4.一定有参数, 参数类型一定和成员变量一样, 参数名称就是成员变量的名称去掉下划线
 */
- (void)setMin:(int)min;
- (void)setMax:(int)max;

/*
 一个属性可以只有getter方法, 没有setter方法, 这种属性我们称之为只读属性
 一个属性也可以只有setter方法, 没有getter方法, 这种属性我们称之为只写属性
 如果既有setter方法又有getter方法, 那么这种属性我们称之为可读可写的属性
 并且, 一个属性也可以没有getter和setter, 这种属性我们称之为私有属性
 */
//- (void)setAverage:(int)average;
/*
 getter方法
 1. 一定是对象方法
 2. 一定有返回值, 返回值类型和成员变量的类型一致
 3. 方法名称就是成员变量的名称去掉下划线
 4. 一定没有参数
 */
- (int)min;
- (int)max;
- (int)average;

@end
