//
//  HashEncryptVC.m
//  排序总结
//
//  Created by gjfax on 2019/1/22.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "HashEncryptVC.h"
#import "NSString+Hash.h"
#import <CommonCrypto/CommonDigest.h>

@interface HashEncryptVC ()
@property (weak, nonatomic) IBOutlet UITextView *textView1;
@property (weak, nonatomic) IBOutlet UITextView *textView2;

@end

@implementation HashEncryptVC
/*
 苹果包装了MD5加密的方法:
 +(NSString *)MD5ForLower32Bate:(NSString *)str;
 // 32位大写
 +(NSString *)MD5ForUpper32Bate:(NSString *)str;
 // 16为大写
 +(NSString *)MD5ForUpper16Bate:(NSString *)str;
 // 16位小写
 +(NSString *)MD5ForLower16Bate:(NSString *)str;
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)encryptAction:(id)sender {
    NSString *text1 = [self upperMD5:_textView1.text];
    NSString *text2 = [self md5String:_textView1.text];
    NSString *text3 = [self lowerMD5:_textView1.text];
    NSLog(@"✅text1:%@",text1);
    NSLog(@"✅text2:%@",text2);
    NSLog(@"✅text3:%@",text3);
    _textView2.text = text1;
}

#pragma mark -  1，MD5大写
- (NSString *)upperMD5:(NSString *)inPutText
{
    //传入参数,转化成char
    const char *cStr = [inPutText UTF8String];
    //开辟一个16字节的空间
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    /*
     extern unsigned char * CC_MD5(const void *data, CC_LONG len, unsigned char *md)官方封装好的加密方法
     把str字符串转换成了32位的16进制数列（这个过程不可逆转） 存储到了md这个空间中
     */
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] uppercaseString];  //大小写注意
}

#pragma mark -  2，MD5小写
- (NSString *)lowerMD5:(NSString *)inPutText
{
    //传入参数,转化成char
    const char *cStr = [inPutText UTF8String];
    //开辟一个16字节的空间
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    /*
     extern unsigned char * CC_MD5(const void *data, CC_LONG len, unsigned char *md)官方封装好的加密方法
     把str字符串转换成了32位的16进制数列（这个过程不可逆转） 存储到了md这个空间中
     */
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];  //大小写注意
}


#pragma mark -  方法2
- (NSString *)md5String:(NSString *)string {
    const char *str = string.UTF8String;
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), buffer);
    NSMutableString *md5String = [NSMutableString string];
    for (int i = 0; i< CC_MD5_DIGEST_LENGTH; i++) {
        [md5String appendFormat:@"%02x",buffer[i]];
    }
    return md5String;
}

#pragma mark -  md5逆向破解（数据库对比）：http://www.cmd5.com/
#pragma mark -  多次md5，有规律，依然可以破解
#pragma mark -  加盐：固定盐，随机盐
#pragma mark -  先加盐再md5：
#pragma mark -  先md5再加盐
#pragma mark -  盐是后台返回给前端（注册成功后，后台返回一个盐值，本地保存；更换手机后，后台先查看注册账号是否存在，存在的话，将盐值发给前端）

#pragma mark -  HMAC加密：校验和仿篡改
/*
 HMAC使用方式 :（登陆注册密码加密）
 - 注册时,向服务器索取密钥(key)，服务器将密钥和用户的账户对应起来保存在数据库。
 - 客户端拿到key后保存在本地（钥匙串保存，登陆的时候需要用到这个key进行加密）
 - 切换了新的设备(换手机登录或者登录新的已有账号)
 重新找服务器获取key，服务器根据账号给(比如qq,第一次登陆会比较慢，因为不仅要获取key,还要获取聊天信息)
 eg: 用户在A设备登陆成功后，再去B设备登陆，B从本地找key找不到，就会找服务器要（如果有密码锁就等待授权，如果没有密码锁，就直接获取），服务器会根据A设备（授权）决定给不给（密码锁，也是根据这个key）
 
 */

#pragma mark -  时间戳密码+HMAC（动态密码U盾，手机令牌）
// 时间戳密码:动态密码! U盾/将军令/手机令牌 密码一致在改变!
/*
 思路：
 - 客户端注册时输入账号和原始密码，服务器会返回一个key给客户端
 - 服务器将账号，key,以及hmac后的密码(EncryptPass)保存在数据库
 - 客户端拿到key后，会将原始密码结合key进行一次hmac运算，生成一个加密后的密码(EncryptPass),加密后的密码再结合当前时间（这个时间要从服务器获取）再做一次md5，生成新的加密密码（finalPass）
 - 客户端结合时间生产密码后，会发送请求和服务器上的密码作比较（服务器会用EncryptPass结合服务器当前时间，或者当前时间前一分钟，生产服务器的finalPass,如果这两个时间相同，就登陆成功）
 - 这样根据时间来做，就算暴力破解或者模拟登陆，已经过了时效了，密码早已经变了。
 
 
 加密：
 1、先对key进行一次MD5,把key值弄得足够复杂。
 2、用MD5后的key对密码进行hmac
 3、取得当前的系统时间，并且指定时区。真机通常需要指定时区
 4、用密码加格式化后的时间
 5、得出结果后再次hmac并返回
 
 解密：
 用户注册的时候是用密码.hmac，存储到数据库中。
 登录的时候根据上面的完整算法，把加密后的密码发送到服务器。
 服务器端从数据库中根据用户名拿到密码，跟客户端用同样的算法再加密一遍。
 注意：终端用的时间要从服务器端获取，确保用的和服务器端是用的同一个时间。时间精确到分，服务器端验证时要减1，这样密码的有效期不到两分钟。
 
 潜在风险：用户第一次注册密码时被拦截，虽然被拦截的几率小。
   辅助手段：ip绑定！电话绑定。。。

 */

