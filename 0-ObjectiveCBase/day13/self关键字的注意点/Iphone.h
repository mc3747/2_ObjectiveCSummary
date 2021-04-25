//
//  Iphone.h
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

@interface Iphone : NSObject
{
    int  cpu;
}

- (void)setCpu:(int)cpu;

/**
 *  根据闪光灯的状态拍照
 *
 *  @param status 闪光灯的状态, 开/关
 */
+ (void)carameWithFlahlightStatus:(FlahlightStatus)status;
/**
 *  打开闪光灯
 */
+ (void)openFlahlight;
/**
 * 关闭闪光灯
 */
+ (void)closeFlahlight;
@end
