//
//  TestVC.m
//  YbProxyCuttingModule
//
//  Created by 杨少 on 2018/3/30.
//  Copyright © 2018年 杨波. All rights reserved.
//

#import "MutiDelegatVC.h"
#import "YBProxyManager.h"
#import "TestTableViewDigitConfig.h"
#import "TestTableViewClickConfig.h"
#import "TestTableViewCellConfig.h"

@interface MutiDelegatVC ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YBProxyManager *proxyManager;
@property (nonatomic, strong) TestTableViewDigitConfig *digitConfig;
@property (nonatomic, strong) TestTableViewClickConfig *clickConfig;
@property (nonatomic, strong) TestTableViewCellConfig *cellConfig;

@end

@implementation MutiDelegatVC

#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

#pragma mark getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        
        _digitConfig = [TestTableViewDigitConfig new];
        _clickConfig = [TestTableViewClickConfig new];
        _cellConfig = [TestTableViewCellConfig new];
        
        _proxyManager = [YBProxyManager new];
        [_proxyManager addTarget:_digitConfig];
        [_proxyManager addTarget:_clickConfig];
        [_proxyManager addTarget:_cellConfig];
        
        _tableView.delegate = (id)_proxyManager;
        _tableView.dataSource = (id)_proxyManager;
        
    }
    return _tableView;
}


@end
