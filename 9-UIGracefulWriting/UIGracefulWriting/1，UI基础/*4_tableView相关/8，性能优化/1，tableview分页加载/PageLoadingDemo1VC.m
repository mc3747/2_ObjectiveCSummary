//
//  PageLoadingDemo1VC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/2/18.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "PageLoadingDemo1VC.h"

@interface PageLoadingDemo1VC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView     *tableView;
@property (nonatomic, strong) NSMutableArray  *dataSource;
@end

@implementation PageLoadingDemo1VC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataSource = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++)
    {
        [_dataSource addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    _tableView  = [[UITableView alloc] initWithFrame:self.view.bounds
                                               style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate   = self;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 因为要定制最后一行,所以cell多一个
    return _dataSource.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusedStr = @"demo";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedStr];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:reusedStr];
    }
    
    if([indexPath row] == ([_dataSource count]))
    {
        // 定制最后一行的cell
        cell.textLabel.text=@"获取更多..";
    }
    else
    {
        // 定制普通行的cell
        cell.textLabel.text=[_dataSource objectAtIndex:[indexPath row]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 如果是最后一行点击事件,则触发一个事件
    if (indexPath.row == ([_dataSource count]))
    {
        [self performSelectorInBackground:@selector(loadMore)
                               withObject:nil];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
}

- (void)loadMore
{
    // 添加数据源
    for (int i = 0; i < 10; i++) {
        [_dataSource addObject:[NSString stringWithFormat:@"新%d", i]];
    }
    
    // 重新加载tableView
    [_tableView reloadData];
}



@end
