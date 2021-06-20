//
//  BlockManager.h
//  泛型汇总
//
//  Created by gjfax on 2018/6/12.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlockManager : NSObject
/*
 1，block中可以访问外边的变量；
 2，block中，可以和外边同名的变量；
 3，block中，不能直接修改外边的变量（值传递）；
 4，block中，如果修改外界变量的值, 必须在外界变量前面加上__block（地址传递）
 5，block的存储位置：默认情况下block存储在栈中, 如果对block进行一个copy操作, block会转移到堆中
    如果block在栈中, block中访问了外界的对象, 那么不会对对象进行retain操作
 6，__block 和 __weak区别：
    共同点：都可以防止循环引用；
    不同点：1，__weak只用在ARC，__block用在ARCheMRC；
          2，__weak只修饰OC对象，__block可以修饰OC对象和基本类型；
          3， __weak修饰的对象不能修改，__block修饰的对象和变量可以修改；
          4，__weak使用场景：当前对象持有的属性，用weak修饰搭配使用
            __weak typeof(self) weakSelf = self;
            __strong typeof(weakSelf) strongSelf = weakSelf
          5，__block使用场景：局部变量的改变 && 修饰属性@property &&使用时修饰全局变量
 
 */
@end
