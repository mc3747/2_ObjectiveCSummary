//
//  ElegantTableViewGenerator.m
//  ElegantTableViewDemo
//
//  Created by YJHou on 2017/7/3.
//  Copyright © 2017年 houmanager. All rights reserved.
//

#import "ElegantTableViewGenerator.h"

@interface ElegantTableViewGenerator () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *titles; /**< 主数据源 */
@property (nonatomic, strong) NSMutableArray *subTitles; /**< 主数据源 */
@property (nonatomic, copy) didSelectRowHandleBlock didselectRowBlock; /**< 点击row */
@property (nonatomic, copy) didScrollHandleBlock didScrollBlock; /**< 滚动block */

@end

@implementation ElegantTableViewGenerator

+ (ElegantTableViewGenerator *)createWithFrame:(CGRect)frame
                          titles:(NSArray *)titles
                       subTitles:(NSArray *)subTitles
                       rowHeight:(CGFloat)rowHeight
               didSelectRowBlock:(didSelectRowHandleBlock)didSelectRowBlock
                  didScrollBlock:(didScrollHandleBlock)didScrollBlock {
    
    ElegantTableViewGenerator *tableViewGenerator = [[ElegantTableViewGenerator alloc] init];
    
    tableViewGenerator.titles = [NSMutableArray arrayWithArray:titles];
    tableViewGenerator.subTitles = [NSMutableArray arrayWithArray:subTitles];
    tableViewGenerator.didselectRowBlock = didSelectRowBlock;
    tableViewGenerator.didScrollBlock = didScrollBlock;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    tableView.delegate = tableViewGenerator;
    tableView.dataSource = tableViewGenerator;
    tableView.rowHeight = rowHeight;
    tableView.tableFooterView = [UIView new];
    
    tableView.estimatedSectionHeaderHeight = tableView.estimatedSectionFooterHeight = tableView.estimatedRowHeight = 0.0f;
    tableViewGenerator.tableView = tableView;
    
    return tableViewGenerator;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * cellId = @"ElegantTableViewGeneratorCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = [self.titles objectAtIndex:indexPath.row];
    
    if (self.subTitles.count > 0) {
        if (indexPath.row > self.subTitles.count) {
            cell.detailTextLabel.text = @"";
        }else{
            cell.detailTextLabel.text = [self.subTitles objectAtIndex:indexPath.row];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.didselectRowBlock) {
        self.didselectRowBlock(tableView, indexPath);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.didScrollBlock) {
        self.didScrollBlock(scrollView, scrollView.contentOffset);
    }
}

#pragma mark - Lazy
- (NSMutableArray *)titles{
    if (!_titles) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}

- (NSMutableArray *)subTitles{
    if (!_subTitles) {
        _subTitles = [NSMutableArray array];
    }
    return _subTitles;
}

- (void)dealloc {
//    NSLog(@"-->%s", __func__);
}

@end
