//
//  InitMethodVC.m
//  排序总结
//
//  Created by gjfax on 2018/10/25.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "InitMethodVC.h"
#import "BuildClass.h"
#import "BuildPattern.h"

@interface InitMethodVC ()

@end

@implementation InitMethodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RandColor;
    
//    方法1：麻烦、而且外部可修改
    BuildPattern *buildPatten1 = [[BuildPattern alloc] init];
    buildPatten1.age = @"10";
    buildPatten1.height = 18.3;
    buildPatten1.weight = 76;
    
//    方法2：允长
    BuildPattern *buildPatten2 = [[BuildPattern alloc] initWithAge:@"10" height:18.3 weight:77];
    
//    方法3：要准备多个方法
    BuildPattern *buildPatten3 = [[BuildPattern alloc] initWithAge:@"10" height:18.3];
    
//    方法4：多个参数，传入随机个数参数；但类比较多
    BuildClass *class = [BuildClass buildPersonWithBuilder:^(Builder *builder) {
        builder.pattern.age = @"10";
        builder.pattern.height = 18.3;
        builder.pattern.weight = 76;
        
    }];
    BuildPattern *buildPatten4 = class.pattern;
    
}



@end
