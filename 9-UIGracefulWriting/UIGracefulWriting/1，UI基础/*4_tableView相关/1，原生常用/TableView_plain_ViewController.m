//
//  TableView_plain_ViewController.m
//  UIGracefulWriting
//
//  Created by gjfax on 2020/2/10.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "TableView_plain_ViewController.h"

@interface TableView_plain_ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TableView_plain_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self.view addSubview:self.tableView];
//    if (@available(iOS 11.0, *)){
//               self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//           } else {
//               self.automaticallyAdjustsScrollViewInsets = NO;
//           }
    
}

// tablaView上有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

// 每组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

// 返回显示的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 0.重用标识
       // 被static修饰的局部变量：只会初始化一次，在整个程序运行过程中，只有一份内存
       static NSString *ID = @"cell1";
       
       // 1.先根据cell的标识去缓存池中查找可循环利用的cell
       UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
       
       if (!cell) {
       // 2.注册id的cell数据（一定不要忘记）
           cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
           
       // 3.覆盖数据
           cell.textLabel.text = [NSString stringWithFormat:@"cell1 - %zd", indexPath.row];
       }
       
       // 4，右边小箭头
       cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
  
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc] init];
         header.backgroundColor = [UIColor blueColor];
    return header;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height - 88) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor lightGrayColor];
        _tableView.rowHeight = 80;
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 100)];
        header.backgroundColor = [UIColor greenColor];
        _tableView.tableHeaderView = header;
        // 分割线颜色
        self.tableView.separatorColor = [UIColor redColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    
    return _tableView;
}
@end
