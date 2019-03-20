//
//  CommonFoundationMethod.h
//  ToolAndExtensionSummary
//
//  Created by gjfax on 2019/3/20.
//  Copyright © 2019 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonFoundationMethod : NSObject

#pragma mark - 手机容量
// 总容量
+ (NSNumber *)totalDiskSpace;

// 可用容量
+ (NSNumber *)freeDiskSpace;

#pragma mark - 时间转换
// date 格式化为 string:  yyyy-MM-dd HH:mm:ss
+ (NSString *)stringFromDate:(NSDate *)date formate:(NSString *)formate;

// 日期转换，string 格式化为 date,eg:  yyyy-MM-dd HH:mm:ss
+ (NSDate *)dateFromString:(NSString *)dateString formate:(NSString *)formate;

// 字符串转换成时间，yyyy-MM-dd
+ (NSString *)formateTime:(NSString *)timeStr;

// 返回yyyy-MM-dd HH:mm:ss的当前时间
+ (NSString *)strCurrentTimeFormateYYMM;

// 时间戳 longlong --> NSString类型
+ (NSString *)strTimeIntervalSince1970;

#pragma mark - UUID:从keychain中获取UUID，若无则生成UUID并获取
+ (NSString*)UUIDWithKeyChain;

#pragma mark - appVersion:获取项目版本号
+ (NSString *)appVersion;

#pragma mark - 手机型号
+ (NSString *)deviceType;

//ios11 检测
+ (BOOL)checkoutIsiOS11;

//拨打电话
+ (void)callServicePhone:(NSString *)phone;

//获取缓存大小
+ (CGFloat)cacheFolderSize;

//清楚cache
+ (void)removeCache;



//json转数组
+ (NSArray *)arrayWithJSONString:(NSString *)jsonStr;
// 数组转JSON字符串
+ (NSString *)arrayToJSONString:(NSArray *)array;
//json转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
//字典转json
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
