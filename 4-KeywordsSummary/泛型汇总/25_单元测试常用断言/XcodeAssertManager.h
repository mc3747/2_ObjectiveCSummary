//
//  XcodeAssertManager.h
//  泛型汇总
//
//  Created by gjfax on 2019/4/30.
//  Copyright © 2019 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 XCTFail(...)
 任何尝试都会测试失败，...是输出的提示文字。（后面都是这样）
 
 XCTAssertNil(expression, ...)
 expression为空时通过，否则测试失败。
 expression接受id类型的参数。
 
 XCTAssertNotNil(expression, ...)
 expression不为空时通过，否则测试失败。
 expression接受id类型的参数。
 
 XCTAssert(expression, ...)
 expression为true时通过，否则测试失败。
 expression接受boolean类型的参数。
 
 XCTAssertTrue(expression, ...)
 expression为true时通过，否则测试失败。
 expression接受boolean类型的参数。
 
 XCTAssertFalse(expression, ...)
 expression为false时通过，否则测试失败。
 expression接受boolean类型的参数。
 
 XCTAssertEqualObjects(expression1, expression2, ...)
 expression1和expression1地址相同时通过，否则测试失败。
 expression接受id类型的参数。
 
 XCTAssertNotEqualObjects(expression1, expression2, ...)
 expression1和expression1地址不相同时通过，否则测试失败。
 expression接受id类型的参数。
 
 XCTAssertEqual(expression1, expression2, ...)
 expression1和expression1相等时通过，否则测试失败。
 expression接受基本类型的参数（数值、结构体之类的）。
 
 XCTAssertNotEqual(expression1, expression2, ...)
 expression1和expression1不相等时通过，否则测试失败。
 expression接受基本类型的参数。
 
 XCTAssertEqualWithAccuracy(expression1, expression2, accuracy, ...)
 expression1和expression2之间的任何值都大于accuracy时，测试失败。
 expression1、expression2、accuracy都为基本类型。
 
 XCTAssertNotEqualWithAccuracy(expression1, expression2, accuracy, ...)
 expression1和expression2之间的任何值都小于等于accuracy时，测试失败。
 expression1、expression2、accuracy都为基本类型。
 
 XCTAssertGreaterThan(expression1, expression2, ...)
 expression1 <= expression2时，测试失败。
 expression为基本类型
 
 XCTAssertGreaterThanOrEqual(expression1, expression2, ...)
 expression1 < expression2时，测试失败。
 expression为基本类型
 
 XCTAssertLessThan(expression1, expression2, ...)
 expression1 >= expression2时，测试失败。
 expression为基本类型
 
 XCTAssertLessThanOrEqual(expression1, expression2, ...)
 expression1 > expression2时，测试失败。
 expression为基本类型
 
 XCTAssertThrows(expression, ...)
 expression没抛异常，测试失败。
 expression为一个表达式
 
 XCTAssertThrowsSpecific(expression, exception_class, ...)
 expression没抛指定类的异常，测试失败。
 expression为一个表达式
 exception_class为一个指定类
 
 XCTAssertThrowsSpecificNamed(expression, exception_class, exception_name, ...)
 expression没抛指定类、指定名字的异常，测试失败。
 expression为一个表达式
 exception_class为一个指定类
 exception_name为一个指定名字
 
 XCTAssertNoThrow(expression, ...)
 expression抛出异常时，测试失败。
 expression为一个表达式
 
 XCTAssertNoThrowSpecific(expression, exception_class, ...)
 expression抛出指定类的异常，测试失败。
 expression为一个表达式
 
 XCTAssertNoThrowSpecificNamed(expression, exception_class, exception_name, ...)
 expression抛出指定类、指定名字的异常，测试失败。
 expression为一个表达式
 exception_class为一个指定类
 exception_name为一个指定名字
 */
NS_ASSUME_NONNULL_BEGIN

@interface XcodeAssertManager : NSObject

@end

NS_ASSUME_NONNULL_END
