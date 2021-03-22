//
//  MCDataNull.m
//  数据非空判断&数据转换
//
//  Created by gjfax on 2018/4/8.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "MCDataNull.h"

@implementation MCDataNull
#pragma mark - NULL
/*NULL 是任意的 C 指针空值,也或者是基本数据类型为空
 null-> null pointer to primitive type or absence of data.
 */
+ (void)testNULL {
    int *pointerInt = NULL;
    int *pointerToInt = NULL;
    char *pointerToChar = NULL;
    
    int intTest = NULL;
    char charTest = NULL;
    
}


#pragma mark - nil
/*nil 是给一个对象赋值为空,对应 id 类型的对象,或用@interface 声明的 ObjC 对象
 Nil -> Null-pointer to objective - c object
 */
+ (void)nilTest {
    NSURL *url = nil;
    NSString *someString = nil;
    NSURL *someURL = nil;
    id anyObjC = nil;
}


#pragma mark - Nil
/*Nil 是 ObjC 类 类型的书面空值，对应 Class 类型对象
 Nil -> Null-pointer to objective - c class
 */
+ (void)testNil {
    Class  class = Nil;
    Class anotherClass = [NSString class];
    
}

#pragma mark - NSNull
/*NSNull 是一个代表空值的类，是一个 ObjC 对象。 一般用于表示集合中值为空的对象。
 它只有一个单例方法：+[NSNull null];
 
 */
+ (void)testNSNull {
    // 因为 nil 被用来作为集合结束的标志，所以 nil 不能存储在 Foundation 集合里。
    NSArray *array = [NSArray arrayWithObjects:@"one", @"two", nil];
    
    // 错误的使用
    //    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //    [dict setObject:nil forKey:@"someKey"];
    
    // 正确的使用
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNull null] forKey:@"someKey"];
    
    
}
@end
