//
//  NullFamily.m
//  泛型汇总
//
//  Created by gjfax on 2018/6/5.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "NullFamily.h"

@implementation NullFamily

#pragma mark -  重新getter方法，非空判断
- (NSNumber *)number {
    if (_number == nil) {
        _number = @0;
    }
    return _number;
}
@end
