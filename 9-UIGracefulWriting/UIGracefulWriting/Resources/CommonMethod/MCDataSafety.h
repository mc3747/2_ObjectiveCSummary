//
//  MCDataSafety.h
//  数据非空判断&数据转换
//
//  Created by gjfax on 2018/4/8.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCDataSafety : NSObject

 /*1，字典：返回安全对象 */
+ (id)returnSafeObject:(NSDictionary *)dic key:(id)aKey;

 /*2，字典：返回安全数组 */
+ (id)returnSafeArray:(NSDictionary *)dic  key:(id)aKey;

 /*3，字典：返回安全字典 */
+ (id)returnSafeDic:(NSDictionary *)dic  key:(id)aKey;

 /*4，返回字符串：普通网络数据安全值 */
+ (NSString *)returnNoDataString:(NSString *)noDataString withString:(NSString *)string;

 /*5，返回字符串：带千分位的网络数据安全值 */
+ (NSString *)returnNoDataThousandString:(NSString *)noDataThousandString withString:(NSString *)string;

 /*6，返回字符串：拼接的网络数据安全值 */
+ (NSString *)returnJointString:(NSString *)jointString NoDataJointString:(NSString *)noDataJointString withString:(NSString *)string;
@end
