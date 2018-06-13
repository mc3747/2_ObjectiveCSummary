//
//  NSSet+BlocksKit.h
//  ToolAndExtensionSummary
//
//  Created by gjfax on 2018/6/13.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSSet<ObjectType> (BlocksKit)

// 可以参考NSArray的用法

- (void)bk_each:(void (^)(ObjectType obj))block;


- (void)bk_apply:(void (^)(ObjectType obj))block;


- (nullable id)bk_match:(BOOL (^)(ObjectType obj))block;


- (NSSet *)bk_select:(BOOL (^)(ObjectType obj))block;


- (NSSet *)bk_reject:(BOOL (^)(ObjectType obj))block;

- (NSSet *)bk_map:(id (^)(ObjectType obj))block;


- (nullable id)bk_reduce:(nullable id)initial withBlock:(__nullable id (^)(__nullable id sum, ObjectType obj))block;


- (BOOL)bk_any:(BOOL (^)(ObjectType obj))block;


- (BOOL)bk_none:(BOOL (^)(ObjectType obj))block;


- (BOOL)bk_all:(BOOL (^)(ObjectType obj))block;

@end

NS_ASSUME_NONNULL_END
