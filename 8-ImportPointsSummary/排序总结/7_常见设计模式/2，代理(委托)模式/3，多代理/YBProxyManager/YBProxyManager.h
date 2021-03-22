//
//  YBProxyManager.h
//  YBProxyCuttingModule
//
//  Created by 杨波 on 2018/4/24.
//  Copyright © 2018年 杨波. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 用法：
 当你需要使用多个对象(target)来承接一些方法的实现，初始化 YBProxyManager 实例，将这些对象实例添加到
 YBProxyManager 实例中(addTarget)，最后将 YBProxyManager 实例作为这些方法的第一承接者。剩下的方法分发工作就交给该类了。
 */

@interface YBProxyManager : NSObject

- (void)addTarget:(id)target;
- (void)removeTarget:(id)target;

@property (nonatomic, strong, readonly) NSPointerArray *targets;

@end
