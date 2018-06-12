//
//  NSString+Practical.h
//  ToolAndExtensionSummary
//
//  Created by gjfax on 2018/6/12.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Practical)

#pragma mark -  对象方法
//* 计算字符串的宽度
- (CGSize)getTextSize:(CGFloat)fontSize maxWidth:(CGFloat)maxWidth;

//* 返回一个带千位符的字符串
- (NSString *)formatStrTo10_4;

//* 返回一个带千位符无小数的字符串
- (NSString *)formatStrTo10_4WithNoDecimal;

//* 返回一个标准的数字字符串 - 不带千分位
- (NSString *)formatStrWithSignToNumberStr;

//* 电话号码（隐藏中间5位数字）
- (NSString *)hidePhoneNumStr;

//* 银行卡号（隐藏前面数字，保留后4位）
- (NSString *)hideBankCardNumStr;

//* 用户姓名（隐藏姓）
- (NSString *)hideUserNameStr;

//* 身份证号码（隐藏中间4～10位）
- (NSString *)hideIdNumStr;

//* 隐藏用户名输入框(4位以内，不隐藏；4位以上：隐藏中间所有，只留头和尾部)
- (NSString *)hidePhoneTFContent;

//* URLEncode编码

- (NSString *)URLEncodedString;

//* URLDecode解码
-(NSString *)URLDecodedString;

#pragma mark -  类方法
//* 获取当前时间字符串
+ (NSString *)getCurrentTimeStampStr;

//* 返回普通网络数据安全值
+ (NSString *)returnString:(NSString *)string WithNoDataString:(NSString *)noDataString;

//* 返回带千分位的网络数据安全值
+ (NSString *)returnThousandString:(NSString *)string WithNoDataString:(NSString *)noDataString;

//* 返回拼接的网络数据安全值
+ (NSString *)returnJointString:(NSString *)jointString withString:(NSString *)string WithNoDataString:(NSString *)noDataString;

#pragma mark - SHA1+RSA 验签
+ (NSString *)signSHA1WithRSA:(NSString *)plainText privateKey:(NSString *)privateKey;

+ (BOOL)verifySHA1WithRSA:(NSString *)plainString signature:(NSString *)signatureString publicKey:(NSString *)publicKeyStr;


#pragma mark -  bool判断

//* 是否是小数
- (BOOL)isDecimalNumStr;

//*  是否空字符串
- (BOOL)isNullStr;

/**
 * 充值、提现和转让输入框规则
 1. 不允许输入任何符号，小数点除外
 2. 第一位不支持小数点
 3. 只允许出现一次小数点
 */
- (BOOL)isFilterRulesStr;

//* 是否是email格式

- (BOOL)isEmailFormat;

//* 是否是手机号码格式

- (BOOL)isMobilePhoneNumFormat;

//* 是否身份证格式
- (BOOL)isIDCardFormat;

//* 是否纯数字格式
- (BOOL)isOnlyNumberFormat;

//* 是否不带符号的密码格式[有字母数字组成]
- (BOOL)isPasswordWithoutSymbolFormat;

//* 判断是否是纯汉字
- (BOOL)isChinese;

//* 判断是否含中文以外的字符
- (BOOL)includeOuterChinese;

@end
