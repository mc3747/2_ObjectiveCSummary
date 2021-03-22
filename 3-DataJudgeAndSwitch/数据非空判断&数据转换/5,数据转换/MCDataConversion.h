//
//  MCDataConversion.h
//  数据非空判断&数据转换
//
//  Created by gjfax on 2018/4/8.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface MCDataConversion : NSObject

#pragma mark -  基本数据转换
    /*int转float */
+ (float)intToFloat:(int)i;
    /*float转int，强制丢失小数部分 */
+ (int)floatToInt:(float)f;
    /*float转int，强制四舍五入 */
+ (int)floatToIntForHalfAdjust:(float)f;

#pragma mark -  NSString转换
+ (double)stringToDouble:(NSString *)s;
+ (NSString *)doubleToString:(double)d;
+ (void)testStringToBasic;
+ (void)testBasicToString;

#pragma mark -  NSNumber转换
+ (NSNumber *)numberToDouble:(double)d;
+ (double)doubleToNumber:(NSNumber *)n;
+ (NSString *)numberToString:(NSNumber *)n;
+ (NSNumber *)stringToNumber:(NSString *)s;
+ (void)testNSNumberToBasic;
+ (void)testBasicToNSNumber;
+ (void)testNSNumberToString;
+ (void)testStringToNSNumber;

#pragma mark -  NSValue转换
+ (void)testValueToRect;
+ (void)testRectToValue;
+ (void)testValueToDefinedRect;
+ (void)testDefinedRectToValue;

#pragma mark -  NSData的相互转换
+ (void)testDataWithBytes;
+ (void)testDataWithString;
+ (void)testDataWithImage;
+ (void)testDataWithArray;
+ (void)testDataWithDic;


@end
