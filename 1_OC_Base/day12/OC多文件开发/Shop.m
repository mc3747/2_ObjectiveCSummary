//
//  Shop.m
//  day12
//
//  Created by xiaomage on 15/6/18.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import "Shop.h"

@implementation Shop

+ (Gun *)buyGun:(int)monery
{
    // 1.创建一把枪
    Gun *gun = [Gun new]; // 通过new创建出来的对象存储在堆中, 堆中的数据不会自动释放
    // 2.返回一把枪
    return gun;
}
+ (Clip *)buyClip:(int)monery
{
    Clip *clip = [Clip new];
    [clip addBullet];
    return clip;
}
@end
