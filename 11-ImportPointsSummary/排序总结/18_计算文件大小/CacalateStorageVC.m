//
//  CacalateStorageVC.m
//  排序总结
//
//  Created by gjfax on 2018/11/13.
//  Copyright © 2018 macheng. All rights reserved.
//

#import "CacalateStorageVC.h"

@interface CacalateStorageVC ()

@end

@implementation CacalateStorageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contentArray = @[@"image的存储体积计算",@"image的尺寸计算",@"image的压缩",@"文件的存储体积计算"];
    self.vcNameArray = @[@"CalculateImageStorageVC",@"",@"",@"",@""];
    self.vcTitleArray = self.contentArray;
}


@end
