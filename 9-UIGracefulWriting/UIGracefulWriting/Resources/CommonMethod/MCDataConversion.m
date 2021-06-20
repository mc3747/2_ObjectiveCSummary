//
//  MCDataConversion.m
//  数据非空判断&数据转换
//
//  Created by gjfax on 2018/4/8.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "MCDataConversion.h"

@implementation MCDataConversion
 /*---------------------------------基本数据之间转换--------------------------------- */
#pragma mark -  int转float
+ (float)intToFloat:(int)i {
    
    //自动强转
//    return (float)i;
    
    //手动强转
    return i * 1.f;
}

#pragma mark -  float转int，强制丢失小数部分
+ (int)floatToInt:(float)f{
    return (int)f;
}

#pragma mark -  float转int，强制四舍五入
+ (int)floatToIntForHalfAdjust:(float)f{
    return (int)(f + 0.5);
}

 /*---------------------------------NSString与基础数据之间转换--------------------------------- */
#pragma mark -  NSString转doubl
+ (double)stringToDouble:(NSString *)s {
    return [s doubleValue];
}
#pragma mark -  double转NSString
+ (NSString *)doubleToString:(double)d {
    return [NSString stringWithFormat: @"%.4f" ,d];
}
#pragma mark -  string转basic
+ (void)testStringToBasic {
    NSString *teststring = @"32.54" ;
    int i0 = [teststring intValue ];
    float i1 = [teststring floatValue ];
    double i2 = [teststring doubleValue ];
    NSInteger i3 = [teststring integerValue ];
    
    NSLog(@"intValue: = %d",i0);
    NSLog(@"floatValue: = %f",i1);
    NSLog(@"doubleValue: = %f",i2);
    NSLog(@"integerValue: = %li",(long)i3);
}
#pragma mark -  basic转string
+ (void)testBasicToString {
    NSString *teststring = @"32.54" ;
    int i0 = [teststring intValue ];
    float i1 = [teststring floatValue ];
    double i2 = [teststring doubleValue ];
    NSInteger i3 = [teststring integerValue ];
    
    NSString *tostring = nil ;
    tostring = [ NSString stringWithFormat: @"%d" ,i0];
    NSLog ( @"tostring-int:%@",tostring);
    tostring = [ NSString stringWithFormat: @"%.3f" ,i1];
    NSLog ( @"tostring-float:%@",tostring);
    tostring = [ NSString stringWithFormat: @"%e" ,i2];
    NSLog ( @"tostring-double:%@",tostring);
    tostring = [ NSString stringWithFormat: @"%ld" ,(long)i3];
    NSLog ( @"tostring-integerValue:%@",tostring);
}
 /*---------------------------------NSNumber与基础数据,NSString之间转换--------------------------------- */
