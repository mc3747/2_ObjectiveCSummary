//
//  PointerManager.m
//  泛型汇总
//
//  Created by gjfax on 2018/6/8.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "PointerManager.h"

@implementation PointerManager
/*
 1，野指针：指向僵尸对象的指针（僵尸对象：对象被释放，引用计数为0）
 2，空指针：未指向任何对象的指针
 3，只要给一个野指针发送消息就会报错，坏内存访问：message sent to deallocated instance
 4，为了避免野指针发送消息会报错, 一般情况下, 当一个对象被释放后我们会将这个对象的指针设置位空指针，因为在OC中给空指针发送消息是不会报错的
 */
@end
