//
//  NSString+Practical.m
//  ToolAndExtensionSummary
//
//  Created by gjfax on 2018/6/12.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "NSString+Practical.h"
#import "NSObject+Category.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Practical)

- (CGSize)getTextSize:(CGFloat)fontSize maxWidth:(CGFloat)maxWidth {
    
    CGSize textSize;
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    if (IOS_VERSION >= 7.0) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        textSize = [self boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)
                                      options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                   attributes:@{NSFontAttributeName: font, NSParagraphStyleAttributeName:paragraphStyle}
                                      context:nil].size;
    }
    else {
        textSize = [self sizeWithFont:font
                    constrainedToSize:CGSizeMake(maxWidth, MAXFLOAT)
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
    
    return textSize;
}

- (NSString *)formatStrTo10_4
{
    if ([self isNilObj]) {
        return @"--";
    }
    
    NSString *retStr = [self formatStrWithFormat:self positiveFormat:@"###,##0.00;"];
    
    return retStr;
}

- (NSString *)formatStrTo10_4WithNoDecimal
{
    if ([self isNilObj]) {
        return @"--";
    }
    
    NSString *retStr = [self formatStrWithFormat:self positiveFormat:@"###,##0;"];
    
    return retStr;
}

- (NSString *)formatStrWithFormat:(id)str positiveFormat:(NSString *)positiveFormat
{
    //  id类型转换成str
    NSString *srcStr = FMT_STR(@"%@", str);
    NSString *srcStrNoSign = srcStr;
    
    if (![self isNullStr] && [self respondsToSelector:@selector(isNullStr)]) {
        
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

- (NSString *)formatStrWithSignToNumberStr
{
    //  id类型转换成str
    NSString *srcStrNoSign = FMT_STR(@"%@", self);
    
    if (![self isNullStr] && [self respondsToSelector:@selector(isNullStr)]) {
        //  在str判断是否有‘,’
        if ([srcStrNoSign rangeOfString:@"," options:NSLiteralSearch].location != NSNotFound) {
            //  如果源数据有千分位或者逗号 去掉千分位
            srcStrNoSign = [self stringByReplacingOccurrencesOfString:@"," withString:@""];
        }
        
        return srcStrNoSign;
    }
    
    return @"0.0";
}

- (BOOL)isDecimalNumStr
{
    if (![self isNullStr] && [self respondsToSelector:@selector(isNullStr)]) {
        NSString *strNum = [[NSString alloc] initWithString:self];
        
        if([strNum rangeOfString:@"." options:NSLiteralSearch].location != NSNotFound) {
            return YES;
        } else {
            return NO;
        }
    }
    
    return NO;
}

- (NSString *)hidePhoneNumStr
{
    if (![self isNullStr] && [self respondsToSelector:@selector(isNullStr)]) {
        
        NSString *tempStr = [NSString stringWithString:self];
        
        if (tempStr.length == 11) {
            //  隐藏中间部分
            NSRange rang = NSMakeRange(3, 4);
            NSString *retStr = [tempStr stringByReplacingCharactersInRange:rang withString:@"****"];
            tempStr = [NSString stringWithString:retStr];
        }
        return tempStr;
    }
    return @"--";
}

- (NSString *)hideBankCardNumStr
{
    if (![self isNullStr] && [self respondsToSelector:@selector(isNullStr)]) {
        NSString *tempStr = [NSString stringWithString:self];
        
        if (tempStr.length < 4) {
            return tempStr;
        }
        
        //  隐藏中间部分
        NSRange rang = NSMakeRange(0, tempStr.length - 4);
        NSString *retStr = [tempStr stringByReplacingCharactersInRange:rang withString:@"***************"];
        tempStr = [NSString stringWithString:retStr];
        
        return tempStr;
    }
    return @"--";
}

- (NSString *)hideUserNameStr
{
    if ([self isNullStr]) {
        return @"--";
    }
    
    NSString *tempStr = FMT_STR(@"%@", self);
    
    if (tempStr.length < 1) {
        return tempStr;
    }
    
    //  隐藏中间部分
    NSRange rang = NSMakeRange(0, 1);
    NSString *retStr = [tempStr stringByReplacingCharactersInRange:rang withString:@"*"];
    tempStr = FMT_STR(@"%@", retStr);
    
    return tempStr;
}

- (NSString *)hideIdNumStr
{
    if ([self isNullStr]) {
        return @"--";
    }
    
    NSString *tempStr = FMT_STR(@"%@", self);
    
    if (tempStr.length < 18) {
        return tempStr;
    }
    
    //  隐藏中间部分
    NSRange rang = NSMakeRange(4, 10);
    NSString *retStr = [tempStr stringByReplacingCharactersInRange:rang withString:@"**********"];
    tempStr = FMT_STR(@"%@", retStr);
    
    return tempStr;
}

- (NSString *)hidePhoneTFContent
{
    NSString *textFieldContent = FMT_STR(@"%@", self);
    
    if (textFieldContent.length >= 4 && textFieldContent.length <= 6) {
        
        if (textFieldContent.length %2 == 0) {
            NSUInteger num = textFieldContent.length / 2 - 1;
            textFieldContent = FMT_STR(@"%@**%@",[textFieldContent substringWithRange:NSMakeRange(0, num)],[textFieldContent substringWithRange:NSMakeRange(num + 2, textFieldContent.length - num - 2)]);
            
        } else if (textFieldContent.length %2 != 0) {
            NSUInteger num = (textFieldContent.length - 1) / 2 - 1;
            textFieldContent = FMT_STR(@"%@**%@",[textFieldContent substringWithRange:NSMakeRange(0, num)],[textFieldContent substringWithRange:NSMakeRange(num + 2, textFieldContent.length - num - 2)]);
        }
        
    } else if (textFieldContent.length > 6) {
        
        if (textFieldContent.length %2 == 0) {
            NSUInteger num = textFieldContent.length / 2 - 2;
            textFieldContent = FMT_STR(@"%@****%@",[textFieldContent substringWithRange:NSMakeRange(0, num)],[textFieldContent substringWithRange:NSMakeRange(num + 4, textFieldContent.length - num - 4)]);
            
        } else if (textFieldContent.length %2 != 0) {
            NSUInteger num = (textFieldContent.length - 1) / 2 - 2;
            textFieldContent = FMT_STR(@"%@****%@",[textFieldContent substringWithRange:NSMakeRange(0, num)],[textFieldContent substringWithRange:NSMakeRange(num + 4, textFieldContent.length - num - 4)]);
        }
    }
    return textFieldContent;
}

- (BOOL)isNullStr
{
    if ([self isNilObj]) {
        return YES;
    } else if (FMT_STR(@"%@", self).length <= 0) {
        return YES;
    } else if ([FMT_STR(@"%@", self) isEqualToString:@"<null>"]) {
        return YES;
    }
    
    return NO;
}

- (BOOL)isFilterRulesStr
{
    //1.不允许输入任何符号,小数点除外
    //2.第一位不支持小数点
    //3.只允许出现一次小数点
    //6.类似001等,合法,自动提取转化
    NSString *rule = @"^[0-9]+([.]{0}|[.]{1}[0-9]*)$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", rule];
    
    return [predicate evaluateWithObject:self];
}


/**
 *  返回普通网络数据安全值
 */
+ (NSString *)returnString:(NSString *)string WithNoDataString:(NSString *)noDataString  {
    
    if (string && ![string isNullStr] && [string respondsToSelector:@selector(isNullStr)]) {
        return string;
    } else {
        return noDataString;
    }
}
/**
 *  返回带千分位的网络数据安全值
 */
+ (NSString *)returnThousandString:(NSString *)string WithNoDataString:(NSString *)noDataString {
    if (string && ![string isNullStr] && [string respondsToSelector:@selector(isNullStr)]) {
        
        return [string formatStrTo10_4];
    } else {
        return noDataString;
    }
}
/**
 *  返回拼接的网络数据安全值
 */
+ (NSString *)returnJointString:(NSString *)jointString withString:(NSString *)string WithNoDataString:(NSString *)noDataString  {
    
    if (string && ![string isNullStr] && [string respondsToSelector:@selector(isNullStr)]) {
        return jointString;
    } else {
        return noDataString;
    }
}

#define kChosenDigestLength CC_SHA1_DIGEST_LENGTH

+ (NSData *)getHashBytes1:(NSData *)plainText {
    
    CC_SHA1_CTX ctx;
    
    uint8_t *hashBytes =NULL;
    
    NSData *hash =nil;
    
    // Malloc a buffer to hold hash.
    
    hashBytes = malloc(kChosenDigestLength *sizeof(uint8_t));
    
    memset((void*)hashBytes, 0x0, kChosenDigestLength);
    
    // Initialize the context.
    
    CC_SHA1_Init(&ctx);
    
    // Perform the hash.
    
    CC_SHA1_Update(&ctx, (void*)[plainText bytes], (CC_LONG)[plainText length]);
    
    // Finalize the output.
    
    CC_SHA1_Final(hashBytes, &ctx);
    
    // Build up the SHA1 blob.
    
    hash = [NSData dataWithBytes:(const void*)hashBytes length:(NSUInteger)kChosenDigestLength];
    
    if(hashBytes) free(hashBytes);
    
    return hash;
    
}

+ (NSString*)signTheDataSHA1WithRSA:(NSString *)plainText
{
    
    uint8_t *signedBytes = NULL;
    
    size_t signedBytesSize = 0;
    
    OSStatus sanityCheck = noErr;
    
    NSData *signedHash = nil;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"privateKey" ofType:@"p12"];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];// Set the private key query dictionary.
    
    [options setObject:@"123456"forKey:(id)kSecImportExportPassphrase];
    
    CFArrayRef items = CFArrayCreate(NULL,0,0,NULL);
    
    OSStatus securityError = SecPKCS12Import((CFDataRef) data, (CFDictionaryRef)options, &items);
    
    if(securityError != noErr) {
        
        return nil;
        
    }
    
    CFDictionaryRef identityDict = CFArrayGetValueAtIndex(items,0);
    
    SecIdentityRef identityApp = (SecIdentityRef)CFDictionaryGetValue(identityDict,kSecImportItemIdentity);
    
    SecKeyRef privateKeyRef = nil;
    
    SecIdentityCopyPrivateKey(identityApp, &privateKeyRef);
    
    signedBytesSize = SecKeyGetBlockSize(privateKeyRef);
    
    NSData *plainTextBytes = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    
    signedBytes = malloc(signedBytesSize *sizeof(uint8_t));// Malloc a buffer to hold signature.
    
    memset((void *)signedBytes,0x0, signedBytesSize);
    
    sanityCheck = SecKeyRawSign(privateKeyRef,
                                
                                kSecPaddingPKCS1SHA1,
                                
                                (const uint8_t*)[[self getHashBytes:plainTextBytes] bytes],
                                
                                kChosenDigestLength,
                                
                                (uint8_t*)signedBytes,
                                
                                &signedBytesSize);
    
    if(sanityCheck == noErr)
        
    {
        
        signedHash = [NSData dataWithBytes:(const void*)signedBytes length:(NSUInteger)signedBytesSize];
        
    }
    
    else
        
    {
        
        return nil;
        
    }
    
    if(signedBytes)
        
    {
        
        free(signedBytes);
        
    }
    
    NSString *signatureResult = [[NSString alloc] initWithData:[signedHash base64EncodedDataWithOptions:0] encoding:NSASCIIStringEncoding];
    
    return signatureResult;
    
}

