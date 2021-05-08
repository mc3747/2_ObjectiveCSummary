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
 */
- (void)carameWithFlahlightStatus:(FlahlightStatus)status
{
    if (status == kFlahlightStatusOpen) {
        // 其实self不仅仅可以调用我们的类方法, 还可以调用对象方法
        // self == 对象 == p
        NSLog(@"self = %p", self);
        [self openFlahlight];
    }else
    {
        [self closeFlahlight];
    }
    NSLog(@"拍照");
}

- (void)openFlahlight
{
    NSLog(@"打开闪光灯");
}

- (void)closeFlahlight
{
    NSLog(@"关闭闪光灯");
}

@end
