//
//  Base_2_ViewController.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/3/13.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "Base_2_ViewController.h"

@interface Base_2_ViewController ()

@end

@implementation Base_2_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UI高阶";
    
    self.vcNameArray = @[
  @[@"",@"NavigationSummaryVC",@"BZBaseViewController",@"BZBaseTableViewViewController",@"",@"",@"PackageCollectionViewVC",@"",@"CommonToastVC",@"CommonLoadingVC",@"",@"",@"CommonCoverVC"],
  
  @[@"",@"",@"",@""],
  
  @[@"RoundCornerSummaryVC",@"ImageCacheVC"],
  
  @[@"",@"SelfDefineWidgetVC"],
  
  @[@"",@""]
  
  ];
    
    self.subtitleArray =
@[
@[@"通用TabBarController",@"通用NavigationController",@"通用UIViewController",@"通用UITableViewController",@"通用UICollectionViewController",@"相册总结",@"封装的collectionView",@"通用弹框",@"通用toast框",@"通用loading框",@"通用无数据页面",@"通用刷新控件",@"通用遮罩"],

@[@"工具类",@"分类",@"常用颜色",@"常用字体"],

@[@"圆角总结",@"图片缓存总结"],

@[@"文本展示",@"自定义控件的写法"],

@[@"UI封装",@"UI的优雅写法"],

@[@"MVC",@"MVVM"],
  ];
    
    self.sectionTitleArray = @[@"通用控件",@"常用资源",@"UI性能优化",@"常见难点",@"UI规范",@"架构"];
}




@end
