//
//  XMGStatus.m
//  备课03-不等高的cell-非代码
//
//  Created by MJ Lee on 15/6/2.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGStatus.h"

@implementation XMGStatus
+ (instancetype)statusWithDict:(NSDictionary *)dict
{
    XMGStatus *status = [[self alloc] init];
    [status setValuesForKeysWithDictionary:dict];
    return status;
}
@end
