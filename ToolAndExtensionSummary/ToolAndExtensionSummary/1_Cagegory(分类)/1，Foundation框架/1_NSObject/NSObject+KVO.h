//
//  NSObject+KVO.h
//  ToolAndExtensionSummary
//
//  Created by gjfax on 2018/6/12.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KVO)
#pragma mark -  block封装KVO
/********添加观察者 ********/
- (NSString *)bk_addObserverForKeyPath:(NSString *)keyPath task:(void (^)(id target))task;

- (NSString *)bk_addObserverForKeyPaths:(NSArray *)keyPaths task:(void (^)(id obj, NSString *keyPath))task;

- (NSString *)bk_addObserverForKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options task:(void (^)(id obj, NSDictionary *change))task;

- (NSString *)bk_addObserverForKeyPaths:(NSArray *)keyPaths options:(NSKeyValueObservingOptions)options task:(void (^)(id obj, NSString *keyPath, NSDictionary *change))task;

- (void)bk_addObserverForKeyPath:(NSString *)keyPath identifier:(NSString *)token options:(NSKeyValueObservingOptions)options task:(void (^)(id obj, NSDictionary *change))task;

- (void)bk_addObserverForKeyPaths:(NSArray *)keyPaths identifier:(NSString *)token options:(NSKeyValueObservingOptions)options task:(void (^)(id obj, NSString *keyPath, NSDictionary *change))task;

/********移除观察者 ********/
//指定Path和ID的观察者
- (void)bk_removeObserverForKeyPath:(NSString *)keyPath identifier:(NSString *)token;

//指定ID的观察者
- (void)bk_removeObserversWithIdentifier:(NSString *)token;

//所有观察者
- (void)bk_removeAllBlockObservers;
@end
