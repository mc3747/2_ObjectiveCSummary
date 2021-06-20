//
//  KVOFreshDemoVC.m
//  排序总结
//
//  Created by gjfax on 2020/2/6.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "KVOFreshDemoVC.h"
#import "RefreshView.h"
#import "ActivityView.h"

@interface KVOFreshDemoVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic)  UITableView *tableView;
@property (nonatomic, strong) RefreshView *refreshView;
@property (nonatomic, strong) ActivityView *activityView;
@end

@implementation KVOFreshDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationItem.titleView = self.refreshView;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.activityView];
    
    __weak typeof(self) weakSelf = self;
    self.refreshView.UpdateDataHandler = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.refreshView endRefreshing];
        });
    };
    
    self.activityView.UpdateDataHandler = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.activityView endRefreshing];
        });
    };
}

#pragma mark - Property
- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        tableView.backgroundColor = Wonderful_YelloeColor4;
        [self.view addSubview:tableView];
        _tableView = tableView;
    };
    
    return _tableView;
}
- (RefreshView *)refreshView
{
    if (!_refreshView) {
        _refreshView = [RefreshView attachObserveToScrollView:self.tableView];
        _refreshView.frame = CGRectMake(0, 0, 20, 20);
    }
    return _refreshView;
}

- (ActivityView *)activityView
{
    if (!_activityView) {
        _activityView = [ActivityView attachObserveToScrollView:self.tableView];
        _activityView.frame = CGRectMake(0, 0, 20, 20);
    }
    return _activityView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    return cell;
}


@end
