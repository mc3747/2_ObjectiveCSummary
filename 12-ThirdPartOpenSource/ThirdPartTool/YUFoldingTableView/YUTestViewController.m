//
//  YUTestViewController.m
//  YUFoldingTableViewDemo
//
//  Created by administrator on 16/8/25.
//  Copyright © 2016年 timelywind. All rights reserved.
//

#import "YUTestViewController.h"
#import "XYWKWebViewController.h"
@interface YUTestViewController ()

@property (nonatomic, weak) YUFoldingTableView *foldingTableView;
@property (nonatomic, assign) YUFoldingSectionHeaderArrowPosition arrowPosition;
@property (nonatomic, assign) NSInteger index;

@end

@implementation YUTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // 创建tableView
    [self setupFoldingTableView];
}

// 创建tableView
- (void)setupFoldingTableView
{
    self.foldingTableView.contentInsetAdjustmentBehavior= NO;
    CGFloat topHeight = [[UIApplication sharedApplication] statusBarFrame].size.height + 44;
    YUFoldingTableView *foldingTableView = [[YUFoldingTableView alloc] initWithFrame:CGRectMake(0, topHeight, self.view.bounds.size.width, self.view.bounds.size.height - topHeight)];
    _foldingTableView = foldingTableView;
    
    [self.view addSubview:foldingTableView];
    foldingTableView.foldingDelegate = self;
    
    if (self.arrowPosition) {
        foldingTableView.foldingState = YUFoldingSectionStateShow;
    }
    
    //用来控制每个section的折叠状态
    //    if (self.index == 2) {
    //        foldingTableView.sectionStateArray = @[@"1", @"0", @"0", @"1", @"1"];
    //    }
}
- (void)setSectionTitles:(NSArray<NSString *> *)sectionTitles{
    _sectionTitles = sectionTitles;
    NSMutableArray *test = [[NSMutableArray alloc]init];
    for (int i = 0; i < _sectionTitles.count; i++) {
        [test addObject:@"1"];
    }
    _foldingTableView.sectionStateArray = test;
    
}
#pragma mark - YUFoldingTableViewDelegate / required（必须实现的代理）
- (NSInteger )numberOfSectionForYUFoldingTableView:(YUFoldingTableView *)yuTableView
{
    return _sectionTitles.count;
}
- (NSInteger )yuFoldingTableView:(YUFoldingTableView *)yuTableView numberOfRowsInSection:(NSInteger )section
{
    return _cellTitles[section].count;
}
- (CGFloat )yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForHeaderInSection:(NSInteger )section
{
    return 50;
}
- (CGFloat )yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UITableViewCell *)yuFoldingTableView:(YUFoldingTableView *)yuTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [yuTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = _cellTitles[indexPath.section][indexPath.row];
    return cell;
}
#pragma mark - YUFoldingTableViewDelegate / optional （可选择实现的）

- (NSString *)yuFoldingTableView:(YUFoldingTableView *)yuTableView titleForHeaderInSection:(NSInteger)section
{
    //    return [NSString stringWithFormat:@"Title %ld",(long)section];
    return _sectionTitles[section];
}

- (void )yuFoldingTableView:(YUFoldingTableView *)yuTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        XYWKWebViewController *vc = [[XYWKWebViewController alloc]init];
        vc.url = _cellTitles[indexPath.section][indexPath.row];
//        vc.url = @"https://www.baidu.com";
        [self.navigationController pushViewController:vc animated:YES];
    }
    [yuTableView deselectRowAtIndexPath:indexPath animated:YES];
}

// 返回箭头的位置
- (YUFoldingSectionHeaderArrowPosition)perferedArrowPositionForYUFoldingTableView:(YUFoldingTableView *)yuTableView
{
    // 没有赋值，默认箭头在左
    return self.arrowPosition ? :YUFoldingSectionHeaderArrowPositionLeft;
}

- (NSString *)yuFoldingTableView:(YUFoldingTableView *)yuTableView descriptionForHeaderInSection:(NSInteger )section
{
    return @"";
}



@end
