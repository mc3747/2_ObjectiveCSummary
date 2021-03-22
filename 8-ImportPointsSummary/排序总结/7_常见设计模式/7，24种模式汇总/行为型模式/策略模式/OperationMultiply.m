//
//  OperationMultiply.m
//  行为型设计模式-策略模式
//
//  Created by 温杰 on 2018/4/11.
//  Copyright © 2018年 温杰. All rights reserved.
//

#import "OperationMultiply.h"

@implementation OperationMultiply
-(int)doOperation:(int)num1 and:(int)num2{
    NSLog(@"当前算法乘法");
    return num1 * num2;
}
@end
