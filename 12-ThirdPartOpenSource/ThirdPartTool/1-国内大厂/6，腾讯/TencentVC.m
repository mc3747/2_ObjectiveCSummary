//
//  AlibabaVC.m
//  ThirdPartTool
//
//  Created by gjfax on 2019/3/12.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "TencentVC.h"


@interface TencentVC ()

@end

@implementation TencentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"腾讯";
    self.sectionTitles = @[@"1,开源地址",@"2,OC项目"];
    self.cellTitles = @[@[@"https://github.com/Tencent",@"https://github.com/AlloyTeam",],@[@"1,VAP视频播放",@"2,QMUI_iOS（UI开发）",@"3,MLeaksFinder（内存泄露）",@"4,LKImageKit（图片优化）",@"5，MMKV（微信高性能key-value组件）",@"6，mars（微信跨平台日志系统）"]];
}

@end
