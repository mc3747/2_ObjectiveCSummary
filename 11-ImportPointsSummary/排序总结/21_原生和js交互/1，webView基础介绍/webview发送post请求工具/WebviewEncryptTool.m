//
//  WebviewEncryptTool.m
//  排序总结
//
//  Created by gjfax on 2019/3/22.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "WebviewEncryptTool.h"

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <Security/Security.h>

#define kChosenDigestLength CC_SHA1_DIGEST_LENGTH // SHA-1消息摘要的数据位数160位
#define kPrivateKey @"MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCu3I7blvOYt3q3gmBPuUSA2p8STjxW7UTEBInHkq0IcYsjG2egYt/Qa4eJVQDbJVnsLkmG1Wv+6nWULNgFtDVEKr3/hX9XGzmrhi4rpdYnylLUnP/sxXmFpWYlzFlpMjfFVHPvv2qHY9TqMMVM/rGG9zdzDR2NFaZw4m5qHxIyGamXMK2HkqIHVKUp9156uHeiz9gkKQrtiNcaUy5/6Y7IxgA2uAX3A4uottqeiNI8JHu1IMEMvQU/sPidLglfhnRROnqBuJpMfoLrbhQkPK9uWclJT9oN2Rtsrz8lqHGCed6/LGBiqfuCH3BbaPJteJSE3xpi+gGR8y71CoNECSXbAgMBAAECggEAM+1fpypOsL1b/f8Dpuk3xKQntQHyvUW8tBE88T1HkUhWr1hGD8UM/hHQsCHEHVAcQh0EzLu4VH0/6X7fr+HyJ4oh3i3AwRdequcv8tpOnIZizqzI+4ExM1UI3pSuwKSfF0SbIUlQ01/8LIfLL7A6+/+SQeJVMj6JrOAxNeaAOswQZGA/HX4kuOO2e3xJwhYtUAXPHPnGAUqtqKuezJrxrLYpmFHAGEBMRzfI4wo3RVdFM3YZh4IgA2SS1Cwd/ttBHAr1EZ9yzs068AlJqWBsS461uWj/vXKFXggQWLCAYgxN78Zgp1cjQf6DrvrS2W0qsw+IOuGyB3yAa3YqvBCzgQKBgQD97Fzzmjt1uMXEHkaecQdEuHLfCR1STVnaVjVVoPRnF7A56nLPl3Ztmo2NWqDycxdoAYg5wdRmaGdGHfq8qSht7JwQRQFzGD+aZGKuf5DzZnbnD+b2au9hIjCcl6b9fktC1tXlponroC8GqdKK6tKrwBppFtfnpIzybwunTKSaIQKBgQCwSqoCTY60rBo9NkW9j1zCV6FpI8StdQ5n7QIZesgIoHyvqr/1ZK0TAzCxYaUuG/B/6/TACx36jk17jn+/X+4c0QFsJmZUjiN5C5RilTNoUe3dCkHBKt4dhCsn30JJmePXwalRETT+vcuc16yi9mAWRyVorsm4yKq3bvE6soAYewKBgBnF7/lZ4kckpg4t9IUIe/BhuGcjCbLc3w3mSiuS1rvQD7cRMO4ZNZASa+O5GzUAsZOA9E7IecKbPkBDsruLf+sIZR7RokAIagxFvC5yDEhoUhFJ7+t7FykIy15Zlj2MoB78p2FT8hPUgnFus0weYZvFN+kKxIdikFvbIZetk9eBAoGATupNalR/kj8MS+R0maOIWXLSzXb2ftNMjJca/n7o9nuo9RYRce8MTtt5u53DTH2zTgA5ApK3a8axxqKGawutUnb5FQmneyhZlsDpPqwdZBBw0ybZQnhHD51vmByn1rytspJ9kc2LFJGviNk+7YAuiSp2A4Nix3YEfbKLB8SJ9OsCgYA0fex/VF3jzV1/pJnyKQCRmIRJw7zTeBdmlJSTe287tiNi5f4YxMiWY4koOtVfRPvErJ75yrfkOrgf9JXyKKNpnKBXDvwJfjG0X8Sr9DhX81r100ZJ+p1Qk1ZxZqT11D2mTBOWx4rXnlrDc2ifW1aT5IJKM87BWxkejET6Ja3yTQ=="

#define kPublicKey @"你的公钥"

@implementation WebviewEncryptTool

#pragma mark -  获取当前时间戳
+ (NSString *)getCurrentTimeStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYYMMddHHmmss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    //    DLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
}

#pragma mark - 字典转json
+(NSString *)convertToJsonData:(NSDictionary *)dict

{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        //        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
        
    };
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    //去掉字符串中的空格
    NSRange range = {0,jsonString.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    //去掉字符串中的换行符
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    //去掉字符串中的换行符
    NSRange range3 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\r" withString:@"" options:NSLiteralSearch range:range3];
    
    //    //去掉字符串中的换行符
    NSRange range4 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\t" withString:@"" options:NSLiteralSearch range:range4];
    return mutStr;
    
}

#pragma mark - 成功sha1RSA加密
- (NSString *)signSHA1WithRSA:(NSString *)plainText{
    
    uint8_t* signedBytes = NULL;
    
    size_t signedBytesSize = 0;
    
    OSStatus sanityCheck = noErr;
    
    NSData* signedHash = nil;
    
    SecKeyRef privateKeyRef = [self addPrivateKey:kPrivateKey];
    
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
        
    }else{
        
        return nil;
        
    }
    
    if (signedBytes){
        
        free(signedBytes);
        
    }
    
    NSString *signatureResult = [self base64EncodeData:signedHash];
    
    return signatureResult;
    
}

- (NSData *)getHashBytes:(NSData *)plainText {
    
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
    
    // Build up the SHA1 blob.
    
    hash = [NSData dataWithBytes:(const void  *)hashBytes length:(NSUInteger)kChosenDigestLength];
    
    if (hashBytes) free(hashBytes);
    
    return hash;
    
}

- (SecKeyRef)addPrivateKey:(NSString *)key{
    
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
#pragma mark - Base64

- (NSString *)base64EncodeData:(NSData *)data{
    
    data = [data base64EncodedDataWithOptions:0];
    
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return ret;
    
}
- (NSData *)base64DecodeString:(NSString *)string{
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    return data;
    
}
- (NSData *)stripPrivateKeyHeader:(NSData *)d_key{
    
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
@end
