//
//  NSData+Category.h
//  ToolAndExtensionSummary
//
//  Created by gjfax on 2018/6/11.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSData (Category)


#pragma mark - Hash
//md2
- (NSString *)md2String;
- (NSData *)md2Data;

//md4
- (NSString *)md4String;
- (NSData *)md4Data;

//md5
- (NSString *)md5String;
- (NSData *)md5Data;

//sha1
- (NSString *)sha1String;
- (NSData *)sha1Data;

//sha224
- (NSString *)sha224String;
- (NSData *)sha224Data;

//sha256
- (NSString *)sha256String;
- (NSData *)sha256Data;

//sha384
- (NSString *)sha384String;
- (NSData *)sha384Data;

//sh512
- (NSString *)sha512String;
- (NSData *)sha512Data;

//md5 + key
- (NSString *)hmacMD5StringWithKey:(NSString *)key;
- (NSData *)hmacMD5DataWithKey:(NSData *)key;

//sha1 + key
- (NSString *)hmacSHA1StringWithKey:(NSString *)key;
- (NSData *)hmacSHA1DataWithKey:(NSData *)key;

//sha224 + key
- (NSString *)hmacSHA224StringWithKey:(NSString *)key;
- (NSData *)hmacSHA224DataWithKey:(NSData *)key;

//sha256 + key
- (NSString *)hmacSHA256StringWithKey:(NSString *)key;
- (NSData *)hmacSHA256DataWithKey:(NSData *)key;

//sha384 + key
- (NSString *)hmacSHA384StringWithKey:(NSString *)key;
- (NSData *)hmacSHA384DataWithKey:(NSData *)key;

//sha512 + key
- (NSString *)hmacSHA512StringWithKey:(NSString *)key;
- (NSData *)hmacSHA512DataWithKey:(NSData *)key;

//crc32
- (NSString *)crc32String;
- (uint32_t)crc32;


#pragma mark - Encrypt and Decrypt：aes256加密

- (nullable NSData *)aes256EncryptWithKey:(NSData *)key iv:(nullable NSData *)iv;


- (nullable NSData *)aes256DecryptWithkey:(NSData *)key iv:(nullable NSData *)iv;


#pragma mark - Encode and decode：utf8编码和解码

- (nullable NSString *)utf8String;

- (nullable NSString *)hexString;

+ (nullable NSData *)dataWithHexString:(NSString *)hexString;

- (nullable NSString *)base64EncodedString;

+ (nullable NSData *)dataWithBase64EncodedString:(NSString *)base64EncodedString;

- (nullable id)jsonValueDecoded;


#pragma mark - Inflate and deflate：压缩和解压缩

- (nullable NSData *)gzipInflate;

- (nullable NSData *)gzipDeflate;

- (nullable NSData *)zlibInflate;

- (nullable NSData *)zlibDeflate;


#pragma mark - Others：文件名读取data

+ (nullable NSData *)dataNamed:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
