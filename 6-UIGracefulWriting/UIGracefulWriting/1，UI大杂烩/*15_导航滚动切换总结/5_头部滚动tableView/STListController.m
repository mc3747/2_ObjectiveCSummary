//
//  STListController.m
//  SwipeTableView
//
//  Created by Roy lee on 16/4/2.
//  Copyright © 2016年 Roy lee. All rights reserved.
//

#import "STListController.h"
#import "STViewController.h"

@interface STListController ()

@property (nonatomic, strong) NSArray * dataSource;

@end

@implementation STListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.subtitleArray = @[@[@"SingleOneKindView",@"HybridItemViews",@"DisabledBarScroll",@"HiddenNavigationBar"]];
    self.vcNameArray = @[@[@"STViewController",@"STViewController",@"STViewController",@"STViewController"]];
    
    self.dataSource = @[@{
                            @"title":@"SingleOneKindView",
                            @"type":@(STControllerTypeNormal),
                            },
                        @{
                            @"title":@"HybridItemViews",
                            @"type":@(STControllerTypeHybrid),
                            },
                        @{
                            @"title":@"DisabledBarScroll",
                            @"type":@(STControllerTypeDisableBarScroll),
                            },
                        @{
                            @"title":@"HiddenNavigationBar",
                            @"type":@(STControllerTypeHiddenNavBar),
                            }];
    
    [self getSelfDefinedBlock:^(NSIndexPath *indexPath) {
        STViewController *demoVC = [STViewController new];
        demoVC.type = (STControllerType)[self.dataSource[indexPath.row][@"type"] integerValue];
        demoVC.title  = self.dataSource[indexPath.row][@"title"];
        [self.navigationController pushViewController:demoVC animated:YES];
    } with:YES];
}



@end
