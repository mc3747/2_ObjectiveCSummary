//
//  Builder.h
//  排序总结
//
//  Created by gjfax on 2018/6/12.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BuildPattern.h"
#import "BuildClass.h"

@class BuildClass;

@interface Builder : NSObject
@property (nonatomic, strong) BuildPattern *pattern;
- (BuildClass *) build;

@end
