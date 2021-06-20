//
//  NSDictionary+Category.h
//  ToolAndExtensionSummary
//
//  Created by gjfax on 2018/6/11.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Category)
//data转dic
+ (nullable NSDictionary *)dictionaryWithPlistData:(NSData *)plist;

//string转dic
+ (nullable NSDictionary *)dictionaryWithPlistString:(NSString *)plist;

//dic转data
- (nullable NSData *)plistData;

//dic转string
- (nullable NSString *)plistString;

//所有key组成的数组：按首字母，不分大小写，升序排列
- (NSArray *)allKeysSorted;

//所有value组成的数组：按key首字母，不分大小写升序排列，对应的值
- (NSArray *)allValuesSortedByKeys;

//是否含有某个key
- (BOOL)containsObjectForKey:(id)key;

//返回新的dic
- (NSDictionary *)entriesForKeys:(NSArray *)keys;

//dic转json
- (nullable NSString *)jsonStringEncoded;

//dic转标准json
- (nullable NSString *)jsonPrettyStringEncoded;

//xml转dic
+ (nullable NSDictionary *)dictionaryWithXML:(id)xmlDataOrString;

#pragma mark - Dictionary Value Getter

- (BOOL)boolValueForKey:(NSString *)key default:(BOOL)def;

- (char)charValueForKey:(NSString *)key default:(char)def;
- (unsigned char)unsignedCharValueForKey:(NSString *)key default:(unsigned char)def;

- (short)shortValueForKey:(NSString *)key default:(short)def;
- (unsigned short)unsignedShortValueForKey:(NSString *)key default:(unsigned short)def;

- (int)intValueForKey:(NSString *)key default:(int)def;
- (unsigned int)unsignedIntValueForKey:(NSString *)key default:(unsigned int)def;

- (long)longValueForKey:(NSString *)key default:(long)def;
- (unsigned long)unsignedLongValueForKey:(NSString *)key default:(unsigned long)def;

- (long long)longLongValueForKey:(NSString *)key default:(long long)def;
- (unsigned long long)unsignedLongLongValueForKey:(NSString *)key default:(unsigned long long)def;

- (float)floatValueForKey:(NSString *)key default:(float)def;
- (double)doubleValueForKey:(NSString *)key default:(double)def;

- (NSInteger)integerValueForKey:(NSString *)key default:(NSInteger)def;
- (NSUInteger)unsignedIntegerValueForKey:(NSString *)key default:(NSUInteger)def;

- (nullable NSNumber *)numberValueForKey:(NSString *)key default:(nullable NSNumber *)def;
- (nullable NSString *)stringValueForKey:(NSString *)key default:(nullable NSString *)def;

@end


@interface NSMutableDictionary (Category)
//data转dic
+ (nullable NSMutableDictionary *)dictionaryWithPlistData:(NSData *)plist;

//string转dic
+ (nullable NSMutableDictionary *)dictionaryWithPlistString:(NSString *)plist;

//移除某个key，以及对应的value值
- (nullable id)popObjectForKey:(id)aKey;

//移除某几个key，以及对应的value值
- (NSDictionary *)popEntriesForKeys:(NSArray *)keys;

@end

NS_ASSUME_NONNULL_END
