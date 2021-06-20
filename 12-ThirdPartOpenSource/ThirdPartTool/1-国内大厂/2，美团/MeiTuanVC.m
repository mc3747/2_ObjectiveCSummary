//
//  AlibabaVC.m
//  ThirdPartTool
//
//  Created by gjfax on 2019/3/12.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "MeiTuanVC.h"


@interface MeiTuanVC ()

@end

@implementation MeiTuanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"美团";
    self.sectionTitles = @[@"1,开源地址",@"2,OC项目"];
    self.cellTitles = @[@[@"https://github.com/meituan-dianping"],@[@"1,Logan（移动端日志框架）",@"2,lyrebird（移动端插件式测试平台）"]];
}

@end
