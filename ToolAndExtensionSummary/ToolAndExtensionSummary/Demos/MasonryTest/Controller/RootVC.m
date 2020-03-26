//
//  RootVC.m
//  MasonryFirDemo
//
//  Created by shavekevin on 16/5/20.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "RootVC.h"

static NSString *const cellIdentifier = @"cellIdentifier";

@interface RootVC ()
<
UITableViewDataSource,
UITableViewDelegate
>
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *classNames;
/**
 *  @brief <#Description#>
 */
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation RootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"      Masonry Demo       ";
    [self initData];
}


- (void)initData {
    
    self.titles = @[].mutableCopy;
    self.classNames = @[].mutableCopy;
    [self addCellText:@"Masonry简单使用" class:@"MasonryAPIVC"];
    [self addCellText:@"Masonry 布局视图" class:@"MasonryViewController"];
    [self addCellText:@"动画 布局视图" class:@"AnimationVC"];
    [self addCellText:@"Scrollview 布局视图" class:@"ScrollViewVC"];
    [self addCellText:@"SCrollview 实战" class:@"ConfirmVC"];
    [self addCellText:@"自定义cell 实战" class:@"CustomListVC"];
    [self addCellText:@"约束优先级" class:@"PriorityLevelVC"];
    [self addCellText:@"👍我自己的masonry测试👍" class:@"UserTestVC"];
    [self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YY"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YY"];
    }
    cell.textLabel.text = _titles[indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = self.classNames[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *ctrl = class.new;
        ctrl.title = _titles[indexPath.row];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)addCellText:(NSString *)title class:(NSString *)className {
    [self.titles addObject:title];
    [self.classNames addObject:className];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsZero);
        }];
    }
    return _tableView;
}


@end
