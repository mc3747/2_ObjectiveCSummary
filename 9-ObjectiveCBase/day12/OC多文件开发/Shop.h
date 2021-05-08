//
//  Shop.h
//  day12
//
//  Created by xiaomage on 15/6/18.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gun.h"

@interface Shop : NSObject

/**
 卖枪方法
 monery: 购买枪的价格
 */
+ (Gun *)buyGun:(int)monery;

/**
 *  卖弹夹
 *
 *  @param monery 钱
 *
 *  @return 弹夹
 */
+ (Clip *)buyClip:(int)monery;
@end
