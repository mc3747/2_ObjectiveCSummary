//
//  Soldier.m
//  day12
//
//  Created by xiaomage on 15/6/18.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import "Soldier.h"

@implementation Soldier

- (void)fire:(Gun *)gun clip:(Clip *)clip
{
    // 判断是否有枪和子弹
    if (gun !=nil &&
        clip != nil) {
        
        [gun shoot:clip];
    }
}

@end
