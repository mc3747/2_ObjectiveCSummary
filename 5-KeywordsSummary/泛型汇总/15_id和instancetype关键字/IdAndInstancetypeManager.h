//
//  IdAndInstancetypeManager.h
//  泛型汇总
//
//  Created by gjfax on 2018/6/8.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IdAndInstancetypeManager : NSObject
/*
 1，instancetype：
    1，只能用于作为返回值；
    2，instancetype在编译的时候可以判断对象的真实类型
    3，自定义构造方法, 返回值尽量使用instancetype, 不要使用id
 
 2，id：
    1，可以用来定义变量, 可以作为返回值, 可以作为形参；
    2，不能判断对象的真实类型；
 */
@end
