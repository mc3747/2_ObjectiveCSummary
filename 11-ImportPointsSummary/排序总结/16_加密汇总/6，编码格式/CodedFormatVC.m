//
//  CodedFormatVC.m
//  排序总结
//
//  Created by gjfax on 2019/1/25.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "CodedFormatVC.h"
#import "GBEncodeTool.h"

@interface CodedFormatVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView1;
@property (weak, nonatomic) IBOutlet UITextView *textView2;
@property (weak, nonatomic) IBOutlet UITextView *textView3;
@property (weak, nonatomic) IBOutlet UITextView *textView4;
@property (weak, nonatomic) IBOutlet UITextView *textView5;
@property (weak, nonatomic) IBOutlet UITextView *textView6;

@end

@implementation CodedFormatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _textField.delegate = self;
}

#pragma mark -  textfield代理
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;{
    
    NSString *displayText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (displayText.length > 0) {
        _textView1.text = [self unicodeStringWithString:displayText];
        _textView2.text = [self stringToUTF8:displayText];
        _textView3.text = [self stringToGBK:displayText];
        _textView4.text = [self stringToGB2312:displayText];
        _textView5.text = [self charToASCII:displayText];
        _textView6.text = [GBEncodeTool encodeBase64String:displayText];
        
    }else {
        _textView1.text = @"";
        _textView2.text = @"";
        _textView3.text = @"";
        _textView4.text = @"";
        _textView5.text = @"";
        _textView6.text = @"";
    }
    
    NSString *str2 =@"\u5982\u4f55\u8054\u7cfb\u5ba2\u670d\u4eba\u5458\uff1f";
    NSString *testString2 = [self uTF8ToString:str2];
    
    NSString *str3 = @"%E5%A6%82%E4%BD%95%E8%81%94%E7%B3%BB%E5%AE%A2%E6%9C%8D%E4%BA%BA%E5%91%98%EF%BC%9F";
    NSString *testString3 = [self uTF8ToString:str3];
    
    NSString *str4 = @"如何联系客服人员？";
    NSString *testString4 = [self stringToUTF8:str4];
    
    NSString *str5 = @"如何联系客服人员？";
    NSString *testString5 = [self unicodeStringWithString:str5];
    
    NSString *str2Test = [self unicodeToUtf8:testString5];
    NSString *str3Test = [self utf8ToUnicode:testString4];
    
    return YES;
    
}

#pragma mark -  ASCII
/*
 英语字符与二进制位之间的关系，做了统一规定。这被称为ASCII码
 ASCII码一共规定了128个字符的编码
 */

#pragma mark -  Unicode
/*
 Unicode只是一个符号集，它只规定了符号的二进制代码，却没有规定这个二进制代码应该如何存储
 */

#pragma mark -  UTF-8
/*
 UTF－8编码则是用以解决国际上字符的一种多字节编码，
 它对英文使用8位（即一个字节），中文使用24位（三个字节）来编码
 UTF-8是Unicode的实现方式之一
 UTF-8最大的一个特点，就是它是一种变长的编码方式。它可以使用1~4个字节表示一个符号，根据不同的符号而变化字节长度
 */

#pragma mark -  GB2312

#pragma mark -  GBK
/*
 包含全部中文字符
 */




#pragma mark -  string转Unicode
- (NSString *)unicodeStringWithString:(NSString *)string {
    NSString *result = [NSString string];
    for (int i = 0; i < [string length]; i++) {
        result = [result stringByAppendingFormat:@"\\u%04x", [string characterAtIndex:i]];
        /*
         因为Unicode用16个二进制位（即4个十六进制位）表示字符，对于小于0x1000字符要用0填充空位，
         所以使用%04x这个转换符，使得输出的十六进制占4位并用0来填充开头的空位。
         */
    }
    return result;
}

#pragma mark -  Unicode转string
- (NSString *)stringWithUnicodeString:(NSString *)string {
    NSArray *strArray = [[string substringFromIndex:2] componentsSeparatedByString:@"\\u"];
    NSString *result = [NSString string];
    for (NSString *str in strArray) {
        NSString *tmpStr = [@"0x" stringByAppendingString:str];
        unichar c = strtoul([tmpStr UTF8String], 0, 0);
        /*
         上面两行也可以写成下面一行：
         unichar c = strtoul([str UTF8String], 0, 16);
         */
        result = [result stringByAppendingString:[NSString stringWithCharacters:&c length:1]];
    }
    return result;
}

#pragma mark -  string转UIF-8
- (NSString *)stringToUTF8:(NSString *)string {
    
    NSString*transString = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    //    以下两种方法被上边的方法取代了
    /*
     NSString *transString2 = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     
     NSString * transString3 = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)string, NULL, NULL,  kCFStringEncodingUTF8 ));
     */
   
    
    return transString;
}

#pragma mark -  UIF-8转string
- (NSString *)uTF8ToString:(NSString *)string {
   
    NSString *unicodeStr = string.stringByRemovingPercentEncoding;
     //    以下两种方法被上边的方法取代了
    /*
      NSString *unicodeStr1 = [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     */
    return unicodeStr;
}

#pragma mark -  UTF-8转UniCode
- (NSString *)utf8ToUnicode:(NSString *)string
{
    NSUInteger length = [string length];
    NSMutableString *s = [NSMutableString stringWithCapacity:0];
    for (int i = 0;i < length; i++)
    {
        unichar _char = [string characterAtIndex:i];
        //判断是否为英文和数字
        if (_char <= '9' && _char >= '0')
        {
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i, 1)]];
        }
        else if(_char >= 'a' && _char <= 'z')
        {
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i, 1)]];
        }
        else if(_char >= 'A' && _char <= 'Z')
        {
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i, 1)]];
        }
        else
        {
            [s appendFormat:@"\\u%x",[string characterAtIndex:i]];
        }
    }
    return s;
}

#pragma mark -  Unicode转UTF-8
- (NSString*)unicodeToUtf8:(NSString *)aUnicodeString

{
    NSString *tempStr1 = [aUnicodeString  stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString* returnStr1 = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    
    NSString* returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
    
}

#pragma mark -  string转GBK
- (NSString *)stringToGBK:(NSString *)string{
    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    NSString *gbkString = [string stringByAddingPercentEscapesUsingEncoding:gbkEncoding];//转字符串
    return gbkString;
}

#pragma mark -  string转GB2312
- (NSString *)stringToGB2312:(NSString *)string{
    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    NSString *gb2312String = [string stringByAddingPercentEscapesUsingEncoding:gbkEncoding];//转字符串
    return gb2312String;
}

#pragma mark -  char转ASCII
- (NSString *)charToASCII:(NSString *)character {
    NSMutableString *ASCIIString = [[NSMutableString alloc] initWithCapacity:1];
     NSRange range = NSMakeRange(0, character.length);
    [character enumerateSubstringsInRange:range options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        
        NSString *charString = [NSString stringWithFormat:@"%i➕",[substring characterAtIndex:0]];
        [ASCIIString appendString:charString];
        
    }];
    return ASCIIString;
}

#pragma mark -  ASCII转char
- (NSString *)ASCIIToChar:(int)intValue {
    return [NSString stringWithFormat:@"%c",intValue];
}

#pragma mark -  触摸事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_textField resignFirstResponder];
}
@end
