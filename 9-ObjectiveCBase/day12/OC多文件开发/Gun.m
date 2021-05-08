//
//  Gun.m
//  day12
//
//  Created by xiaomage on 15/6/18.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import "Gun.h"

@implementation Gun

/**
 *  射击
 *
 *  @param c 弹夹
 */
- (void)shoot:(Clip *)c
{
    // 判断有没有弹夹
    if (c != nil) { // nil == null == 没有值
        // 判断有没有子弹
        if (c->_bullet > 0) {
            c->_bullet -= 1;
            NSLog(@"打了一枪 %i", c->_bullet);
        }else
        {
            NSLog(@"没有子弹了");
        }
    }else
    {
        NSLog(@"没有弹夹, 请换弹夹");
    }
}
@end
