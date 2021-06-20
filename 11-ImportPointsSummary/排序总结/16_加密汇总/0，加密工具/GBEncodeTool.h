//
//  GBEncodeTool.h
//  各种加密手段
//
//  Created by 张国兵 on 15/9/19.
//  Copyright (c) 2015年 zhangguobing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTMBase64.h"
#import "NSData+AES.h"
#import "RSACodeTool.h"

#define AES_KEY @"D5B6D8584F94B434"
#define AES_IV @"205681D89D731A8E"
#define DES_KEY @"D5B6D8584F94B434"
#define DES_IV @"205681D89D731A8E"
#define PUBLIC_APP_KEY @"helloWord"
#define PUBLICK_KEY @"-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDEChqe80lJLTTkJD3X3Lyd7Fj+\nzuOhDZkjuLNPog3YR20e5JcrdqI9IFzNbACY/GQVhbnbvBqYgyql8DfPCGXpn0+X\nNSxELIUw9Vh32QuhGNr3/TBpechrVeVpFPLwyaYNEk1CawgHCeQqf5uaqiaoBDOT\nqeox88Lc1ld7MsfggQIDAQAB\n-----END PUBLIC KEY-----"
#define PRIVATE_KEY @"-----BEGIN RSA PRIVATE KEY-----\nMIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMQKGp7zSUktNOQk\nPdfcvJ3sWP7O46ENmSO4s0+iDdhHbR7klyt2oj0gXM1sAJj8ZBWFudu8GpiDKqXw\nN88IZemfT5c1LEQshTD1WHfZC6EY2vf9MGl5yGtV5WkU8vDJpg0STUJrCAcJ5Cp/\nm5qqJqgEM5Op6jHzwtzWV3syx+CBAgMBAAECgYEApSzqPzE3d3uqi+tpXB71oY5J\ncfB55PIjLPDrzFX7mlacP6JVKN7dVemVp9OvMTe/UE8LSXRVaFlkLsqXC07FJjhu\nwFXHPdnUf5sanLLdnzt3Mc8vMgUamGJl+er0wdzxM1kPTh0Tmq+DSlu5TlopAHd5\nIqF3DYiORIen3xIwp0ECQQDj6GFaXWzWAu5oUq6j1msTRV3mRZnx8Amxt1ssYM0+\nJLf6QYmpkGFqiQOhHkMgVUwRFqJC8A9EVR1eqabcBXbpAkEA3DQfLVr94vsIWL6+\nVrFcPJW9Xk28CNY6Xnvkin815o2Q0JUHIIIod1eVKCiYDUzZAYAsW0gefJ49sJ4Y\niRJN2QJAKuxeQX2s/NWKfz1rRNIiUnvTBoZ/SvCxcrYcxsvoe9bAi7KCMdxObJkn\nhNXFQLav39wKbV73ESCSqnx7P58L2QJABmhR2+0A5EDvvj1WpokkqPKmfv7+ELfD\nHQq33LvU4q+N3jPn8C85ZDedNHzx57kru1pyb/mKQZANNX10M1DgCQJBAMKn0lEx\nQH2GrkjeWgGVpPZkp0YC+ztNjaUMJmY5g0INUlDgqTWFNftxe8ROvt7JtUvlgtKC\nXdXQrKaEnpebeUQ=\n-----END RSA PRIVATE KEY-----"

@interface GBEncodeTool : NSObject

/**
 *  16位MD5加密方式（16个字节长度）
 *  经典的哈希算法不可逆
 *  @param srcString   加密的明文
 *  @param isUppercase 是否大写
 *
 *  @return 加密好的密文
 */
+ (NSString *)getMd5_16Bit_String:(NSString *)srcString isUppercase:(BOOL)isUppercase;
/**
 *  32位MD5加密方式(长度是32字节中间16位字节和16加密的结果相同)
 *  经典的哈希算法不可逆
 *  @param NSString 加密的明文
 *  @param isUppercase 是否大写
 *  @return 加密后的密文
 */
+ (NSString *)getMd5_32Bit_String:(NSString *)srcString isUppercase:(BOOL)isUppercase;
/**
 *  sha1加密方式
 *  经典的哈希算法不可逆
 *  @param NSString 要加密的明文
 *  @param isUppercase 是否大写
 *  @return 密文
 */

+ (NSString *)getSha1String:(NSString *)srcString
                isUppercase:(BOOL)isUppercase;
