//
//  NSDictionary+BlocksKit.h
//  ToolAndExtensionSummary
//
//  Created by gjfax on 2018/6/13.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary<KeyType, ObjectType> (BlocksKit)
//遍历字典
- (void)bk_each:(void (^)(KeyType key, ObjectType obj))block;

//异步遍历字典
- (void)bk_apply:(void (^)(KeyType key, ObjectType obj))block;

//返回第一个符合条件
- (nullable id)bk_match:(BOOL (^)(KeyType key, ObjectType obj))block;

//返回所有符合条件的key/value
- (NSDictionary *)bk_select:(BOOL (^)(KeyType key, ObjectType obj))block;

//返回所有不符合条件的key/value
- (NSDictionary *)bk_reject:(BOOL (^)(KeyType key, ObjectType obj))block;

//返回映射处理过的字典
- (NSDictionary *)bk_map:(id (^)(KeyType key, ObjectType obj))block;

//至少有符合条件的key/value
- (BOOL)bk_any:(BOOL (^)(KeyType key, ObjectType obj))block;

//所有key/value都不符合
- (BOOL)bk_none:(BOOL (^)(KeyType key, ObjectType obj))block;

//所有key/value都符合
- (BOOL)bk_all:(BOOL (^)(KeyType key, ObjectType obj))block;

@end

@interface NSMutableDictionary<KeyType, ObjectType> (BlocksKit)
//删除容器中不符合block条件的key/value,保留符合
- (void)bk_performSelect:(BOOL (^)(KeyType key, ObjectType obj))block;

//删除符合，保留不符合
- (void)bk_performReject:(BOOL (^)(KeyType key, ObjectType obj))block;

//全部映射
- (void)bk_performMap:(id (^)(KeyType key, ObjectType obj))block;
@end

NS_ASSUME_NONNULL_END