+ (NSString *)getCurrentTimeStampStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYYMMddHHmmss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    DLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
}


//#define kPrivateKey @"MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCu3I7blvOYt3q3gmBPuUSA2p8STjxW7UTEBInHkq0IcYsjG2egYt/Qa4eJVQDbJVnsLkmG1Wv+6nWULNgFtDVEKr3/hX9XGzmrhi4rpdYnylLUnP/sxXmFpWYlzFlpMjfFVHPvv2qHY9TqMMVM/rGG9zdzDR2NFaZw4m5qHxIyGamXMK2HkqIHVKUp9156uHeiz9gkKQrtiNcaUy5/6Y7IxgA2uAX3A4uottqeiNI8JHu1IMEMvQU/sPidLglfhnRROnqBuJpMfoLrbhQkPK9uWclJT9oN2Rtsrz8lqHGCed6/LGBiqfuCH3BbaPJteJSE3xpi+gGR8y71CoNECSXbAgMBAAECggEAM+1fpypOsL1b/f8Dpuk3xKQntQHyvUW8tBE88T1HkUhWr1hGD8UM/hHQsCHEHVAcQh0EzLu4VH0/6X7fr+HyJ4oh3i3AwRdequcv8tpOnIZizqzI+4ExM1UI3pSuwKSfF0SbIUlQ01/8LIfLL7A6+/+SQeJVMj6JrOAxNeaAOswQZGA/HX4kuOO2e3xJwhYtUAXPHPnGAUqtqKuezJrxrLYpmFHAGEBMRzfI4wo3RVdFM3YZh4IgA2SS1Cwd/ttBHAr1EZ9yzs068AlJqWBsS461uWj/vXKFXggQWLCAYgxN78Zgp1cjQf6DrvrS2W0qsw+IOuGyB3yAa3YqvBCzgQKBgQD97Fzzmjt1uMXEHkaecQdEuHLfCR1STVnaVjVVoPRnF7A56nLPl3Ztmo2NWqDycxdoAYg5wdRmaGdGHfq8qSht7JwQRQFzGD+aZGKuf5DzZnbnD+b2au9hIjCcl6b9fktC1tXlponroC8GqdKK6tKrwBppFtfnpIzybwunTKSaIQKBgQCwSqoCTY60rBo9NkW9j1zCV6FpI8StdQ5n7QIZesgIoHyvqr/1ZK0TAzCxYaUuG/B/6/TACx36jk17jn+/X+4c0QFsJmZUjiN5C5RilTNoUe3dCkHBKt4dhCsn30JJmePXwalRETT+vcuc16yi9mAWRyVorsm4yKq3bvE6soAYewKBgBnF7/lZ4kckpg4t9IUIe/BhuGcjCbLc3w3mSiuS1rvQD7cRMO4ZNZASa+O5GzUAsZOA9E7IecKbPkBDsruLf+sIZR7RokAIagxFvC5yDEhoUhFJ7+t7FykIy15Zlj2MoB78p2FT8hPUgnFus0weYZvFN+kKxIdikFvbIZetk9eBAoGATupNalR/kj8MS+R0maOIWXLSzXb2ftNMjJca/n7o9nuo9RYRce8MTtt5u53DTH2zTgA5ApK3a8axxqKGawutUnb5FQmneyhZlsDpPqwdZBBw0ybZQnhHD51vmByn1rytspJ9kc2LFJGviNk+7YAuiSp2A4Nix3YEfbKLB8SJ9OsCgYA0fex/VF3jzV1/pJnyKQCRmIRJw7zTeBdmlJSTe287tiNi5f4YxMiWY4koOtVfRPvErJ75yrfkOrgf9JXyKKNpnKBXDvwJfjG0X8Sr9DhX81r100ZJ+p1Qk1ZxZqT11D2mTBOWx4rXnlrDc2ifW1aT5IJKM87BWxkejET6Ja3yTQ=="
//
//#define kPublicKey @"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArtyO25bzmLd6t4JgT7lEgNqfEk48Vu1ExASJx5KtCHGLIxtnoGLf0GuHiVUA2yVZ7C5JhtVr/up1lCzYBbQ1RCq9/4V/Vxs5q4YuK6XWJ8pS1Jz/7MV5haVmJcxZaTI3xVRz779qh2PU6jDFTP6xhvc3cw0djRWmcOJuah8SMhmplzCth5KiB1SlKfdeerh3os/YJCkK7YjXGlMuf+mOyMYANrgF9wOLqLbanojSPCR7tSDBDL0FP7D4nS4JX4Z0UTp6gbiaTH6C624UJDyvblnJSU/aDdkbbK8/JahxgnnevyxgYqn7gh9wW2jybXiUhN8aYvoBkfMu9QqDRAkl2wIDAQAB"


