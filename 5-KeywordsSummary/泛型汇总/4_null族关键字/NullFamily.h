//
//  NullFamily.h
//  泛型汇总
//
//  Created by gjfax on 2018/6/5.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NullFamily : NSObject

#pragma mark -  1,nullable：可为空
/*
 1，写法：属性和方法是可以为空
 2，只能修饰对象，不能修饰基本类型
    这样写会报错:@property (nonatomic, assign,nullable) int number;
 3，属性有3种写法，方法只有2种写法
 */
// 属性方式一:
@property (nonatomic, strong, nullable) NSString *nullableName;

// 属性方式二:放在*号之后
@property (nonatomic, strong) NSString * _Nullable _NullableName;

// 属性方式三:beta版本的关键字，手写的时候已经没有提示了
@property (nonatomic, strong) NSString * __nullable __nullableName;

//方法方式一:
- (nullable NSString *)test1:(nullable NSString *)str;

//方法方式二:
- (NSString *_Nullable)test2;




#pragma mark -  2，nonNull：不能为空
/*
 1，写法：属性和方法不能为空
 2，只能修饰对象，不能修饰基本类型
 这样写会报错:@property (nonatomic, assign,nonnull) int number;
 3，属性有3种写法，方法只有2种写法
 */
//属性方式一:
@property (nonatomic, strong, nonnull) NSString *nonnullIcon;

//属性方式二:放在*号之后
@property (nonatomic, strong) NSString * _Nonnull _NonnullIcon;

//属性方式三:beta版本的关键字，已经没有提示
@property (nonatomic, strong) NSString * __nonnull __nonnullIcon;

//方法方式一:
- (nonnull NSString *)test3:(nonnull NSString *)str;

//方法方式二:
- (NSString *_Nonnull)test4;


#pragma mark -  3，苹果怎样统一使用
/*
 1，在NS_ASSUME_NONNULL_BEGIN和NS_ASSUME_NONNULL_END两个宏之间，定义的所有对象属性和方法，统一默认为nonnull
 2，在中间的其他属性，若再用nullable修饰，则使用可为空特性
 */


#pragma mark -  4，null_unspecified：未具体指明
/*
 1，写法：属性和方法未具体指明是否为空
 2，只能修饰对象，不能修饰基本类型
 这样写会报错:@property (nonatomic, assign,nonnull) int number;
 3，属性有3种写法，方法只有2种写法
 */
//属性方式一:
 @property (nonatomic, strong, null_unspecified) NSString *null_unspecifiedName;
//属性方式二:
 @property (nonatomic, strong) NSString *_Null_unspecified _Null_unspecifiedName;
//属性方式三:
 @property (nonatomic, strong) NSString * __null_unspecified __null_unspecifiedName;
//方法方式一:
- (null_unspecified NSString *)test5:(null_unspecified NSString *)str;
//方法方式二:
- (NSString *_Null_unspecified)test6;


#pragma mark -  5，null_resettable：get方法不能返回为空，set方法可以为空
/*
 1,只能修饰属性
 2，只有一种写法
 3，用null_resettable修饰的属性，一定要在getter方法中非空判断
 */
 @property(nonatomic,strong,null_resettable) NSNumber * number;

@end
