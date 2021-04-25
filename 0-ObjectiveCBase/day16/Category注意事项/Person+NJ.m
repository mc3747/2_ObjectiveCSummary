//
//  Person+NJ.m
//  day16
//
//  Created by xiaomage on 15/6/26.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import "Person+NJ.h"

@implementation Person (NJ)

- (void)hello
{
    // 3.可以在分类中访问原有类中.h中的属性
    NSLog(@"hello %f", _weight);
}

// 注意: 如果分类中有和原有类同名的方法, 会调用分类中的方法
// 也就是说会忽略原有类的方法
// 注意: 在开发中尽量不要这样写
-(void)say
{
    NSLog(@"%s", __func__);
}
@end