- (void)demo6{
    
    // 原始密码:
    NSString *password = @"zhang";
    
    // hmacKey
    NSString *hmacKey = @"8a627a4578ace384017c997f12d68b23";
    
    // 获得当前时间:
    NSDate *date = [NSDate date];
    NSLog(@"%@",date);
    
    // 设定当前时间的格式
    NSDateFormatter *fommatter = [[NSDateFormatter alloc] init];
    [fommatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    
    // 获得当前时间的字符串
    NSString *time = [fommatter stringFromDate:date];
    NSLog(@"当前时间time:%@",time);
    
    // 第一次 hmac 运算(原始密码 + hmacKey)
    password = [password hmacMD5StringWithKey:hmacKey];
    
    // 拼接字符串(第一次 hmac 运算之后的结果 + 当前时间)
    password = [password stringByAppendingString:time];
    
    
    // 第二次 hmac 运算(之前拼接后的字符串 + hmacKey) 得到的密码就是动态密码了!
    password = [password hmacMD5StringWithKey:hmacKey];
    NSLog(@"动态密码: %@",password);
    
}



// hmac 加密算法,目前在国内渐渐流行!

-(void)demo5{
    
    // 因为要在 Block 中修改这个值! 所以 添加 __block
    
    __block NSString *password = @"hello";
    
    
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/httpLogin/hmackey.php"];
    
    
    
    // 发送网络请求
    
[[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        
        //          NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        
        
        // JSON --> OC
        
        
        
NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        
        
        
        NSString *hmacKey = dict[@"hmacKey"];
        
        
        
        NSLog(@"hmacKey: %@",hmacKey);
        
        
        
// 用从服务器得到的 hmacKey 对密码进行 hmac 运算.
        
        
        
        password = [password hmacMD5StringWithKey:hmacKey];
        
        
        
        NSLog(@"%@",password);
        
        
        
    }] resume];
    
}



// MD5加密：现在一般用作身份验证/校验!

-(void)demo4{
    
    NSString *str = @"hello";
    // 对字符串进行 MD5 加密/运算
    // 如果用作加密/ 服务器和客户端采用相同的加密算法计算!
    
    str = str.md5String;
    NSLog(@"str: %@",str);
    NSString *strM = @"helloh";
    strM = strM.md5String;
    NSLog(@"strM:%@",strM);
    
    // 市面上所谓的解密,其实不是反向解密!是在数据库中查询记录!
    NSString *str1 = @"heshiqiufengbeihuashan521";
    str1 = str1.md5String;
    NSLog(@"%@",str1);
    
    
    // MD5 加密,针对简单的密码,可以通过一些网站查出来!  //http://www.cmd5.com
    // 人为的增加密码难度!    MD5 加盐(盐加的多一点)
    
    // (用户密码 + 盐值) MD5 运算!
    
    
    NSString *password = @"123456";
    
    
    
    // 盐值 (服务器和客户端的盐值是一样的就OK) 越咸(长/复杂)越好
    
    
    NSString *salt = @"!@#$%^&*()_wertyuiop[1234567890-=";
    
    
    
    // 给密码添加盐值
    
    password = [password stringByAppendingString:salt];
    
    // MD5 运算
    
    password = password.md5String;
    
    // md5 加盐,是一种比较高级的加密算法!
    
    
    
    NSLog(@"%@",password);
    
}



// base64 解密

-(void)demo3{
    
     // 1.拿到加密之后的base64二进制数据
    
     NSData *base64Data = [NSData dataWithContentsOfFile:@"/Users/liaojianguo/zlf/私密图片"];
    
    
    
     // 将 base64加密之后的二进制数据,转换成普通的二进制数据
    
     NSData *data = [[NSData alloc] initWithBase64EncodedData:base64Data options:0];
    
    
    
[data writeToFile:@"/Users/liaojianguo/zlf/解密之后的图片" atomically:YES];
    

    
     // base64 缺点: 1.加密之后的数据中有 = 号!很容易解密!
    
     // 2.容易解密! 加密之后的数据,比原来的数据变大((8-6)/6) 1/3!
    
}



// base64 加密文件

-(void)demo2{
    // 1.需要得到文件的二进制数据!
    
 NSData *data = [NSData dataWithContentsOfFile:@"/Users/liaojianguo/zlf/images/png image/apple.png"];
    
    
 // 2.将得到的文件二进制数据,进行base64加密
    
 NSData *base64Data = [data base64EncodedDataWithOptions:0];
    

    
// 3.将加密之后的数据,存储
    
 [base64Data writeToFile:@"/Users/liaojianguo/zlf/私密图片" atomically:YES];
    
}



// base64 加密字符串!

-(void)demo1{
    
 // 普通的  8bit 二进制数据!
    
 NSString *str = @"hello world";
    
NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
 
    
// 将字符串进行 base64 加密
    

// base64加密之后的二进制数据
    
NSData *base64Data = [data base64EncodedDataWithOptions:0];
 // base64加密之后的字符串
    
NSString *base64String = [data base64EncodedStringWithOptions:0];

    
     NSLog(@"data : %@",data);
    
    NSLog(@"base64Data : %@",base64Data);
    
    NSLog(@"base64String : %@",base64String);
    
    
    
}


@end
