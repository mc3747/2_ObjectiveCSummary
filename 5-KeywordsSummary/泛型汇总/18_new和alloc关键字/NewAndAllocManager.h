//
//  NewAndAllocManager.h
//  泛型汇总
//
//  Created by gjfax on 2018/6/8.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewAndAllocManager : NSObject
/*
 new 和 alloc init方法
 1.开辟存储空间  + all®oc 方法
 2.初始化所有的属性(成员变量) - init 方法
 3.返回对象的地址
 
 不同点：
 1，alloc init方法性能比new稍微强一些，多调一个zone方法
    对象分配内存的时候，把关联的对象分配到一个相邻的内存区域内，以便于调用时消耗很少的代价，提升了程序处理速度
 2，new只能采用init初始化；alloc init可以采用其他的初始化方法
 */
@end
