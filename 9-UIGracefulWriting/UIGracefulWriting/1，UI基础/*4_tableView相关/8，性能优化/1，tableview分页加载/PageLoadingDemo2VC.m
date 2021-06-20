//
//  PageLoadingDemo2VC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/2/18.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "PageLoadingDemo2VC.h"

@interface PageLoadingDemo2VC ()

{
    NSMutableArray *dataArray;
    
}

@end
// =====================================================
/*
 系统的tableViewController
 下拉刷新：自带的控件
 上拉刷新：位置判断
 */
// =====================================================
@implementation PageLoadingDemo2VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化NSMutableArray集合
    dataArray = [[NSMutableArray alloc]initWithObjects:@"宵夜现在",@"小猴子",@"水果刀",@"苹果",@"香蕉",@"大象",@"老鼠", nil];
    //设置refreshControl的属性，该属性应该是UIReferseControl控件
    self.refreshControl = [[UIRefreshControl alloc]init];
    //设置颜色
    self.refreshControl.tintColor = [UIColor redColor];
    //设置该控件的提示标题
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    //为这个刷新事件设置事件处理方法
    [self.refreshControl addTarget:self action:@selector(dateReferse) forControlEvents:UIControlEventValueChanged];
    
  
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"celll";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSInteger rowNo = indexPath.row;
    cell.textLabel.text = [dataArray objectAtIndex:rowNo];
    
    return cell;
}
-(void)dateReferse
{
    //这里延时两分钟是为了表示模拟远程接受数据所耗时的
    [self performSelector:@selector(zengjiadata) withObject:nil afterDelay:2];
}
-(void)zengjiadata
{
    NSString *str = [NSString stringWithFormat:@"%d",arc4random()%9000];
    [dataArray addObject:str];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"正在刷新"];
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
    
}


@end
