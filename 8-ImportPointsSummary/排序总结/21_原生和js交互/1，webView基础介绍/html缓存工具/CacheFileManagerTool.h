//
//  CacheFileManagerTool.h
//  jiyouwang
//
//  Created by Apple on 17/4/11.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheFileManagerTool : NSObject

/**
 * 网页缓存写入文件
 * fileName  文件名
 */
+ (void)writeToCache:(NSString *)fileName;

/**
 * 获取网页缓存文件
 * fileName  文件名
 */
+ (NSString *)readFromCache:(NSString *)fileName;

/**
 * 获取缓存文件大小
 */
+ (CGFloat)getCacheSize;

/**
 * 清除文件缓存
 */
+ (void)cleanCacheSuccess:(void (^)())success failure:(void (^)())failure;

@end
