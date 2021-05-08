//
//  Person+MJ.m
//  day16
//
//  Created by xiaomage on 15/6/26.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import "Person+MJ.h"

@implementation Person (MJ)

// 如果多个分类中都有和原有类中同名的方法, 那么调用该方法的时候执行谁由编译器决定
// 会执行最后一个参与编译的分类中的方法
-(void)say
{
    NSLog(@"%s", __func__);
}
@end
