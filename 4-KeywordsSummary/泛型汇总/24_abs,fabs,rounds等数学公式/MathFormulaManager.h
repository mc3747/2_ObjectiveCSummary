//
//  MathFormulaManager.h
//  泛型汇总
//
//  Created by gjfax on 2019/4/21.
//  Copyright © 2019 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 1,isnan
 如果一个数是一个确定的数，那它就不是nan值
 如果一个数是无穷大，无穷小，那它就是nan值
 if (isnan(1)) {
 DLog(@"1是NAN");
 } else {
 DLog(@"1不是NAN");
 }
 
 2,abs
 int abs(int i); // 处理int类型的取绝对值
 
 3,fabs
 double fabs(double i); //处理double类型的取绝对值
 
 4,fabsf
 float fabsf(float i);  /处理float类型的取绝对值
 
 5,ceilf 进位方法
 float numberToRound;
 int result;
 numberToRound = 5.61;
 result = (int)ceilf(numberToRound);
 NSLog(@"ceilf(%.2f) = %d", numberToRound, result);
 //输出 ceilf(5.61) = 6
 
 numberToRound = 5.41;
 result = (int)ceilf(numberToRound);
 NSLog(@"ceilf(%.2f) = %d", numberToRound, result);
 //输出 ceilf(5.41) = 6
 
 6,roundf 四舍五入
 float numberToRound;
 int result;
 numberToRound = 5.61;
 result = (int)roundf(numberToRound);
 NSLog(@"roundf(%.2f) = %d", numberToRound, result);
 //输出 roundf(5.61) = 6
 
 numberToRound = 5.41;
 result = (int)roundf(numberToRound);
 NSLog(@"roundf(%.2f) = %d", numberToRound, result);
 //输出 roundf(5.41) = 5
 
 7,floorf 模位方法
 float numberToRound;
 int result;
 numberToRound = 5.61;
 result = (int)floorf(numberToRound);
 NSLog(@"floorf(%.2f) = %d", numberToRound, result);
 //输出 floorf(5.61) = 5
 
 numberToRound = 5.41;
 result = (int)floorf(numberToRound);
 NSLog(@"floorf(%.2f) = %d", numberToRound, result);
 //输出 floorf(5.41) = 5
 
 
 */
NS_ASSUME_NONNULL_BEGIN

@interface MathFormulaManager : NSObject

@end

NS_ASSUME_NONNULL_END
