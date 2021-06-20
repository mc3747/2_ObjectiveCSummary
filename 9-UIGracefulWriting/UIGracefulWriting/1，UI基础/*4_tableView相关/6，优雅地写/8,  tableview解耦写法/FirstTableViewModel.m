//
//  FirstTableViewModel.m
//  SUIMVVMDemo
//
//  Created by yuantao on 16/4/8.
//  Copyright © 2016年 lovemo. All rights reserved.
//

#import "FirstTableViewModel.h"



static NSString *const MyCellIdentifier = @"FirstCell" ;  // `cellIdentifier` AND `NibName` HAS TO BE SAME !

@interface FirstTableViewModel ()
@property (nonatomic, strong) NSArray *dataArrayList;
@end

@implementation FirstTableViewModel

- (NSArray *)dataArrayList {
    if (_dataArrayList == nil) {
        _dataArrayList = [NSMutableArray array];
    }
    return _dataArrayList;
}

- (void)handleWithTable:(UITableView *)table {
    table.delegate = self;
    table.dataSource = self;
    
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:MyCellIdentifier];
}

- (void)getDataWithModelArray:(NSArray *(^)(void))modelArrayBlock completion:(void (^)(void))completion {
    
    if (modelArrayBlock) {
        self.dataArrayList = modelArrayBlock();
        if (completion) {
            completion();
        }
    }
 
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.dataArrayList[indexPath.row];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArrayList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyCellIdentifier forIndexPath:indexPath] ;
    cell.textLabel.text = self.dataArrayList[indexPath.row];
    
    return cell ;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44.f;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
