//
//  MCDataJudge.m
//  数据非空判断&数据转换
//
//  Created by gjfax on 2018/4/8.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "MCDataJudge.h"
#define FMT_STR(format, ...) [NSString stringWithFormat:format, ##__VA_ARGS__]

@implementation MCDataJudge

#pragma mark -  1,判断对象是否为空
+ (BOOL)judgeObjectNil:(id)object {
    
    //  1.空对象指针nil
    //  2.空类指针Nil
    //  3.空对象[NSNull null]<非nil> - 不会造成容器崩溃
    //  4.空基本数据类型NULL
    if ([object isEqual:[NSNull null]] || nil == object || Nil == object || NULL == object) {
        return YES;
        
    //  5.空类[NSNull class]
    } else if ([object isKindOfClass:[NSNull class]]) {
        return YES;
        
    // 6,空字符串
    }else if ([self isKindOfClass:[NSString class]] && FMT_STR(@"%@", self).length <= 0) {
        return YES;
     
    // 7，服务器返回的特殊空字符
    } else if ([FMT_STR(@"%@", self) isEqualToString:@"(null)"] || [FMT_STR(@"%@", self) isEqualToString:@"<null>"]) {
        return YES;
        
    }else {
        return NO;
    }
}

#pragma mark -  2，判断对象是否为非空字符串
+ (BOOL)judgeStringNil:(id)object {
        //  1,是否为空对象
    if([self judgeObjectNil:object])
    {
        return YES;
        
        //  2,是否为空字符串
    }else if ([object isKindOfClass:[NSString class]] && FMT_STR(@"%@", object).length <= 0) {
        return YES;
        
        //  3,过滤掉空格字符
    }else if ([object isKindOfClass:[NSString class]] && [[object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]<=0)
    {
        return YES;
        
        //  4,服务器返回的特殊空字符
    } else if ([FMT_STR(@"%@", self) isEqualToString:@"(null)"] || [FMT_STR(@"%@", self) isEqualToString:@"<null>"]) {
        
        return YES;
    }
    else {
        return NO;
    }
}

#pragma mark -  3，判断对象是否为非空数组
+ (BOOL)judgeArrayNilWithObject:(id )object{
    /*是否为空对象 */
    if ([self judgeObjectNil:object]) {
        return YES;
        
        /*是否是NSArray */
    } else if(![object isKindOfClass:[NSArray class]]) {
        return YES;
        
        /*NSArray的元素是否大于0个 */
    }else if(([object isKindOfClass:[NSArray class]]) && ((NSArray *)object).count <= 0) {
        return YES;
        
    }else {
        return NO;
    }
              
}

#pragma mark -  4，判断对象是否为非空字典
+(BOOL)judgeDicNilWithObject:(id )object{
    
    /*是否为空对象 */
    if ([self judgeObjectNil:object]) {
        return YES;
        
        /*是否是NSDictionary */
    } else if(![object isKindOfClass:[NSDictionary class]]){
        return YES;
        
        /*NSDictionary的元素是否大于0个 */
    }else if([object isKindOfClass:[NSDictionary class]] && [((NSDictionary *)object) count] <= 0){
        return YES;
        
    }else {
        return NO;
    }
    
}

#pragma mark -  5,判断对象是否为空的NSNumber
+(BOOL)judgeNSNumberNilWithObject:(id )object{
        /*是否为空对象 */
    if ([self judgeObjectNil:object]) {
        return YES;
        
        /*是否是NSNumber */
    } else if(![object isKindOfClass:[NSNumber class]]){
        return YES;
        
        /*NSNumber的元素是否为0 */
    }else if([object isKindOfClass:[NSNumber class]] && [((NSNumber *)object) isEqualToNumber:@0]){
        return YES;
        
    }else {
        return NO;
    }
}

#pragma mark -  6,判断对象是否为空的NSValue
+(BOOL)judgeNSValueNilWithObject:(id )object{
        /*是否为空对象 */
    if ([self judgeObjectNil:object]) {
        return YES;
        
        /*是否是NSValue */
    } else if(![object isKindOfClass:[NSValue class]]){
        return YES;
        
    } else {
         return NO;
    }
}

#pragma mark -  7,判断对象是否为空的NSData
+(BOOL)judgeNSDataNilWithObject:(id )object{
        /*是否为空对象 */
    if ([self judgeObjectNil:object]) {
        return YES;
        
        /*是否是NSValue */
    } else if(![object isKindOfClass:[NSData class]]){
        return YES;
        
    } else {
        return NO;
    }
}
@end
