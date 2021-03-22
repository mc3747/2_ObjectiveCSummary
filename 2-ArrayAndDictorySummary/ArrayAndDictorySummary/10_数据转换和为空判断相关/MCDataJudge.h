//
//  MCDataJudge.h
//  数据非空判断&数据转换
//
//  Created by gjfax on 2018/4/8.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCDataJudge : NSObject

/*1，判断对象是否为空 */
+ (BOOL)judgeObjectNil:(id)object;

/*2，判断对象是否为非空字符串 */
+ (BOOL)judgeStringNil:(id)object;

/*3，判断对象是否为非空数组 */
+ (BOOL)judgeArrayNilWithObject:(id )object;

/*4，判断对象是否为非空字典 */
+ (BOOL)judgeDicNilWithObject:(id )object;

/*5，判断对象是否为非空NSNumber */
+ (BOOL)judgeNSNumberNilWithObject:(id )object;

/*6，判断对象是否为非空NSValue */
+ (BOOL)judgeNSValueNilWithObject:(id )object;

/*7，判断对象是否为非空NSData */
+ (BOOL)judgeNSDataNilWithObject:(id )object;

@end
