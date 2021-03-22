//
//  MCDataSafety.m
//  数据非空判断&数据转换
//
//  Created by gjfax on 2018/4/8.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "MCDataSafety.h"
#import "MCDataJudge.h"
#define FMT_STR(format, ...) [NSString stringWithFormat:format, ##__VA_ARGS__]

@implementation MCDataSafety

/*1，字典：返回安全对象 */
+ (id)returnSafeObject:(NSDictionary *)dic key:(id)aKey{
    
    if ([MCDataJudge judgeDicNilWithObject:dic]) {
        return @"";
    }else  if ([self isKeyOrValueNil:aKey dic:dic]) {
        return @"";
    } else {
       return  [dic objectForKey:aKey];
    };
}

/*2，字典：返回安全数组 */
+ (id)returnSafeArray:(NSDictionary *)dic key:(id)aKey{
    if ([MCDataJudge judgeDicNilWithObject:dic]) {
        return [NSArray array];
    }else  if ([self isKeyOrValueNil:aKey dic:dic]) {
        return [NSArray array];
    } else {
        return  [dic objectForKey:aKey];
    };
}

/*3，字典：返回安全字典 */
+ (id)returnSafeDic:(NSDictionary *)dic key:(id)aKey{
    if ([MCDataJudge judgeDicNilWithObject:dic]) {
        return [NSDictionary dictionary];
    }else  if ([self isKeyOrValueNil:aKey dic:dic]) {
        return [NSDictionary dictionary];
    } else {
        return  [dic objectForKey:aKey];
    };
}
/*4，返回字符串：普通网络数据安全值 */
+ (NSString *)returnNoDataString:(NSString *)noDataString withString:(NSString *)string {
    if (string && ![MCDataJudge judgeObjectNil:string] && [string respondsToSelector:@selector(isNullStr:)]) {
        return string;
    } else {
        return noDataString;
    };
}

/*5，返回字符串：带千分位的网络数据安全值 */
+ (NSString *)returnNoDataThousandString:(NSString *)noDataThousandString withString:(NSString *)string {
    if (string && ![MCDataJudge judgeObjectNil:string] && [string respondsToSelector:@selector(isNullStr:)]) {
        return ([self formatStrTo10_4WithNoDecimal:string]);
    } else {
        return noDataThousandString;
    };
}

/*6，返回字符串：拼接的网络数据安全值 */
+ (NSString *)returnJointString:(NSString *)jointString NoDataJointString:(NSString *)noDataJointString withString:(NSString *)string {
    
    if (string && ![MCDataJudge judgeObjectNil:string] && [string respondsToSelector:@selector(isNullStr:)]) {
        return jointString;
    } else {
        return noDataJointString;
    }
}

#pragma mark -  判断key 或 value 是否为nil
+ (BOOL)isKeyOrValueNil:(id)aKey dic:(NSDictionary *)dic
{
    
    if (![[dic allKeys] containsObject:aKey]) {
        //检测是否包含key
        return YES;
    }else if (![dic objectForKey:aKey]) {
        //  判断key是否为空
        return YES;
    } else {
        //  得到key对应object
        id obj = [dic objectForKey:aKey];
        return [MCDataJudge judgeDicNilWithObject:obj];
    };
    
}

#pragma mark -  千分位
+ (NSString *)formatStrTo10_4WithNoDecimal:(NSString *)string
{
    if ([MCDataJudge judgeObjectNil:string]) {
        return @"--";
    }
    NSString *retStr = [self formatStrWithFormat:self positiveFormat:@"###,##0.00;"];
    return retStr;
}

+ (NSString *)formatStrWithFormat:(id)str positiveFormat:(NSString *)positiveFormat
{
    //  id类型转换成str
    NSString *srcStr = FMT_STR(@"%@", str);
    NSString *srcStrNoSign = srcStr;
    
    if (![MCDataJudge judgeObjectNil:srcStr] && [srcStr respondsToSelector:@selector(isNullStr:)]) {
        
        //  在str判断是否有‘,’
        if ([srcStr rangeOfString:@"," options:NSLiteralSearch].location != NSNotFound) {
            //  如果源数据有千分位或者逗号 去掉千分位
            srcStrNoSign = [srcStr stringByReplacingOccurrencesOfString:@"," withString:@""];
        }
        
        //  format
        NSNumberFormatter* numFmt = [[NSNumberFormatter alloc] init];
        [numFmt setFormatterBehavior: NSNumberFormatterBehavior10_4];
        [numFmt setNumberStyle:NSNumberFormatterCurrencyStyle];
        [numFmt setPositiveFormat:positiveFormat];
        NSString *retStr = [numFmt stringFromNumber:[NSNumber numberWithDouble: [(NSString*)srcStrNoSign doubleValue]]];
        
        return retStr;
    }
    
    return @"--";
}

#pragma mark -  响应该方法
+ (BOOL)isNullStr:(NSString *)string
{
    if ([MCDataJudge judgeObjectNil:string]) {
        return YES;
    } else {
        return NO;
    };
}
@end
