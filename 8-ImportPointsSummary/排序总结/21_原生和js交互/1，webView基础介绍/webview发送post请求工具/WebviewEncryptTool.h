//
//  WebviewEncryptTool.h
//  排序总结
//
//  Created by gjfax on 2019/3/22.
//  Copyright © 2019 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebviewEncryptTool : NSObject

#pragma mark - 当前时间戳
+ (NSString *)getCurrentTimeStr;

#pragma mark - 字典转json
+(NSString *)convertToJsonData:(NSDictionary *)dict;

#pragma mark - 成功sha1RSA加密
+(NSString *)signSHA1WithRSA:(NSString *)plainText;
@end

NS_ASSUME_NONNULL_END
