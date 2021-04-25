//
//  SeparateTableviewVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2020/3/26.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "SeparateTableviewVC.h"
#import "FirstTableViewModel.h"

@interface SeparateTableviewVC ()
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) FirstTableViewModel *firstTableViewModel;
@end

@implementation SeparateTableviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    1,添加tableview
    [self.view addSubview:self.tableview];
//    2,解耦设置tableview
    [self.firstTableViewModel handleWithTable:self.tableview];
//    3,获取数据源后刷新
    NSArray *testArray = @[@"a",@"b",@"c"];
    [self.firstTableViewModel getDataWithModelArray:^NSArray *{
             return testArray;
         } completion:^{
              [self.tableview reloadData];
         }];
    
}

- (UITableView *)tableview{
    if (_tableview == nil) {
          _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
      }
      return _tableview;
}

- (FirstTableViewModel *)firstTableViewModel {
    if (_firstTableViewModel == nil) {
        _firstTableViewModel = [[FirstTableViewModel alloc]init];
    }
    return _firstTableViewModel;
}
@end
