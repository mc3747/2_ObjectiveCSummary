//
//  IPhoneDeviceInfo.h
//  UIGracefulWriting
//
//  Created by gjfax on 2018/9/28.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IPhoneDeviceInfo : NSObject
//判断是否是iphoneX系列的4种方法
+ (BOOL)isiPhoneXSerial_1;
+ (BOOL)isiPhoneXSerial_2;
+ (BOOL)isiPhoneXSerial_3;
+ (BOOL)isiPhoneXSerial_4;

//根据device model来获取设备信息
+(NSString *) deviceModel;

//系统版本
+ (NSString *)appVersion;

//获取网络状态信息
+ (NSString *)getNetWorkStates;
@end

NS_ASSUME_NONNULL_END
