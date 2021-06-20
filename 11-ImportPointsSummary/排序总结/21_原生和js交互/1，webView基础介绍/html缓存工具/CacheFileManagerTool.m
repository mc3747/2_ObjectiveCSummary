//
//  CacheFileManagerTool.m
//  jiyouwang
//
//  Created by Apple on 17/4/11.
//  Copyright © 2017年 silence. All rights reserved.
//  缓存文件管理工具类

#import "CacheFileManagerTool.h"

@implementation CacheFileManagerTool


/**
 * 网页缓存写入文件
 */
+ (void)writeToCache:(NSString *)fileName
{
    NSString *htmlResponseStr = [NSString stringWithContentsOfURL:[NSURL URLWithString:fileName] encoding:NSUTF8StringEncoding error:nil];
    
    //创建文件管理器
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    
    //获取document路径
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,      NSUserDomainMask, YES) objectAtIndex:0];
    
    [fileManager createDirectoryAtPath:[cachesPath stringByAppendingString:@"/Caches"]withIntermediateDirectories:YES attributes:nil error:nil];
    
    //写入路径
    NSString *path = [cachesPath stringByAppendingString:[NSString stringWithFormat:@"/Caches/%lu",(unsigned long)[fileName hash]]];
    
    [htmlResponseStr writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

/**
 * 获取网页缓存文件
 * fileName  文件名
 */
+ (NSString *)readFromCache:(NSString *)fileName{
    
    // 判断是否从缓存中获取
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    
    NSString *path = [cachesPath stringByAppendingString:[NSString stringWithFormat:@"/Caches/%lu",(unsigned long)[fileName hash]]];
    
    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    return htmlString;
}


/**
 * 获取缓存文件大小
 */
+ (CGFloat)getCacheSize{
    
    //获取文件管理器对象
    NSFileManager * fileManger = [NSFileManager defaultManager];
    
    //获取缓存沙盒路径
    NSString * cachePath =  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    //拼接缓存文件文件夹路径
    NSString * fileCachePath = [cachePath stringByAppendingPathComponent:@"/Caches"];
    
    //获取到该缓存目录下的所有子文件（只是文件名并不是路径，后面要拼接）
    NSArray * subFilePath = [fileManger subpathsAtPath:fileCachePath];
    
    //先定义一个缓存目录总大小的变量
    NSInteger fileTotalSize = 0;
    
    for (NSString * fileName in subFilePath)
    {
        //拼接文件全路径（注意：是文件）
        NSString * filePath = [fileCachePath stringByAppendingPathComponent:fileName];
        
        //获取文件属性
        NSDictionary * fileAttributes = [fileManger attributesOfItemAtPath:filePath error:nil];
        
        //根据文件属性判断是否是文件夹（如果是文件夹就跳过文件夹，不将文件夹大小累加到文件总大小）
        if ([fileAttributes[NSFileType] isEqualToString:NSFileTypeDirectory]) continue;
        
        //获取单个文件大小,并累加到总大小
        fileTotalSize += [fileAttributes[NSFileSize] integerValue];
    }
    
    //将字节大小转为MB，然后传出去
    return fileTotalSize/1024.0/1024.0;
}

/**
 * 清除文件缓存
 */
+ (void)cleanCacheSuccess:(void (^)())success failure:(void (^)())failure{
    
    //获取文件管理器对象
    NSFileManager * fileManger = [NSFileManager defaultManager];
    
    //获取缓存沙盒路径
    NSString * cachePath =  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    //拼接缓存文件文件夹路径
    NSString * fileCachePath = [cachePath stringByAppendingPathComponent:@"/Caches"];

    //获取到该缓存目录下的所有子文件（只是文件名并不是路径，后面要拼接）
    NSArray * subFilePath = [fileManger subpathsAtPath:fileCachePath];
    
    NSError *error = nil;
    for (NSString *p in subFilePath) {
        
        NSString *path = [fileCachePath stringByAppendingPathComponent:p];
        
        if ([fileManger fileExistsAtPath:path]) {
            
            [fileManger removeItemAtPath:path error:&error];
            
            if (error) {
                break;
            }
        }
    }
    
    if (error) {
        
        if (failure) failure();
        
    }else{
        
        if (success) success();
    }
}

@end
