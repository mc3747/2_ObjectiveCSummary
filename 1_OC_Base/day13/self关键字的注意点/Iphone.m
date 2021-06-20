//
//  Iphone.m
//  day13
//
//  Created by xiaomage on 15/6/19.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//


#import "Iphone.h"

@implementation Iphone

/*
 如果self在对象方法中, 那么self就代表调用当前对象方法的那个对象
 如果self在类方法中, 那么self就代表调用当前类方法的那个类
 总结: 
 我们只用关注self在哪一个方法中 , 如果在类方法那么就代表当前类, 如果在对象方法那么就代表"当前调用该方法的对象"
 
 
 注意:
 >self会自动区分类方法和对象方法, 如果在类方法中使用self调用对象方法, 那么会直接报错
 >不能在对象方法或者类方法中利用self调用当前self所在的方法
 
 使用场景:
 可以用于在对象方法之间进行相互调用
 可以用于在类方法之间进行相互调用
 
 可以用于区分成员变量和局部变量同名的情况
 */
+ (void)carameWithFlahlightStatus:(FlahlightStatus)status
{
    if (status == kFlahlightStatusOpen) {
//         NSLog(@"self = %p", self);
        [self openFlahlight]; // p
    }else
    {
        [self closeFlahlight];
    }
    NSLog(@"拍照");
}

+ (void)openFlahlight
{
    NSLog(@"打开闪光灯");
//    NSLog(@"self = %p", self);
    // 死循环
    [self openFlahlight]; // p
}

+ (void)closeFlahlight
{
    NSLog(@"关闭闪光灯");
}

- (void)setCpu:(int)cpu
{
    self->cpu = cpu;
}

@end
