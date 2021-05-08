//
//  Gun.h
//  day13
//
//  Created by xiaomage on 15/6/19.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gun : NSObject
{
    int _bullet; // 子弹
    // 如果属性比较多, 那么我们就需要给每个属性的设置以及获取都想一个方法名称
    // 正是因为给属性设置和获取取方法名称比较困难, 所以程序员就有了一个规范, 将所有设置值得方法都称之为setter方法, 将所有获取值得方法都称之为getter方法
    // 并且所有的setter方法和getter方法都有对应固定的写法
    int _color; //颜色
    NSString *_model;//型号
    double _weight; // 重量
    
}
/**
 *  射击方法
 */
- (void)shoot;


// 提供一个方法用于设置成员变量的值
- (void)addBullet:(int)count;

// 提供一个方法用于返回成员变量的值
- (int)getBullet;

/*
 setter方法:
 作用: 给成员变量赋值
 格式:
 1. 必须是对象方法
 2. 一定没有返回值
 3. 方法名称一定以set开头, set后面跟上成员变量的名称, 并去掉下划线, 然后将首字母大写
 4. 一定有参数, 并且参数类型和成员变量的类型一致, 参数名称就是成员变量的名称去掉下划线
*/
- (void)setColor:(int)color;

/*
 getter方法:
 作用: 返回成员变量的值
 格式:
 1. 必须是对象方法
 2.一定有返回值, 返回值类型和成员变量的类型一致
 3.方法名称就是成员变量的名称去掉下划线
 4. 一定没有参数
 */
- (int)color;
@end
