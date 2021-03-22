//
//  SelfAndSuperManager.h
//  泛型汇总
//
//  Created by gjfax on 2018/6/7.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelfAndSuperManager : NSObject
/*
 1，self：
    1，如果self在对象方法中, 代表调用当前对象方法的那个对象
    2，如果self在类方法中, 代表调用当前类方法的那个类
    3，可以用在对象方法之间，类方法之间调用；
    4，不能在类方法和对象方法之间交叉调用；
 
 2，super：
    1，super在类方法中, 一定会调用父类的类方法
    2，super在对象方法中, 一定会调用父类的对象方法
    3，子类重写或者扩展父类的方法，可以用super先调用一次父类的方法
 */
@end
