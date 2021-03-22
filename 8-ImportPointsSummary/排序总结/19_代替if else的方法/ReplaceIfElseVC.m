//
//  ReplaceIfElseVC.m
//  排序总结
//
//  Created by gjfax on 2019/1/18.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "ReplaceIfElseVC.h"
#import "TestReplaceIfElseVC.h"

@interface ReplaceIfElseVC ()

@end

@implementation ReplaceIfElseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contentArray = @[@"if-else",@"if-return",@"switch-case",@"三目运算符"];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TestReplaceIfElseVC *vc = [[TestReplaceIfElseVC alloc] init];
    vc.testType = indexPath.row;
    vc.title = self.contentArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
 }

#pragma mark -  1，if-else

@end
