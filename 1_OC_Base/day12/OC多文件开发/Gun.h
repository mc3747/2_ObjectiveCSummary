//
//  Gun.h
//  day12
//
//  Created by xiaomage on 15/6/18.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gun.h"
#import "Clip.h"
// 多文件开发中, 要使用谁就导入谁的.h文件就可以了
// 注意: 导入的一定是.h文件, 不能是.m文件
// 如果导入.m文件会报重复定义错误

@interface Gun : NSObject
{
    Clip *clip; // 弹夹
}

/**
 *  射击
 *
 *  @param c 弹夹
 */
- (void)shoot:(Clip *)c;
@end
