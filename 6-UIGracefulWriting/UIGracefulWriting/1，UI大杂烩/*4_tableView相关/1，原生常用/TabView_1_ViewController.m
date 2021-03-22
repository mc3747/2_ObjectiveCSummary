//
//  TabView_1_ViewController.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/7/26.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "TabView_1_ViewController.h"

@interface TabView_1_ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TabView_1_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
}
#pragma mark -  1,tableView的数据源方法

    #pragma mark -  tableView的数据源必须实现
// 每组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

// 返回显示的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 系统自带cell的四个常用属性
    //    imageView：显示在左边的一张图片logo；
    //    textLabel：主要文字，黑色字体显示；
    //    detailTextLabel：详细说明文字，字体较小；
    //    accessaryView：附件视图，可以使用自定义View，也可以使用系统自带的一些标准按钮。
    
    if (indexPath.row % 2 == 0) {
        return [self cell:tableView indexPath:indexPath];
    } else {
        return [self cell2:tableView indexPath:indexPath];
    };
  
}

- (UITableViewCell *)cell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    // 0.重用标识
    // 被static修饰的局部变量：只会初始化一次，在整个程序运行过程中，只有一份内存
    static NSString *ID = @"cell1";
    
    // 1.先根据cell的标识去缓存池中查找可循环利用的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
    // 2.注册id的cell数据（一定不要忘记）
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    // 3.覆盖数据
        cell.textLabel.text = [NSString stringWithFormat:@"cell1 - %zd", indexPath.row];
    }
    
    // 4，右边小箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (UITableViewCell *)cell2:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    // 0.重用标识
    // 被static修饰的局部变量：只会初始化一次，在整个程序运行过程中，只有一份内存
    static NSString *ID = @"cell2";
    
    // 1.先根据cell的标识去缓存池中查找可循环利用的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
    // 2.注册id的cell数据（一定不要忘记）
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    // 3.覆盖数据
        cell.textLabel.text = [NSString stringWithFormat:@"cell2 - %zd", indexPath.row];
    }
    
    
    return cell;
}
    #pragma mark -  tableView的数据源选择实现
// tablaView上有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

// 返回某个section对应的header标题
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"头部标题";
}
// 返回某个section对应的footer标题
- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
     return @"底部标题";
}

// 设置cell为可编辑模式
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

// 设置cell为可移动模式
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
     return YES;
}

// 设置右边栏的索引目录数组 e.g. "ABCD...Z#"
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView __TVOS_PROHIBITED{
    
    NSArray *titleArray = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    return titleArray;
}
// 点击右侧索引表项时调用 e.g. "B",1
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index __TVOS_PROHIBITED{
    return index;
}
// 提交编辑
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}

// 移动时使用
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
}


#pragma mark -  2,tableView的代理方法

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

@end