#pragma mark - SHA1+RSA 验签

+ (NSString *)signSHA1WithRSA:(NSString *)plainText privateKey:(NSString *)privateKey{
    
    uint8_t* signedBytes = NULL;
    
    size_t signedBytesSize = 0;
    
    OSStatus sanityCheck = noErr;
    
    NSData* signedHash = nil;
    
    SecKeyRef privateKeyRef = [self addPrivateKey:privateKey];
    
    signedBytesSize = SecKeyGetBlockSize(privateKeyRef);
    
    NSData *plainTextBytes = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    
    signedBytes = malloc( signedBytesSize * sizeof(uint8_t) );
    
    memset((void  *)signedBytes, 0x0, signedBytesSize);
    
    sanityCheck = SecKeyRawSign(privateKeyRef,
                                
                                kSecPaddingPKCS1SHA1,
                                
                                (const uint8_t *)[[self getHashBytes:plainTextBytes] bytes],
                                
                                kChosenDigestLength,
                                
                                (uint8_t *)signedBytes,
                                
                                &signedBytesSize);
    
    if (sanityCheck == noErr){
        
        signedHash = [NSData dataWithBytes:(const void  *)signedBytes length:(NSUInteger)signedBytesSize];
        
    }
    
    else{
        
        return nil;
        
    }
    
    if (signedBytes){
        
        free(signedBytes);
        
    }
    
    NSString *signatureResult = [self base64EncodeData:signedHash];
    
    return signatureResult;
    
}

