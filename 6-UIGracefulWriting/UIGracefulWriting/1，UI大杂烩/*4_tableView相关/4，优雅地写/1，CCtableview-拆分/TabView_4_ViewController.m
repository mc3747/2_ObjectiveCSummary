//
//  TabView_4_ViewController.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/7/26.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "TabView_4_ViewController.h"
#import "CCTableDataSourceHeader.h"
#import "UITableView+CCUtil.h"

#import "ExampleData.h"
#import "ExampleCell.h"
#import "ExampleDynamicHeightCell.h"
#import "ExampleHeaderView.h"
#import "ExampleFooterView.h"

@interface TabView_4_ViewController ()<
ExampleHeaderViewDelegate,
ExampleFooterViewDelegate,
ExampleCellDelegate
>
//视图
@property (nonatomic, strong) CCTableDataItem *dataItem;
//代理
@property (nonatomic, strong) CCTableViewDelegate *ccDelegate;
//数据源
@property (nonatomic, strong) CCTableViewDataSource *ccDataSource;
//数据
@property (nonatomic, strong) ExampleData *data;
//tableView
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TabView_4_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    //    设置代理
    self.tableView.delegate = self.ccDelegate;
    //    设置数据源
    self.tableView.dataSource = (id <UITableViewDataSource>) self.ccDataSource;
    //    注册cell
    [self.tableView registerCellClasses:@[[ExampleCell class]]];
    [self setTabViewData];
    [self setTableViewDelegate];
    
    [self.view addSubview:self.tableView];
}

- (void)setTabViewData {
    [self.dataItem clearData];
    
    //创建无代理的区头区尾
    [self.dataItem addHeaderClass:[ExampleHeaderView class]
                      headerDataItem:[self.data exampleHeaderData]
                      footerClass:[ExampleFooterView class]
                      footerDataItem:[self.data exampleFooterData]];
    //创建cell
    [self.dataItem addCellClass:[ExampleCell class] dataItem:[self.data exampleCellData]];
    
//    //创建有代理的区头区尾
//    [self.dataItem addHeaderClass:[ExampleHeaderView class]
//                      headerDataItem:[self.data exampleHeaderDataWithDelegate]
//                      headerDelegate:self
//                      footerClass:[ExampleFooterView class]
//                      footerDataItem:[self.data exampleFooterDataWithDelegate]
//                      footerDelegate:self];
//
//    [self.dataItem addCellClass:[ExampleCell class] dataItems:[self.data exampleCellDatasWithDelegate] delegate:self];
//
//    //创建动态高度区
//    [self.dataItem addHeaderNibClass:[ExampleHeaderView class]
//                      headerDataItem:[self.dataManager exampleDynamicHeaderData]
//                      footerNibClass:[ExampleFooterView class]
//                      footerDataItem:[self.dataManager exampleDynamicFooterData]];
//    
//    [self.dataItem addCellClass:[ExampleDynamicHeightCell class] dataItems:[self.dataManager exampleDynamicDatas]];
    
    [self.tableView reloadData];
}

- (void)setTableViewDelegate {
    [self.ccDelegate setDidSelectRowAtIndexPath:^(UITableView *tableView, NSIndexPath *indexPath, id rowData, NSString *cellClassName) {
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        if ([rowData isKindOfClass:[ExampleCellItem class]]) {
            ExampleCellItem *cellItem = (ExampleCellItem *)rowData;
            NSLog(@"该单元格对应的数据源标题为:%@\n对应的按钮标题为:%@",cellItem.titleString,cellItem.buttonString);
        }else if ([rowData isKindOfClass:[ExampleDynamicHeightCellItem class]])
        {
            ExampleDynamicHeightCellItem *dynamicCellItem = (ExampleDynamicHeightCellItem *)rowData;
            NSLog(@"点击的是动态高度单元格,该单元格对应的数据源内容为:\n%@",dynamicCellItem.dataString);
        }
    }];
}
#pragma mark - Delegate

#pragma mark ExampleHeaderViewDelegate
- (void)headerView:(ExampleHeaderView *)headerView rightButtonClick:(UIButton *)click
{
    NSLog(@"调用区头代理方法");
}

#pragma mark ExampleFooterViewDelegate
- (void)footerView:(ExampleFooterView *)headerView leftButtonClick:(UIButton *)click
{
    NSLog(@"调用区尾代理方法");
}

#pragma mark ExampleCellDelegate
- (void)exampleCell:(ExampleCell *)cell buttonClick:(UIButton *)sender
{
    NSLog(@"调用cell代理方法");
}

#pragma mark -  懒加载
- (CCTableDataItem *)dataItem
{
    if (!_dataItem) {
        _dataItem = [CCTableDataItem dataItem];
    }
    return _dataItem;
}

- (CCTableViewDelegate *)ccDelegate
{
    if (!_ccDelegate) {
        _ccDelegate = [CCTableViewDelegate delegateWithDataItem:self.dataItem];
    }
    return _ccDelegate;
}

- (CCTableViewDataSource *)ccDataSource
{
    if (!_ccDataSource) {
        _ccDataSource = [CCTableViewDataSource dataSourceWithItem:self.dataItem];
    }
    return _ccDataSource;
}
- (ExampleData *)data
{
    if (!_data) {
        _data = [[ExampleData alloc] init];
    }
    return _data;
}
- (UITableView *)tableView
{
    if (!_tableView) {
          _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 66, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height - 66) style:UITableViewStylePlain];
    }
    return _tableView;
}
@end
