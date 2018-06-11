//
//  NSArray+Category.h
//  ToolAndExtensionSummary
//
//  Created by gjfax on 2018/6/11.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (Category)

//data转array
+ (nullable NSArray *)arrayWithPlistData:(NSData *)plist;

//string转array
+ (nullable NSArray *)arrayWithPlistString:(NSString *)plist;

//array转data
- (nullable NSData *)plistData;

//array转string
- (nullable NSString *)plistString;

//获取随机元素（没有，返回nil）
- (nullable id)randomObject;

//获取制定下标的元素（没有，返回nil）
- (nullable id)objectOrNilAtIndex:(NSUInteger)index;

//array转json
- (nullable NSString *)jsonStringEncoded;

//array转标准json
- (nullable NSString *)jsonPrettyStringEncoded;

@end



@interface NSMutableArray (Category)
//data转array
+ (nullable NSMutableArray *)arrayWithPlistData:(NSData *)plist;

//string转array
+ (nullable NSMutableArray *)arrayWithPlistString:(NSString *)plist;

//移除第一个元素（没有，此方法无效）
- (void)removeFirstObject;

//移除最后一个元素（没有，此方法无效）
- (void)removeLastObject;

//移除第一个元素（没有，返回nil）
- (nullable id)popFirstObject;

//移除最后一个元素（没有，返回nil）
- (nullable id)popLastObject;

//尾部添加一个元素
- (void)appendObject:(id)anObject;

//首部添加一个元素
- (void)prependObject:(id)anObject;

//尾部添加一个数组
- (void)appendObjects:(NSArray *)objects;

//首部添加一个数组
- (void)prependObjects:(NSArray *)objects;

//指定位置插入元素
- (void)insertObjects:(NSArray *)objects atIndex:(NSUInteger)index;

//数组顺序反转
- (void)reverse;

//数组顺序打乱
- (void)shuffle;


NS_ASSUME_NONNULL_END
@end
