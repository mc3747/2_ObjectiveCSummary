//
//  Person.m
//  day15
//
//  Created by xiaomage on 15/6/24.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//


#import "Person.h"

@implementation Person

// 当A对象想使用B对象一定要对B对象进行一次retain, 这样才能保证A对象存在B对象就存在, 也就是说这样才能保证无论在什么时候在A对象中都可以使用B对象
// 当A对象释放的时候, 一定要对B对应进行一次release, 这样才能保证A对象释放了, B对应也会随之释放, 避免内存泄露
// 总结一句话: 有增就有减
- (void)setRoom:(Room *)room // room = r
{
    // 只有房间不同才需用release和retain
    if (_room != room) {// 0ffe1 != 0ffe1
        
        // 将以前的房间释放掉 -1
        [_room release];
        
        /*
        // 对房间的引用计数器+1
        [room retain];
        
        _room = room;
         */
        // retain不仅仅会对引用计数器+1, 而且还会返回当前对象
        _room = [room retain];
    }
}

- (Room *)room
{
    return  _room;
}

- (void)dealloc
{
    // 人释放了, 那么房间也需要释放
    [_room release];
    NSLog(@"%s", __func__);
    [super dealloc];
}
@end
