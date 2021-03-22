//
//  NSString+QMUI.m
//  qmui
//
//  Created by ZhoonChen on 15/7/20.
//  Copyright (c) 2015年 QMUI Team. All rights reserved.
//

#import "NSString+QMUI.h"
#import <CommonCrypto/CommonDigest.h>
#import <objc/runtime.h>

#define MD5_CHAR_TO_STRING_16 [NSString stringWithFormat:               \
@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",    \
result[0], result[1], result[2], result[3],                             \
result[4], result[5], result[6], result[7],                             \
result[8], result[9], result[10], result[11],                           \
result[12], result[13], result[14], result[15]]                         \

@implementation NSString (QMUI)

- (BOOL)qmui_includesString:(NSString *)string {
    if (!string || string.length <= 0) {
        return NO;
    }
    
    if ([self respondsToSelector:@selector(containsString:)]) {
        return [self containsString:string];
    }
    
    return [self rangeOfString:string].location != NSNotFound;
}

- (NSString *)qmui_trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)qmui_trimAllWhiteSpace {
    return [self stringByReplacingOccurrencesOfString:@"\\s" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, self.length)];
}

- (NSString *)qmui_trimLineBreakCharacter {
    return [self stringByReplacingOccurrencesOfString:@"[\r\n]" withString:@" " options:NSRegularExpressionSearch range:NSMakeRange(0, self.length)];
}

- (NSString *)qmui_md5 {
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return MD5_CHAR_TO_STRING_16;
}

+ (NSString *)hexLetterStringWithInteger:(NSInteger)integer {
    NSAssert(integer < 16, @"要转换的数必须是16进制里的个位数，也即小于16，但你传给我是%@", @(integer));
    
    NSString *letter = nil;
    switch (integer) {
        case 10:
            letter = @"A";
            break;
        case 11:
            letter = @"B";
            break;
        case 12:
            letter = @"C";
            break;
        case 13:
            letter = @"D";
            break;
        case 14:
            letter = @"E";
            break;
        case 15:
            letter = @"F";
            break;
        default:
            letter = [[NSString alloc]initWithFormat:@"%@", @(integer)];
            break;
    }
    return letter;
}

+ (NSString *)qmui_hexStringWithInteger:(NSInteger)integer {
    NSString *hexString = @"";
    NSInteger remainder = 0;
    for (NSInteger i = 0; i < 9; i++) {
        remainder = integer % 16;
        integer = integer / 16;
        NSString *letter = [self hexLetterStringWithInteger:remainder];
        hexString = [letter stringByAppendingString:hexString];
        if (integer == 0) {
            break;
        }
        
    }
    return hexString;
}

+ (NSString *)qmui_stringByConcat:(id)firstArgv, ... {
    if (firstArgv) {
        NSMutableString *result = [[NSMutableString alloc] initWithFormat:@"%@", firstArgv];
        
        va_list argumentList;
        va_start(argumentList, firstArgv);
        id argument;
        while ((argument = va_arg(argumentList, id))) {
            [result appendFormat:@"%@", argument];
        }
        va_end(argumentList);
        
        return [result copy];
    }
    return nil;
}

+ (NSString *)qmui_timeStringWithMinsAndSecsFromSecs:(double)seconds {
    NSUInteger min = floor(seconds / 60);
    NSUInteger sec = floor(seconds - min * 60);
    return [NSString stringWithFormat:@"%02ld:%02ld", (long)min, (long)sec];
}

- (NSString *)qmui_removeMagicalChar {
    if (self.length == 0) {
        return self;
    }
    
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[\u0300-\u036F]" options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length) withTemplate:@""];
    return modifiedString;
}