/**
 *  sha256加密方式
 *  经典的哈希算法不可逆
 *  @param NSString 要加密的明文
 *  @param isUppercase 是否大写
 *  @return 密文
 */

+ (NSString *)getSha256String:(NSString *)srcString
                  isUppercase:(BOOL)isUppercase;
/**
 *  sha384加密方式
 *  经典的哈希算法不可逆
 *  @param NSString 要加密的明文
 *  @param isUppercase 是否大写
 *  @return 密文
 */

+ (NSString *)getSha384String:(NSString *)srcString
                  isUppercase:(BOOL)isUppercase;
/**
 *  sha512加密方式
 *  经典的哈希算法不可逆
 *  @param NSString 要加密的明文
 *  @param isUppercase 是否大写
 *  @return 密文
 */
+ (NSString*) getSha512String:(NSString*)srcString
                  isUppercase:(BOOL)isUppercase;

/**
 *  base64加密
 *
 *  @param input 明文（字符创类型）
 *
 *  @return 密文
 */
+ (NSString*)encodeBase64String:(NSString *)input;
/**
 *  base64解密
 *
 *  @param input 密文
 *
 *  @return 明文
 */
+ (NSString*)decodeBase64String:(NSString *)input;
/**
 *  base64加密
 *
 *  @param data 明文（二进制）
 *
 *  @return 密文（字符串）
 */
+ (NSString*)encodeBase64Data:(NSData *)data;
/**
 *  base64解密
 *
 *  @param data 密文（二进制）
 *
 *  @return 明文（字符串）
 */

+ (NSString*)decodeBase64Data:(NSData *)data;
/**
 *  DES加密 ECB模式（最常用最简单的模式）
 *
 *  @param plainText 明文
 *  @param key       密钥
 *
 *  @return  密文
 */
+ (NSString*)DESEncrypt:(NSString *)plainText WithKey:(NSString *)key;
/**
 *  DES解密 ECB模式（最常用最简单的模式）
 *
 *  @param encryptText 密文
 *  @param key         密钥
 *
 *  @return 明文
 */
+ (NSString*)DESDecrypt:(NSString *)encryptText WithKey:(NSString *)key;
/**
 *  DES加密 CBC模式
 *
 *  @param plainText 明文
 *  @param key       密钥
 *  @param iv        偏移量
 *
 *  @return 密文
 */
+ (NSString*)DESEncrypt:(NSString *)plainText
                      Key:(NSString *)key
                       IV:(NSString*)iv;
/**
 *  DES解密 CBC模式
 *
 *  @param encryptText 密文
 *  @param key       密钥
 *  @param iv        偏移
 *
 *  @return 明文
 */
+ (NSString*)DESDecrypt:(NSString *)encryptText
                      Key:(NSString *)key
                       IV:(NSString*)iv;
/**
 *  AES128加密（非CBC模式）
 *
 *  @param plainText 明文
 *  @param key       密钥（16字节）
 *
 *  @return 密文
 */
+ (NSString*) AES128Encrypt:(NSString *)plainText WithKey:(NSString *)key;
/**
 *  AES128解密（非CBC模式）
 *
 *  @param encryptText 密文
 *  @param key         密钥（16字节）
 *
 *  @return 明文
 */

+ (NSString*) AES128Decrypt:(NSString *)encryptText WithKey:(NSString *)key;
/**
 *  AES128加密(CBC模式，安全性更高，与java和php互通）
 *
 *  @param plainText 明文
 *  @param key       密钥
 *  @param iv        iv参数（偏移量）
 *
 *  @return 密文
 */
+ (NSString*)AES128Encrypt:(NSString *)plainText
                      Key:(NSString *)key
                       IV:(NSString*)iv;
/**
 *  AES128解密(CBC模式，安全性更高，与java和php互通）
 *
 *  @param plainText 密文
 *  @param key       密钥
 *  @param iv        iv参数（偏移量）
 *
 *  @return 明文
 */
+ (NSString*)AES128Decrypt:(NSString *)plainText
                      Key:(NSString *)key
                       IV:(NSString*)iv;
/**
 *  AES128解密(CBC模式，安全性更高，与java和php互通）
 *
 *  @param HexPlainText 密文(16进制)
 *  @param key       密钥
 *  @param iv        iv参数（偏移量）
 *
 *  @return 明文
 */

+ (NSString*)AES128HexDecrypt:(NSString *)HexPlainText
                         Key:(NSString *)key
                          IV:(NSString*)iv;
