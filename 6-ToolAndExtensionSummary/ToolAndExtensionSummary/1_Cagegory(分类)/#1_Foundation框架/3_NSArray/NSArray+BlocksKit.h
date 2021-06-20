//
//  NSArray+BlocksKit.h
//  ToolAndExtensionSummary
//
//  Created by gjfax on 2018/6/13.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<ObjectType> (BlocksKit)

//遍历数组
- (void)bk_each:(void (^)(ObjectType obj))block;

//异步遍历（顺序打乱）
- (void)bk_apply:(void (^)(ObjectType obj))block;


//返回第一个符合条件的
/*
     示例：NSString* str = [arr bk_match:^BOOL(id  _Nonnull obj) {
    return ((NSString *)obj).length == 1;
    }];
*/
- (nullable id)bk_match:(BOOL (^)(ObjectType obj))block;


//返回所有符合block条件（让block返回YES）的对象
/*
     NSArray* arr_01 = [arr bk_select:^BOOL(id  _Nonnull obj) {
     return ((NSString *)obj).length == 1;
     }];
 */
- (NSArray *)bk_select:(BOOL (^)(ObjectType obj))block;


//返回所有不符合block条件（让block返回YES）的对象
/*
     NSArray* arr_02 = [arr bk_reject:^BOOL(id  _Nonnull obj) {
     return ((NSString *)obj).length == 1;
     }];
 */
- (NSArray *)bk_reject:(BOOL (^)(ObjectType obj))block;


//返回对象的block映射数组
/*
     NSArray *new = [stringArray bk_map:^id(id obj) {
     return [obj stringByAppendingString:@".png"]);
     }];
*/
- (NSArray *)bk_map:(id (^)(ObjectType obj))block;

//与bk_map类似，但是不添加元素为空的情形
- (NSArray *)bk_compact:(id (^)(ObjectType obj))block;

//归纳，合并数组元素
/*
     NSString *concentrated = [stringArray bk_reduce:@"" withBlock:^id(id sum, id obj) {
     return [sum stringByAppendingString:obj];
     }];
 或者：
     NSUInteger value = [[[stringArray bk_reduce:nil withBlock:^id(id sum, id obj) {
     return @([sum integerValue] + obj.length);
     }]] unsignedIntegerValue];
*/
- (nullable id)bk_reduce:(nullable id)initial withBlock:(__nullable id (^)(__nullable id sum, ObjectType obj))block;

//数组求和（int）
/*
     NSArray *peoples = @[p1, p2, p3];
     NSInteger totalAge = [peoples reduceInteger:0 withBlock:^(NSInteger result, id obj, NSInteger index) {
     return result + [obj age];
     }];
*/
- (NSInteger)bk_reduceInteger:(NSInteger)initial withBlock:(NSInteger(^)(NSInteger result, ObjectType obj))block;


//数组求和（float）
/*
     NSArray *peoples = @[p1, p2, p3];
     CGFloat totalBalance = [peoples reduceFloat:.0f WithBlock:^CGFloat(CGFloat result, id obj, NSInteger index) {
     return result + [obj balance];
     }];
 */
- (CGFloat)bk_reduceFloat:(CGFloat)inital withBlock:(CGFloat(^)(CGFloat result, ObjectType obj))block;


//判断是否容器中至少有一个元素符合block条件
/*
     NSString *letter = @"A";
     BOOL containsLetter = [stringArray bk_any:^(id obj) {
     return [obj hasPrefix:@"A"];
     }];
*/
- (BOOL)bk_any:(BOOL (^)(ObjectType obj))block;

//判断是否容器中所有元素都不符合block条件
- (BOOL)bk_none:(BOOL (^)(ObjectType obj))block;

//判断是否容器中所有元素都符合block条件
- (BOOL)bk_all:(BOOL (^)(ObjectType obj))block;

//两个数组的元素比较，是否满足条件
/*
 NSArray *numbers = @[ @(1), @(2), @(3) ];
 NSArray *letters = @[ @"1", @"2", @"3" ];
 BOOL doesCorrespond = [numbers bk_corresponds:letters withBlock:^(id number, id letter) {
 return [[number stringValue] isEqualToString:letter];
 }];
*/
- (BOOL)bk_corresponds:(NSArray *)list withBlock:(BOOL (^)(ObjectType obj1, id obj2))block;

@end


@interface NSMutableArray<ObjectType> (BlocksKit)

//删除容器中不符合block条件的对象，即只保留符合block条件的对象
- (void)bk_performSelect:(BOOL (^)(id ObjectType))block;

//删除容器中符合block条件的对象
- (void)bk_performReject:(BOOL (^)(id ObjectType))block;

//容器中的对象变换为自己的block映射对象
/*
     [foo bk_performMap:^id(id obj) {
     return [dateTransformer dateFromString:obj];
     }];
 */
- (void)bk_performMap:(id (^)(id ObjectType))block;
@end
NS_ASSUME_NONNULL_END
