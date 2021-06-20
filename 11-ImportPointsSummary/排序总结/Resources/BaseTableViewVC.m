//
//  BaseTableViewVC.m
//  排序总结
//
//  Created by gjfax on 2018/11/9.
//  Copyright © 2018 macheng. All rights reserved.
//

#import "BaseTableViewVC.h"

@interface BaseTableViewVC ()

@end

@implementation BaseTableViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"BaseCell"];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_contentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseCell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSString *textContent = _contentArray[indexPath.row];
    cell.textLabel.text =  [NSString stringWithFormat:@"%ld,%@",indexPath.row + 1,textContent];;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *className =  _vcNameArray[indexPath.row];
    Class class = NSClassFromString(className);
    UIViewController *controller = [[class alloc] init];
    controller.title = _vcTitleArray[indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}





@end
