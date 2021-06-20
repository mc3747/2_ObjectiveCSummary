//
//  MethodCallVC.m
//  排序总结
//
//  Created by gjfax on 2018/11/9.
//  Copyright © 2018 macheng. All rights reserved.
//

#import "MethodCallVC.h"

@interface MethodCallVC ()

@end

@implementation MethodCallVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentArray = @[@"方法的可变参数",@"方法的多个返回值",@"调用方法的方式",@"performSelector的测试"];
    self.vcNameArray = @[@"VariableArgumentsVC",@"MultiReturnValueVC",@"CallMethodViewController",@"PerformSelectorViewController"];
    self.vcTitleArray = self.contentArray;
    
}





@end
