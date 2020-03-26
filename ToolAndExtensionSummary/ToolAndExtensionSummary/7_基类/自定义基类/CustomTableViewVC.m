//
//  CustomTableViewVC.m
//  IOS_KnowledgePoints
//
//  Created by gjfax on 2017/12/27.
//  Copyright © 2017年 macheng. All rights reserved.
//

#import "CustomTableViewVC.h"

@interface CustomTableViewVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation CustomTableViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleImageNames = [self getSafeArray:self.titleImageNames WithDefaultValue:@[@""].mutableCopy];
    self.titleNames = [self getSafeArray:self.titleNames WithDefaultValue:@[@""].mutableCopy];
    self.classNames = [self getSafeArray:self.classNames WithDefaultValue:@[@""].mutableCopy];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - 获取安全数组
- (NSMutableArray *)getSafeArray:(NSMutableArray *)array WithDefaultValue:(NSMutableArray *)defaultArray {
    if (array.count <= 0) {
        return defaultArray;
    }else {
        return array;
    }
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YY"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YY"];
    }

    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, MAIN_SCREEN_WIDTH - 60, cell.bounds.size.height)];
    textLabel.text = _titleNames[indexPath.row];
    [cell addSubview:textLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, cell.bounds.size.height - 10, cell.bounds.size.height - 10)];
    imageView.image = [UIImage imageNamed:_titleImageNames[indexPath.row]];
    [cell addSubview:imageView];
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = self.classNames[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *ctrl = class.new;
        ctrl.title = _titleNames[indexPath.row];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - tableView
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVI_HEIGHT, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT - NAVI_HEIGHT)];
        _tableView.backgroundColor = UIColorGrayLighten;
        _tableView.delegate = self;
        _tableView.dataSource = self;
       
    }
    
    return _tableView;
}
@end
