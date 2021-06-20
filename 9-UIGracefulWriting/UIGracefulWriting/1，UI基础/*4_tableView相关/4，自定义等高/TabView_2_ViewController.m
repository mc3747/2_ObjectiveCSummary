//
//  TabView_2_ViewController.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/7/26.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "TabView_2_ViewController.h"
#import "XMGDeal.h"
#import "XMGDealCell.h"

@interface TabView_2_ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
/** 所有的团购数据 */
@property (nonatomic, strong) NSArray *deals;
@end

@implementation TabView_2_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}
#pragma mark -  代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.deals.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMGDealCell *cell = [XMGDealCell cellWithTableView:tableView];
    // 取出模型数据
    cell.deal = self.deals[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
#pragma mark -  tableView整体设置
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 66, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor lightGrayColor];
        // 分割线颜色
        self.tableView.separatorColor = [UIColor redColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    
    return _tableView;
}

#pragma mark -  数据模型
- (NSArray *)deals
{
    if (_deals == nil) {
        // 加载plist中的字典数组
        NSString *path = [[NSBundle mainBundle] pathForResource:@"deals.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        
        // 字典数组 -> 模型数组
        NSMutableArray *dealArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            XMGDeal *deal = [XMGDeal dealWithDict:dict];
            [dealArray addObject:deal];
        }
        
        _deals = dealArray;
    }
    return _deals;
}
@end
