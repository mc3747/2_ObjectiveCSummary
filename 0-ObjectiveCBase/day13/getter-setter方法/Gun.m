//
//  Gun.m
//  day13
//
//  Created by xiaomage on 15/6/19.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//


#import "Gun.h"

@implementation Gun

- (void)shoot
{
    if (_bullet > 0) {
        
        _bullet--;
        NSLog(@"打了一枪 , 还剩%i颗子弹", _bullet);
    }else{
        NSLog(@"没有子弹了");
    }
}

// addBullet就是对成员变量的封装
- (void)addBullet:(int)count // -100
{
    /*
     封装: 屏蔽内部实现的细节, 仅仅对外提供共有的方法/接口
     好处: 保证数据的安全性
           将变化隔离
     规范: 一般情况下不会对外直接暴露成员变量, 都会提供一些共有的方法进行赋值
           成员变量都需要封装起来
     */
    // 对传入的数据进行过滤
    if (count < 0) {
        count = 0;
    }
    _bullet = count;
}

- (int)getBullet
{
    return _bullet;
}

- (void)setColor:(int)color
{
    /*
     成员变量以_开头的好处:
     1.用于区分局部变量/全局变量/形参
     2.方便程序编码, 提高编码效率
     */
    _color = color;
}

- (int)color
{
    return _color;
}
@end
