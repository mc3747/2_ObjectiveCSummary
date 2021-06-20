//
//  AlibabaVC.m
//  ThirdPartTool
//
//  Created by gjfax on 2019/3/12.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "XiaoMiVC.h"


@interface XiaoMiVC ()

@end

@implementation XiaoMiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"小米";
    self.sectionTitles = @[@"1,开源地址",@"2,OC项目"];
    self.cellTitles = @[@[@"https://github.com/XiaoMi",@"https://github.com/MiCode"],@[@"2,QMUI_iOS（UI开发）",@"3,MLeaksFinder（内存泄露）",@"4,LKImageKit（图片优化）"]];
}

@end
