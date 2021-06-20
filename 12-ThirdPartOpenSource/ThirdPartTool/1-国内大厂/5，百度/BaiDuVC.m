//
//  AlibabaVC.m
//  ThirdPartTool
//
//  Created by gjfax on 2019/3/12.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "BaiDuVC.h"


@interface BaiDuVC ()

@end

@implementation BaiDuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"百度";
    self.sectionTitles = @[@"1,开源地址",@"2,OC项目"];
    self.cellTitles = @[@[@"https://github.com/baidu",@"https://github.com/ecomfe",@"https://github.com/baidufe",@"https://github.com/be-fe"],@[@"2,QMUI_iOS（UI开发）",@"3,MLeaksFinder（内存泄露）",@"4,LKImageKit（图片优化）"]];
}

@end