- (NSUInteger)qmui_lengthWhenCountingNonASCIICharacterAsTwo {
    NSUInteger characterLength = 0;
    char *p = (char *)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (NSInteger i = 0, l = [self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i < l; i++) {
        if (*p) {
            characterLength++;
        }
        p++;
    }
    return characterLength;
}

- (NSUInteger)transformIndexToDefaultModeWithIndex:(NSUInteger)index {
    CGFloat strlength = 0.f;
    NSInteger i = 0;
    for (i = 0; i < self.length; i++) {
        unichar character = [self characterAtIndex:i];
        if (isascii(character)) {
            strlength += 1;
        } else {
            strlength += 2;
        }
        if (strlength >= index + 1) return i;
    }
    return 0;
}

- (NSRange)transformRangeToDefaultModeWithRange:(NSRange)range {
    CGFloat strlength = 0.f;
    NSRange resultRange = NSMakeRange(NSNotFound, 0);
    NSInteger i = 0;
    for (i = 0; i < self.length; i++) {
        unichar character = [self characterAtIndex:i];
        if (isascii(character)) {
            strlength += 1;
        } else {
            strlength += 2;
        }
        if (strlength >= range.location + 1) {
            if (resultRange.location == NSNotFound) {
                resultRange.location = i;
            }
            
            if (range.length > 0 && strlength >= NSMaxRange(range)) {
                resultRange.length = i - resultRange.location + (strlength == NSMaxRange(range) ? 1 : 0);
                return resultRange;
            }
        }
    }
    return resultRange;
}

- (NSString *)qmui_substringAvoidBreakingUpCharacterSequencesFromIndex:(NSUInteger)index lessValue:(BOOL)lessValue countingNonASCIICharacterAsTwo:(BOOL)countingNonASCIICharacterAsTwo {
    index = countingNonASCIICharacterAsTwo ? [self transformIndexToDefaultModeWithIndex:index] : index;
    NSRange range = [self rangeOfComposedCharacterSequenceAtIndex:index];
    return [self substringFromIndex:lessValue ? NSMaxRange(range) : range.location];
}

- (NSString *)qmui_substringAvoidBreakingUpCharacterSequencesFromIndex:(NSUInteger)index {
    return [self qmui_substringAvoidBreakingUpCharacterSequencesFromIndex:index lessValue:YES countingNonASCIICharacterAsTwo:NO];
}

- (NSString *)qmui_substringAvoidBreakingUpCharacterSequencesToIndex:(NSUInteger)index lessValue:(BOOL)lessValue countingNonASCIICharacterAsTwo:(BOOL)countingNonASCIICharacterAsTwo {
    index = countingNonASCIICharacterAsTwo ? [self transformIndexToDefaultModeWithIndex:index] : index;
    NSRange range = [self rangeOfComposedCharacterSequenceAtIndex:index];
    return [self substringToIndex:lessValue ? range.location : NSMaxRange(range)];
}

- (NSString *)qmui_substringAvoidBreakingUpCharacterSequencesToIndex:(NSUInteger)index {
    return [self qmui_substringAvoidBreakingUpCharacterSequencesToIndex:index lessValue:YES countingNonASCIICharacterAsTwo:NO];
}

- (NSString *)qmui_substringAvoidBreakingUpCharacterSequencesWithRange:(NSRange)range lessValue:(BOOL)lessValue countingNonASCIICharacterAsTwo:(BOOL)countingNonASCIICharacterAsTwo {
    range = countingNonASCIICharacterAsTwo ? [self transformRangeToDefaultModeWithRange:range] : range;
    NSRange characterSequencesRange = lessValue ? [self downRoundRangeOfComposedCharacterSequencesForRange:range] : [self rangeOfComposedCharacterSequencesForRange:range];
    NSString *resultString = [self substringWithRange:characterSequencesRange];
    return resultString;
}

- (NSString *)qmui_substringAvoidBreakingUpCharacterSequencesWithRange:(NSRange)range {
    return [self qmui_substringAvoidBreakingUpCharacterSequencesWithRange:range lessValue:YES countingNonASCIICharacterAsTwo:NO];
}

- (NSRange)downRoundRangeOfComposedCharacterSequencesForRange:(NSRange)range {
    if (range.length == 0) {
        return range;
    }
    
    NSRange resultRange = [self rangeOfComposedCharacterSequencesForRange:range];
    if (NSMaxRange(resultRange) > NSMaxRange(range)) {
        return [self downRoundRangeOfComposedCharacterSequencesForRange:NSMakeRange(range.location, range.length - 1)];
    }
    return resultRange;
}

- (NSString *)qmui_stringByRemoveCharacterAtIndex:(NSUInteger)index {
    NSRange rangeForRemove = [self rangeOfComposedCharacterSequenceAtIndex:index];
    NSString *resultString = [self stringByReplacingCharactersInRange:rangeForRemove withString:@""];
    return resultString;
}

- (NSString *)qmui_stringByRemoveLastCharacter {
    return [self qmui_stringByRemoveCharacterAtIndex:self.length - 1];
}
- (CGSize)strSizeWithFont:(CGFloat)sysFontSize maxSize:(CGSize)maxSize
{
    UIFont *sysFont = [UIFont systemFontOfSize:sysFontSize];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary *dict = @{NSFontAttributeName:sysFont, NSParagraphStyleAttributeName:paragraphStyle};
    
    //    NSDictionary *dict = @{NSFontAttributeName : sysFont};
    // 如果将来计算的文字的范围超出了指定的范围,返回的就是指定的范围
    // 如果将来计算的文字的范围小于指定的范围, 返回的就是真实的范围
    CGSize size =  [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    return size;
}

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
    
    if ([srcStr isNullStr]) {
        return @"--";
    }
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

- (NSString *)formatStrWithSignToNumberStr
{
    //  id类型转换成str
    NSString *srcStrNoSign = FMT_STR(@"%@", self);
    
    if ([self isNullStr]) {
        return @"0.0";
    }
    //  在str判断是否有‘,’
    if ([srcStrNoSign rangeOfString:@"," options:NSLiteralSearch].location != NSNotFound) {
        //  如果源数据有千分位或者逗号 去掉千分位
        srcStrNoSign = [self stringByReplacingOccurrencesOfString:@"," withString:@""];
    }
    
    return srcStrNoSign;
}

- (BOOL)isDecimalNumStr
{
    if ([self isNullStr]) {
        return NO;
    }
    
    NSString *strNum = [[NSString alloc] initWithString:self];
    
    if([strNum rangeOfString:@"." options:NSLiteralSearch].location != NSNotFound) {
        return YES;
    } else {
        return NO;
    }
}

- (NSString *)hidePhoneNumStr
{
    if ([self isNullStr]) {
        return @"--";
    }
    
    NSString *tempStr = [NSString stringWithString:self];
    
    if (tempStr.length == 11) {
        //  隐藏中间部分
        NSRange rang = NSMakeRange(3, 4);
        NSString *retStr = [tempStr stringByReplacingCharactersInRange:rang withString:@"****"];
        tempStr = [NSString stringWithString:retStr];
    }
    
    return tempStr;
}

- (NSString *)hideBankCardNumStr
{
    if ([self isNullStr]) {
        return @"--";
    }
    
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

- (BOOL)swzzi_isEqualToString:(NSString *)aString
{
    //  超时返回码
    static NSString * const kTimeOutCode = @"0082";
    //  登陆已过期，请重新登陆
    static NSString * const kLoginExpiredError = @"201010";
    //错误码 兼容、新老超时错误码
    if (([self swzzi_isEqualToString:kTimeOutCode] && [aString swzzi_isEqualToString:kLoginExpiredError])
        || ([aString swzzi_isEqualToString:kTimeOutCode] && [self swzzi_isEqualToString:kLoginExpiredError])) {
        return YES;
    }
    return [self swzzi_isEqualToString:aString];
}

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL method1Sel =  @selector(isEqualToString:);
        SEL method2Sel =  @selector(swzzi_isEqualToString:);
        
        Method originalMethod = class_getInstanceMethod(self, method1Sel);
        Method swizzledMethod = class_getInstanceMethod(self, method2Sel);
        
        BOOL didAddMethod =
        class_addMethod(self,
                        method1Sel,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(self,
                                method2Sel,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        }
        
        else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
    });
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
@end

@implementation NSString (QMUI_StringFormat)

+ (instancetype)qmui_stringWithNSInteger:(NSInteger)integerValue {
    return [NSString stringWithFormat:@"%@", @(integerValue)];
}

+ (instancetype)qmui_stringWithCGFloat:(CGFloat)floatValue {
    return [NSString qmui_stringWithCGFloat:floatValue decimal:2];
}

+ (instancetype)qmui_stringWithCGFloat:(CGFloat)floatValue decimal:(NSUInteger)decimal {
    NSString *formatString = [NSString stringWithFormat:@"%%.%@f", @(decimal)];
    return [NSString stringWithFormat:formatString, floatValue];
}

@end
