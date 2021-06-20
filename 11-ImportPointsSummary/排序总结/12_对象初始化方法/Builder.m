//
//  Builder.m
//  排序总结
//
//  Created by gjfax on 2018/6/12.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "Builder.h"

@implementation Builder
- (BuildClass *) build {
    BuildClass *buildClass = [[BuildClass alloc] init];
    self.pattern = [[BuildPattern alloc] init];
    buildClass.pattern = self.pattern;
    return buildClass;
}
@end
