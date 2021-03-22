//
//  SelManager.h
//  泛型汇总
//
//  Created by gjfax on 2018/6/8.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelManager : NSObject
/*
 1，SEL：类成员方法的指针
 2，调用方法：
    SEL sel1 = @selector(signalWithNumber:)
    [p performSelector:sel1 withObject:@"13838383438"];
 3，查询是否调用：
    SEL sel1 = @selector(test);
    BOOL flag = [p respondsToSelector:sel1];
 4，字符串写法：
    //正向写法
    SEL sel1　=　NSSelectorFromString(test);
    //反向查询
    NSString *method = NSStringFromSelector(sel1);
 */
@end
