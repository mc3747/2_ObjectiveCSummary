//
//  BuildPattern.m
//  排序总结
//
//  Created by gjfax on 2018/6/12.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "BuildPattern.h"

@implementation BuildPattern
- (instancetype)initWithAge:(NSString *)age height:(float)height {
    if(self = [super init]) {
      
    }
    return   [self initWithAge:age height:height weight:0];
}

- (instancetype)initWithAge:(NSString *)age height:(float)height weight:(float)weight {
    if(self = [super init]) {
        _age = age;
        _height = height;
        _weight = weight;
    }
    return self;
}
@end
