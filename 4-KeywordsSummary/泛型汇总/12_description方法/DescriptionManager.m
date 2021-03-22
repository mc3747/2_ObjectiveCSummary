//
//  DescriptionManager.m
//  泛型汇总
//
//  Created by gjfax on 2018/6/7.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "DescriptionManager.h"
#import "Person2.h"

@implementation DescriptionManager
+ (void)test {
    Person2 *p = [Person2 new];
    p.age = 80;
    NSLog(@"%@",p);
//    NSLog(@"%@",[Person2 class]);
}

/*
 1,使用%@来打印对象，本质调用了NSObject的description对象方法（打印类，就调用description类方法）
 2，打印内容默认为：返回一个字符串, 字符串的默认格式 <类的名称: 对象的地址>
 3，可以子类重写NSObject的description方法，来自定义打印内容和格式
 4，防止重写description方法：%@输出self会造成死循环
 */
@end
