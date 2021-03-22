//
//  AdaptSystemManager.m
//  WHLatticeDemo
//
//  Created by gjfax on 2019/5/11.
//  Copyright © 2019 remember17. All rights reserved.
//

#import "AdaptSystemManager.h"

@implementation AdaptSystemManager

#pragma mark -  1️⃣，编译时宏检查
//xcode最高支持的版本，
//__IPHONE_OS_VERSION_MIN_REQUIRED：这个宏得到的是当前开发环境的系统SDK版本，当前app支持的最低版本, 即Deployment Target，⚠️在项目配置时设置

//__IPHONE_OS_VERSION_MAX_ALLOWED：这个宏它是当前SDK选择的最低支持的版本，就是该手机上支持的SDK最高版本，⚠️在制作SDK处设置
/*
 
 
 */

#pragma mark -  2️⃣，运行时检查
//1，Xcode 9新方法
/*
 if (@available(iOS 11, *)) {}
 */


//2. UIDevice
/*
 使用于整数大版本
 if ([[ [UIDevice currentDevice] systemVersion] floatValue] >= 11.0) {}
 */


//3，NSOperatingSystemVersion：iOS8以后才出现
/*
 NSOperatingSystemVersion version = [[NSProcessInfo processInfo] operatingSystemVersion];
 NSLog(@"major--->%ld,minjor--->%ld,patch--->%ld",version.majorVersion,version.minorVersion,version.patchVersion);
 NSOperatingSystemVersion v = (NSOperatingSystemVersion){9,0,0}; // 判断操作系统是否大于等于v版本
 BOOL isRight = [[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:v];
 if (isRight) {
 NSLog(@"当前版本大于指定版本");
 } else {
 NSLog(@"当前版本小于指定版本");
 }
 */


//4，字符串比较
/*
// 定义系统宏
#define SYSTEM_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

// 使用
if (SYSTEM_VERSION_LESS_THAN(@"4.0")) {
    ...
}
if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"3.1.1")) { ...}
 
 */

//5，获取系统方法比较
+ (NSString *)appVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    
    return appVersion;
}
@end
