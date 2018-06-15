//
//  NSString+Category.h
//  ToolAndExtensionSummary
//
//  Created by gjfax on 2018/6/11.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Category)

#pragma mark - Hash：返回Hash值

//md2
- (nullable NSString *)md2String;

//md4
- (nullable NSString *)md4String;

//md5
- (nullable NSString *)md5String;

//sha1
- (nullable NSString *)sha1String;

//sha224
- (nullable NSString *)sha224String;

//sha256
- (nullable NSString *)sha256String;

//sha384
- (nullable NSString *)sha384String;

//sha512
- (nullable NSString *)sha512String;

//md5 + key
- (nullable NSString *)hmacMD5StringWithKey:(NSString *)key;

//sha1 + key
- (nullable NSString *)hmacSHA1StringWithKey:(NSString *)key;

//sha224 + key
- (nullable NSString *)hmacSHA224StringWithKey:(NSString *)key;

//sha256 + key
- (nullable NSString *)hmacSHA256StringWithKey:(NSString *)key;

//sha384 + key
- (nullable NSString *)hmacSHA384StringWithKey:(NSString *)key;

//sha512 + key
- (nullable NSString *)hmacSHA512StringWithKey:(NSString *)key;

//crc32
- (nullable NSString *)crc32String;


#pragma mark - Encode and decode：加密和解密
//base64编码对象方法
- (nullable NSString *)base64EncodedString;

//base64编码类方法
+ (nullable NSString *)stringWithBase64EncodedString:(NSString *)base64EncodedString;

//url的utf-8格式的加密
- (NSString *)stringByURLEncode;

//url的utf-8格式的解密
- (NSString *)stringByURLDecode;

//html的转义字符序列
- (NSString *)stringByEscapingHTML;

#pragma mark - Drawing ：尺寸相关
// 返回字符串的宽度和高度（字体 + 最大尺寸 +换行模式）
- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

// 单行字符串的宽度
- (CGFloat)widthForFont:(UIFont *)font;

// 字符串高度（字体 + 最大宽度）
- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width;


#pragma mark - Regular Expression ：正则匹配
//是否符合特定的正则
- (BOOL)matchesRegex:(NSString *)regex options:(NSRegularExpressionOptions)options;

//找出字符串中，符合特定正则的字符串
- (void)enumerateRegexMatches:(NSString *)regex
options:(NSRegularExpressionOptions)options
usingBlock:(void (^)(NSString *match, NSRange matchRange, BOOL *stop))block;

//当字符串符合特定正则时，返回制定的字符串
- (NSString *)stringByReplacingRegex:(NSString *)regex
options:(NSRegularExpressionOptions)options
withString:(NSString *)replacement;


#pragma mark - NSNumber Compatible：和NSNumber兼容

@property (readonly) char charValue;
@property (readonly) unsigned char unsignedCharValue;
@property (readonly) short shortValue;
@property (readonly) unsigned short unsignedShortValue;
@property (readonly) unsigned int unsignedIntValue;
@property (readonly) long longValue;
@property (readonly) unsigned long unsignedLongValue;
@property (readonly) unsigned long long unsignedLongLongValue;
@property (readonly) NSUInteger unsignedIntegerValue;


#pragma mark - Utilities：实用工具
//UUID格式：D1178E50-2A4D-4F1F-9BD3-F6AAB00E06B1
+ (NSString *)stringWithUUID;

//字符串转成utf32字符串
+ (NSString *)stringWithUTF32Char:(UTF32Char)char32;

//字符数组转成utf32字符串
+ (NSString *)stringWithUTF32Chars:(const UTF32Char *)char32 length:(NSUInteger)length;

//遍历字符串的指定位置是否是utf32字符串
- (void)enumerateUTF32CharInRange:(NSRange)range usingBlock:(void (^)(UTF32Char char32, NSRange range, BOOL *stop))block;

//去掉头部和尾部的空格和回车
- (NSString *)stringByTrim;

//图片资源名称修正：name变成name@2x
- (NSString *)stringByAppendingNameScale:(CGFloat)scale;

//图片资源路径修正：icon.png变成icon@2x.png
- (NSString *)stringByAppendingPathScale:(CGFloat)scale;

//放大倍数：icon@2x.png返回2
- (CGFloat)pathScale;

//是否为空
- (BOOL)isNotBlank;

//是否含有字符串
- (BOOL)containsString:(NSString *)string;

//是否含有字符集
- (BOOL)containsCharacterSet:(NSCharacterSet *)set;

//NSNumber
- (NSNumber *)numberValue;

//NSDate
- (NSData *)dataValue;

//范围
- (NSRange)rangeOfAll;

//json序列化：NSString: @"{"name":"a","count":2}"  => NSDictionary: @[@"name":@"a",@"count":@2]
- (id)jsonValueDecoded;

//bundle中文件的string：similar to [UIImage imageNamed:]
+ (NSString *)stringNamed:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
