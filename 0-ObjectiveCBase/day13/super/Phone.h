//
//  Phone.h
//  day13
//
//  Created by xiaomage on 15/6/19.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum
{
    kFlahlightStatusOpen,
    kFlahlightStatusClose
} FlahlightStatus;

// 被继承的这个类我们称之为父类/ 超类
@interface Phone : NSObject

/**
 *  根据闪光灯的状态拍照
 *
 *  @param status 闪光灯的状态, 开/关
 */
 
/**
 *  打开闪光灯
 */
+ (void)openFlahlight;
/**
 * 关闭闪光灯
 */
+ (void)closeFlahlight;

@end
