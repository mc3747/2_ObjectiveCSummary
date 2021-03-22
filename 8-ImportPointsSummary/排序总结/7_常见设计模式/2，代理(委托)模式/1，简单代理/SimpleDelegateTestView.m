//
//  SimpleDelegateTestView.m
//  排序总结
//
//  Created by gjfax on 2018/9/10.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "SimpleDelegateTestView.h"

@implementation SimpleDelegateTestView

- (instancetype)initWithDelegate:(id)delegate
{
    self = [super init];
    if (self) {
        _delegate=delegate;
        //调用已声明方法 本类中不实现 留给代理对象去实现
        [self getTheCurrentViewName:NSStringFromClass([self class])];
    }
    return self;
}

//消息的转发会触发的方法:一定要写
-(id)forwardingTargetForSelector:(SEL)aSelector{
    //该方法返回能处理未实现方法的对象
    if ([_delegate respondsToSelector:aSelector]) {

        return _delegate;

    }
    return nil;
}


@end
