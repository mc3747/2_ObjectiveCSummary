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

/*!
 *  获取在安全模式下给定索引的对象（如果自身是空的则无）
 */
- (nullable id)safeObjectAtIndex:(NSUInteger)index;

/*!
 *  创建反向数组
 */
- (nullable NSArray *)reversedArray;

/*!
 *  转换成JSON的NSString
 */
- (nullable NSString *)arrayToJson;

/*!
 *  模拟阵列当作一个圆。当它超出范围，重新开始
 */
- (nullable id)objectAtCircleIndex:(NSInteger)index;

/*!
 *  将指定的数组创建反向数组
 */
+ (nullable NSArray *)reversedArray:(nullable NSArray *)array;

/*!
 *  将指定的数组转换成JSON的NSString
 */
+ (nullable NSString *)arrayToJson:(nullable NSArray *)array;



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

/**
 *  获取在安全模式下给定索引的对象（如果自身是空的则无）
 */
- (id)safeObjectAtIndex:(NSUInteger)index; // 设定的索引

/**
 *  移动对象从一个索引到另一个索引
 */
- (void)moveObjectFromIndex:(NSUInteger)from // 源索引
                    toIndex:(NSUInteger)to; // 目标索引

/**
 *  创建反向数组
 */
- (NSMutableArray *)reversedArray;

/**
 *  获取给定的键值和排序的数组
 */
+ (NSMutableArray *)sortArrayByKey:(NSString *)key // 键值
                             array:(NSMutableArray *)array // 指定的集合
                         ascending:(BOOL)ascending; // YES为升序，NO为降序
NS_ASSUME_NONNULL_END
@end