+ (NSData *)getHashBytes:(NSData *)plainText {
    
    CC_SHA1_CTX ctx;
    
    uint8_t * hashBytes = NULL;
    
    NSData * hash = nil;
    
    // Malloc a buffer to hold hash.
    
    hashBytes = malloc( kChosenDigestLength * sizeof(uint8_t) );
    
    memset((void  *)hashBytes, 0x0, kChosenDigestLength);
    
    // Initialize the context.
    
    CC_SHA1_Init(&ctx);
    
    // Perform the hash.
    
    CC_SHA1_Update(&ctx, (void  *)[plainText bytes], [plainText length]);
    
    // Finalize the output.
    
    CC_SHA1_Final(hashBytes, &ctx);
    
    hash = [NSData dataWithBytes:(const void  *)hashBytes length:(NSUInteger)kChosenDigestLength];
    
    if (hashBytes) free(hashBytes);
    
    return hash;
    
}

#pragma mark - SHA1+RSA 验签

+ (BOOL)verifySHA1WithRSA:(NSString *)plainString signature:(NSString *)signatureString publicKey:(NSString *)publicKeyStr{
    
    NSData *plainData = [plainString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *signatureData = [self base64DecodeString:signatureString];
    
    SecKeyRef publicKey = [self addPublicKey:publicKeyStr];
    
    size_t signedHashBytesSize = SecKeyGetBlockSize(publicKey);
    
    const void* signedHashBytes = [signatureData bytes];
    
    size_t hashBytesSize = CC_SHA1_DIGEST_LENGTH;
    
    uint8_t* hashBytes = malloc(hashBytesSize);
    
    if (!CC_SHA1([plainData bytes], (CC_LONG)[plainData length], hashBytes)) {
        
        return NO;
        
    }
    
    OSStatus status = SecKeyRawVerify(publicKey,
                                      
                                      kSecPaddingPKCS1SHA1,
                                      
                                      hashBytes,
                                      
                                      hashBytesSize,
                                      
                                      signedHashBytes,
                                      
                                      signedHashBytesSize);
    
    return status == errSecSuccess;
    
}

#pragma mark - Base64

+ (NSString *)base64EncodeData:(NSData *)data{
    
    data = [data base64EncodedDataWithOptions:0];
    
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return ret;
    
}

+ (NSData *)base64DecodeString:(NSString *)string{
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    return data;
    
}

+ (SecKeyRef)addPrivateKey:(NSString *)key{
    
    NSRange spos = [key rangeOfString:@"-----BEGIN RSA PRIVATE KEY-----"];
    
    NSRange epos = [key rangeOfString:@"-----END RSA PRIVATE KEY-----"];
    
    if(spos.location != NSNotFound && epos.location != NSNotFound){
        
        NSUInteger s = spos.location + spos.length;
        
        NSUInteger e = epos.location;
        
        NSRange range = NSMakeRange(s, e-s);
        
        key = [key substringWithRange:range];
        
    }
    
    key = [key stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    key = [key stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    key = [key stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    
    key = [key stringByReplacingOccurrencesOfString:@" "  withString:@""];
    
    NSData *data = base64_decode(key);
    
    data = [self stripPrivateKeyHeader:data];
    
    if(!data){
        
        return nil;
        
    }
    
    NSString *tag = @"RSAUtil_PrivKey";
    
    NSData *d_tag = [NSData dataWithBytes:[tag UTF8String] length:[tag length]];
    
    NSMutableDictionary *privateKey = [[NSMutableDictionary alloc] init];
    
    [privateKey setObject:(__bridge id) kSecClassKey forKey:(__bridge id)kSecClass];
    
    [privateKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    
    [privateKey setObject:d_tag forKey:(__bridge id)kSecAttrApplicationTag];
    
    SecItemDelete((__bridge CFDictionaryRef)privateKey);
    
    [privateKey setObject:data forKey:(__bridge id)kSecValueData];
    
    [privateKey setObject:(__bridge id) kSecAttrKeyClassPrivate forKey:(__bridge id)
     
     kSecAttrKeyClass];
    
    [privateKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)
     
     kSecReturnPersistentRef];
    
    CFTypeRef persistKey = nil;
    
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)privateKey, &persistKey);
    
    if (persistKey != nil){
        
        CFRelease(persistKey);
        
    }
    
    if ((status != noErr) && (status != errSecDuplicateItem)) {
        
        return nil;
        
    }
    
    [privateKey removeObjectForKey:(__bridge id)kSecValueData];
    
    [privateKey removeObjectForKey:(__bridge id)kSecReturnPersistentRef];
    
    [privateKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
    
    [privateKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    
    SecKeyRef keyRef = nil;
    
    status = SecItemCopyMatching((__bridge CFDictionaryRef)privateKey, (CFTypeRef *)&keyRef);
    
    if(status != noErr){
        
        return nil;
        
    }
    
    return keyRef;
    
}

static NSData *base64_decode(NSString *str){
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    return data;
    
}

+ (NSData *)stripPrivateKeyHeader:(NSData *)d_key{
    
    // Skip ASN.1 private key header
    
    if (d_key == nil) return(nil);
    
    unsigned long len = [d_key length];
    
    if (!len) return(nil);
    
    unsigned char *c_key = (unsigned char *)[d_key bytes];
    
    unsigned int  idx    = 22; //magic byte at offset 22
    
    if (0x04 != c_key[idx++]) return nil;
    
    //calculate length of the key
    
    unsigned int c_len = c_key[idx++];
    
    int det = c_len & 0x80;
    
    if (!det) {
        
        c_len = c_len & 0x7f;
        
    } else {
        
        int byteCount = c_len & 0x7f;
        
        if (byteCount + idx > len) {
            
            //rsa length field longer than buffer
            
            return nil;
            
        }
        
        unsigned int accum = 0;
        
        unsigned char *ptr = &c_key[idx];
        
        idx += byteCount;
        
        while (byteCount) {
            
            accum = (accum << 8) + *ptr;
            
            ptr++;
            
            byteCount--;
            
        }
        
        c_len = accum;
        
    }
    
    // Now make a new NSData from this buffer
    
    return [d_key subdataWithRange:NSMakeRange(idx, c_len)];
    
}

+ (SecKeyRef)addPublicKey:(NSString *)key{
    
    NSRange spos = [key rangeOfString:@"-----BEGIN PUBLIC KEY-----"];
    
    NSRange epos = [key rangeOfString:@"-----END PUBLIC KEY-----"];
    
    if(spos.location != NSNotFound && epos.location != NSNotFound){
        
        NSUInteger s = spos.location + spos.length;
        
        NSUInteger e = epos.location;
        
        NSRange range = NSMakeRange(s, e-s);
        
        key = [key substringWithRange:range];
        
    }
    
    key = [key stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    key = [key stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    key = [key stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    
    key = [key stringByReplacingOccurrencesOfString:@" "  withString:@""];
    
    // This will be base64 encoded, decode it.
    
    NSData *data = base64_decode(key);
    
    data = [self stripPublicKeyHeader:data];
    
    if(!data){
        
        return nil;
        
    }
    
    //a tag to read/write keychain storage
    
    NSString *tag = @"RSAUtil_PubKey";
    
    NSData *d_tag = [NSData dataWithBytes:[tag UTF8String] length:[tag length]];
    
    // Delete any old lingering key with the same tag
    
    NSMutableDictionary *publicKey = [[NSMutableDictionary alloc] init];
    
    [publicKey setObject:(__bridge id) kSecClassKey forKey:(__bridge id)kSecClass];
    
    [publicKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    
    [publicKey setObject:d_tag forKey:(__bridge id)kSecAttrApplicationTag];
    
    SecItemDelete((__bridge CFDictionaryRef)publicKey);
    
    // Add persistent version of the key to system keychain
    
    [publicKey setObject:data forKey:(__bridge id)kSecValueData];
    
    [publicKey setObject:(__bridge id) kSecAttrKeyClassPublic forKey:(__bridge id)
     
     kSecAttrKeyClass];
    
    [publicKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)
     
     kSecReturnPersistentRef];
    
    CFTypeRef persistKey = nil;
    
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)publicKey, &persistKey);
    
    if (persistKey != nil){
        
        CFRelease(persistKey);
        
    }
    
    if ((status != noErr) && (status != errSecDuplicateItem)) {
        
        return nil;
        
    }
    
    [publicKey removeObjectForKey:(__bridge id)kSecValueData];
    
    [publicKey removeObjectForKey:(__bridge id)kSecReturnPersistentRef];
    
    [publicKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
    
    [publicKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    
    // Now fetch the SecKeyRef version of the key
    
    SecKeyRef keyRef = nil;
    
    status = SecItemCopyMatching((__bridge CFDictionaryRef)publicKey, (CFTypeRef *)&keyRef);
    
    if(status != noErr){
        
        return nil;
        
    }
    
    return keyRef;
    
}

+ (NSData *)stripPublicKeyHeader:(NSData *)d_key{
    
    // Skip ASN.1 public key header
    
    if (d_key == nil) return(nil);
    
    unsigned long len = [d_key length];
    
    if (!len) return(nil);
    
    unsigned char *c_key = (unsigned char *)[d_key bytes];
    
    unsigned int  idx    = 0;
    
    if (c_key[idx++] != 0x30) return(nil);
    
    if (c_key[idx] > 0x80) idx += c_key[idx] - 0x80 + 1;
    
    else idx++;
    
    // PKCS #1 rsaEncryption szOID_RSA_RSA
    
    static unsigned char seqiod[] =
    
    { 0x30,  0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01,
        
        0x01, 0x05, 0x00 };
    
    if (memcmp(&c_key[idx], seqiod, 15)) return(nil);
    
    idx += 15;
    
    if (c_key[idx++] != 0x03) return(nil);
    
    if (c_key[idx] > 0x80) idx += c_key[idx] - 0x80 + 1;
    
    else idx++;
    
    if (c_key[idx++] != '\0') return(nil);
    
    // Now make a new NSData from this buffer
    
    return ([NSData dataWithBytes:&c_key[idx] length:len - idx]);
    
}
- (BOOL)isEmailFormat
{
    NSString *judgeRole = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,5}";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", judgeRole];
    
    return [predicate evaluateWithObject:self];
}

- (BOOL)isMobilePhoneNumFormat
{
    //  14x[数据卡号段] 17xx[虚拟运营商号段]
    /**
     * 手机号码
     * 移动：134[0-8] 13[5-9] 150 151 152 157 158 159 182 183 184 187 188
     * 联通：130 131 132 155 156 185 186
     * 电信：133 1349[卫通] 153 180 181 189
     */
    //    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0-9]|7[0-9])\\d{8}$";
    NSString *MOBILE = @"^(1[3-9])[\\d]{9}$";//新规则
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8] 13[5-9] 150 151 152 157 158 159 182 183 184 187 188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[0-27-9]|8[2-478])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349[卫通],153,180,181,189
     22         */
    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        if([regextestcm evaluateWithObject:self] == YES) {
            DLog(@"China Mobile");
        } else if([regextestct evaluateWithObject:self] == YES) {
            DLog(@"China Telecom");
        } else if ([regextestcu evaluateWithObject:self] == YES) {
            DLog(@"China Unicom");
        } else {
            DLog(@"Unknow");
        }
        
        return YES;
    }
    
    return NO;
}

- (BOOL)isIDCardFormat
{
    if (self.length <= 0) {
        return NO;
    }
    
    NSString *judgeRole = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", judgeRole];
    
    return [predicate evaluateWithObject:self];
}

- (BOOL)isOnlyNumberFormat
{
    NSString *judgeRole = @"^[0-9]*[1-9][0-9]*$";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", judgeRole];
    
    return [predicate evaluateWithObject:self];
}

- (BOOL)isPasswordWithoutSymbolFormat
{
    NSString *judgeRole = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,16}";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", judgeRole];
    
    return [predicate evaluateWithObject:self];
}

/**
 *  判断是否是纯汉字
 */
- (BOOL)isChinese
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

/**
 *  判断是否含中文以外的字符
 */
- (BOOL)includeOuterChinese
{
    for(int i = 0; i< [self length];i++)
    {
        int a = [self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            
        } else {
            return YES;
        }
    }
    return NO;
}

/**
 *  URLEncode
 */
- (NSString *)URLEncodedString
{
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    //    !*'();:@&=+ $,/?%#[]
    NSString *unencodedString = self;
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

/**
 *  URLDecode
 */
-(NSString *)URLDecodedString
{
    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    
    NSString *encodedString = self;
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}
@end
