//
//  AlibabaVC.m
//  ThirdPartTool
//
//  Created by gjfax on 2019/3/12.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "AlibabaVC.h"

@interface AlibabaVC ()

@end

@implementation AlibabaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"阿里";
    self.sectionTitles = @[@"1,开源地址",@"2,OC常见项目",@"3,swift常见项目"];
    self.cellTitles = @[@[@"https://github.com/alibaba",@"https://github.com/NewbeeFE",],@[@"1,动态化方案Tangram",@"2,提高协程的coobjc",@"3,模块化编程BeeHive"],@[@""]];
   
}

@end