#pragma mark -  double转NSNumber
+ (NSNumber *)numberToDouble:(double)d {
    return [NSNumber numberWithDouble:d];
}
#pragma mark -  NSNumber转double
+ (double)doubleToNumber:(NSNumber *)n {
    return [n doubleValue];
}
#pragma mark -  NSNumber转string
+ (NSString *)numberToString:(NSNumber *)n {
    return [n stringValue];
}
#pragma mark -  string转NSNumber
+ (NSNumber *)stringToNumber:(NSString *)s {
    
    /*首先取出string全部为数字 */
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    id result=[f numberFromString:s];
    
    if (result){
        /*如果全部是数字，则result返回该数据类型，此处为double */
        /*string 转double，再将double转NSNumber */
        return [NSNumber numberWithDouble:[s doubleValue]];
        
    }else{
        /*如果不全为数字，则result返回nil */
        return nil;
    };
   
}
#pragma mark -  NSNumber转Basic
+ (void)testNSNumberToBasic {
    int i0 = 32;
    float i1 = 32.1;
    double i2 = 32.22;
    NSInteger i3 = 32;
    NSNumber *i0Number = [NSNumber numberWithInt:i0];
    NSNumber *i1Number = [NSNumber numberWithFloat:i1];
    NSNumber *i2Number = [NSNumber numberWithDouble:i2];
    NSNumber *i3Number = [NSNumber numberWithInteger:i3];
    int ioInt = [i0Number intValue];
    float i1Float = [i1Number floatValue];
    double i2Double = [i2Number doubleValue];
    NSInteger i3Integer = [i3Number integerValue];
    NSLog(@"i0Number%d",ioInt);
    NSLog(@"i1Number%f",i1Float);
    NSLog(@"i2Number%f",i2Double);
    NSLog(@"i3Number%ld",(long)i3Integer);
}
#pragma mark -  Basic转NSNumber
+ (void)testBasicToNSNumber {
    int i0 = 32;
    float i1 = 32.1;
    double i2 = 32.22;
    NSInteger i3 = 32;
    
    NSNumber *i0Number = [NSNumber numberWithInt:i0];
    NSNumber *i1Number = [NSNumber numberWithFloat:i1];
    NSNumber *i2Number = [NSNumber numberWithDouble:i2];
    NSNumber *i3Number = [NSNumber numberWithInteger:i3];
    
    NSLog(@"i0Number%@",i0Number);
    NSLog(@"i1Number%@",i1Number);
    NSLog(@"i2Number%@",i2Number);
    NSLog(@"i3Number%@",i3Number);
}
#pragma mark -  NSNumber转NSString
+ (void)testNSNumberToString {
    NSNumber *number = [NSNumber numberWithFloat:3.111];
    
    NSString *numberString = [number stringValue];
    
    NSLog(@"%@",numberString);
}
#pragma mark -  NSString转NSNumber
+ (void)testStringToNSNumber {
    NSString *string = @"3.2222";
    /*首先取出string全部为数字 */
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    id result=[f numberFromString:string];
    
    if (result)
    {
        /*如果全部是数字，则result返回该数据类型，此处为double */
        /*string 转double，再将double转NSNumber */
        result=[NSNumber numberWithDouble:[string doubleValue]];
    }else
    {
        /*如果不全为数字，则result返回nil */
        result = string;
    }
    
    NSLog(@"%.2f",[result doubleValue]);
}


#pragma mark -  NSValue的转换：

+ (void)testValueToRect {
   
}
+ (void)testRectToValue {
    
}
+ (void)testValueToDefinedRect {
    
}
+ (void)testDefinedRectToValue {
    
}

#pragma mark - NSData的转换：
//string
+ (void)testDataWithString {
    /*字符串转NSData */
    NSData *xmlData = [@"testDataWithString" dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"length=%lu,bytes = %d",(unsigned long)xmlData.length, (int)xmlData.bytes);
    
    /*NSData转字符串 */
    NSString *dataString =  [[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",dataString);
    
}
//bytes
+ (void)testDataWithBytes {
    //NSData --> Byte（就是unsigned char）
    
    NSString *testString = @"1234567890";
    
    NSData *testData = [testString dataUsingEncoding: NSUTF8StringEncoding];
    
    Byte *testByte = (Byte *)[testData bytes];
    NSLog(@"testData=%@；testByte=%s",testData,testByte);
    
    //Byte --> NSData
    
    Byte byte[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23};
    
    NSData *adata = [[NSData alloc] initWithBytes:byte length:24];
    
    NSLog(@"byte=%s；adata=%@",byte,adata);
}

/*
 本地图片： 图片名称：--》存储路径 --》NSData
 
 网路图片： 图片路径：--》URL --》NSData
 */
+ (void)testDataWithImage {
    
    //从本地文件沙盒中取图片并转换为NSData
    UIImage *image = [UIImage imageNamed:@"setting_tip_image_blue"];
    
    
    // UIImage－> NSData
    
    NSData *newImageData = UIImagePNGRepresentation(image);
    
    //NSData --> UIImage
    
    UIImage *newImage = [UIImage imageWithData: newImageData];
    
}
//array
+ (void)testDataWithArray {
    
}
//dic
+ (void)testDataWithDic {
    
}
@end
