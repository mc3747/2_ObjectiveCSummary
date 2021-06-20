//
//  CustomModel.m
//  自定义控件
//
//  Created by gjfax on 16/6/3.
//  Copyright © 2016年 macheng. All rights reserved.
//

#import "PureXibCustomModel.h"

@implementation PureXibCustomModel

- (instancetype)initWithlabel:(NSString *)labelName andImage:(NSString *)imageName {
    if(self = [super init]) {
        self.labelName = labelName;
        self.imageName = imageName;
    }
    return self;
}

+ (instancetype)modelWithlabel:(NSString *)labelName andImage:(NSString *)imageName {
    return [[self alloc]initWithlabel:labelName andImage:imageName];
}
@end
