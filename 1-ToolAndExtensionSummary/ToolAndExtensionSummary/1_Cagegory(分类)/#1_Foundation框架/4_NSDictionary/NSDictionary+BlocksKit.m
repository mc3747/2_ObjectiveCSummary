//
//  NSDictionary+BlocksKit.m
//  ToolAndExtensionSummary
//
//  Created by gjfax on 2018/6/13.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "NSDictionary+BlocksKit.h"

@implementation NSDictionary (BlocksKit)

- (void)bk_each:(void (^)(id key, id obj))block
{
    NSParameterAssert(block != nil);
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        block(key, obj);
    }];
}

- (void)bk_apply:(void (^)(id key, id obj))block
{
    NSParameterAssert(block != nil);
    
    [self enumerateKeysAndObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id key, id obj, BOOL *stop) {
        block(key, obj);
    }];
}

- (id)bk_match:(BOOL (^)(id key, id obj))block
{
    NSParameterAssert(block != nil);
    
    return self[[[self keysOfEntriesPassingTest:^(id key, id obj, BOOL *stop) {
        if (block(key, obj)) {
            *stop = YES;
            return YES;
        }
        
        return NO;
    }] anyObject]];
}

- (NSDictionary *)bk_select:(BOOL (^)(id key, id obj))block
{
    NSParameterAssert(block != nil);
    
    NSArray *keys = [[self keysOfEntriesPassingTest:^(id key, id obj, BOOL *stop) {
        return block(key, obj);
    }] allObjects];
    
    NSArray *objects = [self objectsForKeys:keys notFoundMarker:[NSNull null]];
    return [NSDictionary dictionaryWithObjects:objects forKeys:keys];
}

- (NSDictionary *)bk_reject:(BOOL (^)(id key, id obj))block
{
    NSParameterAssert(block != nil);
    return [self bk_select:^BOOL(id key, id obj) {
        return !block(key, obj);
    }];
}

- (NSDictionary *)bk_map:(id (^)(id key, id obj))block
{
    NSParameterAssert(block != nil);
    
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithCapacity:self.count];
    
    [self bk_each:^(id key, id obj) {
        id value = block(key, obj) ?: [NSNull null];
        result[key] = value;
    }];
    
    return result;
}

- (BOOL)bk_any:(BOOL (^)(id key, id obj))block
{
    return [self bk_match:block] != nil;
}

- (BOOL)bk_none:(BOOL (^)(id key, id obj))block
{
    return [self bk_match:block] == nil;
}

- (BOOL)bk_all:(BOOL (^)(id key, id obj))block
{
    NSParameterAssert(block != nil);
    
    __block BOOL result = YES;
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (!block(key, obj)) {
            result = NO;
            *stop = YES;
        }
    }];
    
    return result;
}

@end

@implementation NSMutableDictionary (BlocksKit)

- (void)bk_performSelect:(BOOL (^)(id key, id obj))block
{
    NSParameterAssert(block != nil);
    
    NSArray *keys = [[self keysOfEntriesWithOptions:NSEnumerationConcurrent passingTest:^BOOL(id key, id obj, BOOL *stop) {
        return !block(key, obj);
    }] allObjects];
    
    [self removeObjectsForKeys:keys];
}

- (void)bk_performReject:(BOOL (^)(id key, id obj))block
{
    NSParameterAssert(block != nil);
    [self bk_performSelect:^BOOL(id key, id obj) {
        return !block(key, obj);
    }];
}

- (void)bk_performMap:(id (^)(id key, id obj))block
{
    NSParameterAssert(block != nil);
    
    NSMutableDictionary *new = [self mutableCopy];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id value = block(key, obj) ?: [NSNull null];
        if ([value isEqual:obj]) return;
        new[key] = value;
    }];
    
    [self setDictionary:new];
}

@end
