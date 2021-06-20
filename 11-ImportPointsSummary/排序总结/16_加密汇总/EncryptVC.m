//
//  EncryptVC.m
//  排序总结
//
//  Created by gjfax on 2018/10/26.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "EncryptVC.h"

@interface EncryptVC ()

@end

@implementation EncryptVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RandColor;
    self.contentArray = @[@"基础知识",@"哈希算法",@"对称加密",@"不对称加密",@"bsse64",@"编码格式",@"实战应用"];
    self.vcTitleArray = self.contentArray;
    self.vcNameArray = @[@"EncryptBaseVC",@"HashEncryptVC",@"SymmetryEncryptVC",@"DissymmetryEncryptVC",@"Base64EncryptVC",@"CodedFormatVC",@"EncryptApplicationVC"];
}



@end
