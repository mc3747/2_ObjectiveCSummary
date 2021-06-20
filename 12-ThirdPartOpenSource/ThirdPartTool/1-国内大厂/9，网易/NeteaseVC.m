//
//  AlibabaVC.m
//  ThirdPartTool
//
//  Created by gjfax on 2019/3/12.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "NeteaseVC.h"


@interface NeteaseVC ()

@end

@implementation NeteaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"网易";
    self.sectionTitles = @[@"1,开源地址",@"2,OC项目"];
    self.cellTitles = @[@[@"https://github.com/netease",@"https://github.com/kaola-fed",@"https://github.com/AirtestProject"],@[@"1,AirtestIDE(网易游戏自动化测试框架)"]];
}

@end
