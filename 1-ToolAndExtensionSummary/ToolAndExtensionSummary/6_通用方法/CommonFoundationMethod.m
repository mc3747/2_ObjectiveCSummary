//
//  CommonFoundationMethod.m
//  ToolAndExtensionSummary
//
//  Created by gjfax on 2019/3/20.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "CommonFoundationMethod.h"
#import <sys/utsname.h>

@implementation CommonFoundationMethod
// 总容量
+ (NSNumber *)totalDiskSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemSize];
}

// 可用容量
+ (NSNumber *)freeDiskSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemFreeSize];
}

#pragma mark - 时间转换
+ (NSString *)stringFromDate:(NSDate *)date formate:(NSString *)formate
{
    NSDateFormatter  *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formate];
    return [dateFormatter stringFromDate:date];
}

+ (NSDate *)dateFromString:(NSString *)dateString formate:(NSString *)formate
{
    NSDateFormatter  *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formate];
    return [dateFormatter dateFromString:dateString];
}

+ (NSString *)formateTime:(NSString *)timeStr
{
    NSString *srcStr = FMT_STR(@"%@", timeStr);
    //  判断是否空字符串
    if (srcStr.length <= 0 || !srcStr) {
        return @"--";
    }
    
    //  剔除字符串中的特殊字符
    NSString *srcStrWithNoSign = srcStr;
    if ([srcStr rangeOfString:@"/" options:NSLiteralSearch].location != NSNotFound) {
        //  如果源数据有'/' 去掉
        srcStrWithNoSign = [srcStr stringByReplacingOccurrencesOfString:@"/" withString:@""];
    } else if ([srcStr rangeOfString:@"-" options:NSLiteralSearch].location != NSNotFound) {
        //  如果源数据有'-' 去掉
        srcStrWithNoSign = [srcStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    //  重新组装时间串
    NSString *retStr = srcStrWithNoSign;
    if (srcStrWithNoSign.length == 8) {
        NSString *year = [srcStrWithNoSign substringWithRange:NSMakeRange(0, 4)];
        NSString *month = [srcStrWithNoSign substringWithRange:NSMakeRange(4, 2)];
        NSString *day = [srcStrWithNoSign substringWithRange:NSMakeRange(6, 2)];
        
        retStr = [year stringByAppendingFormat:@"-%@-%@", month, day];
    } else {
        retStr = srcStr;
    }
    
    return retStr;
}

+ (NSString *)strCurrentTimeFormateYYMM
{
    //  实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //  设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    //  用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    return currentDateStr;
}

+ (NSString *)strTimeIntervalSince1970
{
    long long timeInterval = (long long)[NSDate date].timeIntervalSince1970 * 1000;
    NSString *timestampStr = FMT_STR(@"%lld", timeInterval);
    
    return timestampStr;
}

+ (BOOL)checkoutIsiOS11
{
    if (@available(iOS 11.0, *)) {
        return YES;
    }
    return NO;
}

+ (void)callServicePhone:(NSString *)phone
{
    if (IOS_VERSION < 10.0) {
        //  拨打电话
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:FMT_STR(@"tel://%@",phone)]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:FMT_STR(@"tel://%@",phone)]];
        } else {
//            Show_iToast(@"不支持拨号");
        }
        
    } else {
        
        //  拨打电话
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:FMT_STR(@"tel://%@",phone)]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:FMT_STR(@"tel://%@",phone)]];
        } else {
//            Show_iToast(@"不支持拨号");
        }
    }
}
#pragma mark - appVersion

+ (NSString *)appVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    
    return appVersion;
}
#pragma mark - 手机型号

+ (NSString *)deviceType
{
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G";
    
    if ([platform isEqualToString:@"iPod2,1"]) return @"iPod Touch 2G";
    
    if ([platform isEqualToString:@"iPod3,1"]) return @"iPod Touch 3G";
    
    if ([platform isEqualToString:@"iPod4,1"]) return @"iPod Touch 4G";
    
    if ([platform isEqualToString:@"iPod5,1"]) return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"]) return @"iPad 1G";
    
    if ([platform isEqualToString:@"iPad2,1"]) return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,2"]) return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,3"]) return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,4"]) return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,5"]) return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,6"]) return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,7"]) return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad3,1"]) return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,2"]) return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,3"]) return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,4"]) return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,5"]) return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,6"]) return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad4,1"]) return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,2"]) return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,3"]) return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,4"]) return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,5"]) return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,6"]) return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"i386"]) return @"iPhone Simulator";
    
    if ([platform isEqualToString:@"x86_64"]) return @"iPhone Simulator";
    
    return platform;
    
}

// 缓存大小
+ (CGFloat)cacheFolderSize
{
    CGFloat folderSize = 0;
    
    //获取路径
    NSArray *pathArr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    NSString *cachePath = [pathArr firstObject];
    
    //获取所有文件的数组
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    
    DLog(@"### 文件数：%@",cachePath);
    
    for(NSString *path in files) {
        
        NSString*filePath = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",path]];
        
        //累加
        folderSize += [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil].fileSize;
    }
    //转换为M为单位
    CGFloat sizeM = folderSize /1000.0/1000.0;
    return sizeM;
}

+ (void)removeCache
{
    //===============清除缓存==============
    //获取路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) firstObject];
    
    //返回路径中的文件数组
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    
    
    for(NSString *p in files){
        NSError*error;
        
        NSString*path = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",p]];
        
        if([[NSFileManager defaultManager] fileExistsAtPath:path])
        {
            BOOL isRemove = [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            if(isRemove) {
                //                BLYLogWarn(@"### 清除cache 成功");
                //这里发送一个通知给外界，外界接收通知，可以做一些操作（比如UIAlertViewController）
                
            }else{
                //                BLYLogWarn(@"### 清除cache 清除失败");
            }
        }
    }
}

// JSON字符串转数组
+ (NSArray *)arrayWithJSONString:(NSString *)jsonStr {
    if (jsonStr) {
        id tmp = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:nil];
        if (tmp) {
            if ([tmp isKindOfClass:[NSArray class]]) {
                return tmp;
                
            } else if([tmp isKindOfClass:[NSString class]]
                      || [tmp isKindOfClass:[NSDictionary class]]) {
                return [NSArray arrayWithObject:tmp];
            } else {
                return nil;
            }
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}

// 数组转JSON字符串
+ (NSString *)arrayToJSONString:(NSArray *)array {
    NSData *data = [NSJSONSerialization dataWithJSONObject:array
                                                   options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments
                                                     error:nil];
    
    if (data == nil) {
        return nil;
    }
    
    NSString *string = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
    return string;
}

// JSON字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if(error) {
        NSLog(@"json解析失败：%@",error);
        return nil;
    }
    return dic;
}

// 字典转JSON字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