/**
 *  AES 256解密(CBC模式，安全性更高，与java和php互通）
 *
 *  @param HexPlainText 密文(16进制)
 *  @param key       密钥
 *  @param iv        iv参数（偏移量）
 *
 *  @return 明文
 */
+ (NSString*)AES256HexDecrypt:(NSString *)HexPlainText
                         Key:(NSString *)key
                          IV:(NSString*)iv;
/**
 *  AES192加密
 *
 *  @param plainText 明文
 *  @param key       密钥（24字节）
 *
 *  @return 密文
 */
+ (NSString*) AES192Encrypt:(NSString *)plainText WithKey:(NSString *)key;
/**
 *  AES192解密
 *
 *  @param encryptText 密文
 *  @param key         密钥（24字节）
 *
 *  @return 明文
 */
+ (NSString*) AES192Decrypt:(NSString *)encryptText WithKey:(NSString *)key;
/**
 *  AES256加密(CBC模式，安全性更高，与java和php互通）
 *
 *  @param plainText 明文
 *  @param key       密钥
 *  @param iv        iv参数（偏移量）
 *
 *  @return 密文
 */
+ (NSString*)AES256Encrypt:(NSString *)plainText
                      Key:(NSString *)key
                       IV:(NSString*)iv;
/**
 *  AES256解密(CBC模式，安全性更高，与java和php互通）
 *
 *  @param plainText 密文
 *  @param key       密钥
 *  @param iv        iv参数（偏移量）
 *
 *  @return 明文
 */
+ (NSString*)AES256Decrypt:(NSString *)plainText
                      Key:(NSString *)key
                       IV:(NSString*)iv;
/**
 *  AES256加密
 *
 *  @param plainText 明文
 *  @param key       密钥（32字节）
 *
 *  @return 密文
 */
+ (NSString*) AES256Encrypt:(NSString *)plainText WithKey:(NSString *)key;
/**
 *  AES256解密
 *
 *  @param encryptText 密文
 *  @param key         密钥（32字节）
 *
 *  @return 明文
 */
+ (NSString*) AES256Decrypt:(NSString *)encryptText WithKey:(NSString *)key;
/**
 *  计算大文件的md5值
 *
 *  @param path 文件路径
 *
 *  @return md5值
 *
 *  应用场景：一般我们在使用http或者socket上传或者下载文件的时候，经常会在完成之后经行一次MD5值得校验（尤其是在断点续传的时候用的更
 多），校验MD5值是为了防止在传输的过程当中丢包或者数据包被篡改
 */
+ (NSString*)getFileMD5:(NSString*)path;
/**
 *  配置公钥
 *  public_key.der公钥
 *  公钥负责加密
 */
+ (void)configPublickKey:(NSString*)publickKeyPath;
/**
 *  配置私钥
 *  private_key.p12私钥
 *  私钥负责解密
 *  @param PrivateKeyPath 私钥路径
 *  @param p12Password    私钥密码
 */
+ (void)configPrivateKey:(NSString *)privateKeyPath
               Password:(NSString *)p12Password;
/**
 *  rsa加密
 *
 *  @param text 明文 NSString
 *
 *  @return 密文 NSString
 */
+ (NSString *)rsaEncryptText:(NSString *)text;
/**
 *  rsa解密
 *
 *  @param text 密文
 *
 *  @return 明文
 */
+ (NSString *)rsaDecryptText:(NSString *)text;

/**
 *  rsa加密
 *
 *  @param str    要加密的明文
 *  @param pubKey 加密公钥
 *
 *  @return 加密之后的密文
 */
+ (NSString *)rsaEncryptString:(NSString *)str publicKey:(NSString *)pubKey;
/**
 *  rsa 加密
 *
 *  @param data   数据加密
 *  @param pubKey 公钥
 *
 *  @return 加密之后的数据
 */
+ (NSData *)rsaEncryptData:(NSData *)data publicKey:(NSString *)pubKey;
/**
 *  rsa解密
 *
 *  @param str     密文
 *  @param privKey 密钥
 *
 *  @return 明文
 */
+ (NSString *)rsaDecryptString:(NSString *)str privateKey:(NSString *)privKey;
/**
 *  rsa解密
 *
 *  @param data    数据密文
 *  @param privKey 密钥
 *
 *  @return 数据明文
 */
+ (NSData *)rsaDecryptData:(NSData *)data privateKey:(NSString *)privKey;


@end
