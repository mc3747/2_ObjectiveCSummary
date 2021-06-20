//
//  BuildClass.h
//  排序总结
//
//  Created by gjfax on 2018/6/12.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Builder.h"
#import "BuildPattern.h"
/*
 用途：多用在初始化有多种情形，多个参数，多种使用场景下使用
 */
@class Builder;
typedef void (^BuilderBlock) (Builder *builder);

@interface BuildClass : NSObject

@property (nonatomic, strong) BuildPattern *pattern;

+ (BuildClass *)buildPersonWithBuilder:(BuilderBlock)builder;


@end
