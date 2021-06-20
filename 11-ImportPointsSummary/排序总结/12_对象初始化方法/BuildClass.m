//
//  BuildClass.m
//  排序总结
//
//  Created by gjfax on 2018/6/12.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "BuildClass.h"

@implementation BuildClass

+ (BuildClass *)buildPersonWithBuilder:(BuilderBlock)builderBlock {
    Builder *builder = [[Builder alloc] init];
    BuildClass *buildClass = [builder build];
    builderBlock(builder);
    return buildClass;
}
@end
