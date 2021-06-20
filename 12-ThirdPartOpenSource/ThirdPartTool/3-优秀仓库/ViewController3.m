//
//  ViewController.m
//  ThirdPartTool
//
//  Created by gjfax on 2019/2/15.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "ViewController3.h"
#import "ElegantTableViewGenerator.h"
#import "YUTestViewController.h"

@interface ViewController3 ()
@property (nonatomic, strong) ElegantTableViewGenerator *tableViewGenerator;
@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"优秀仓库";
    
    NSArray *titles = @[@"1_滴滴",@"2_美团",@"3_字节",@"4_阿里",@"5_百度",@"6_腾讯"];
    NSArray *images = @[@"didi",@"meituan",@"jinritoutiao",@"alibaba",@"baidu",@"tengxunwang"];
    NSArray *vcNames = @[@"",@"",@"",@"AlibabaVC",@"",@"TencentVC"];
    self.tableViewGenerator = [ElegantTableViewGenerator createWithFrame:self.view.bounds
                                                                  titles:titles
                                                               subTitles:nil
                                                                  images:images
                                                               rowHeight:60
                                                       didSelectRowBlock:^(UITableView *tableView, NSIndexPath *indexPath) {
        
        [self jumpToVC:vcNames[indexPath.row]];
        
        
    }                                                   didScrollBlock:^(UIScrollView *tableView, CGPoint contentOffset) {
        
        
    }];
    
    [self.view addSubview:self.tableViewGenerator.tableView];
    
}

#pragma mark -  控制器跳转
- (void)jumpToVC:(NSString *)vcName {
    Class class = NSClassFromString(vcName);
    UIViewController *view = [[class alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}
@end
