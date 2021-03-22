//
//  CQBaseViewController.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/6/28.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQPercentBaseViewController.h"
#import "CQDetailViewController.h"

@interface CQPercentBaseViewController ()

@end

@implementation CQPercentBaseViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"详情" style:UIBarButtonItemStylePlain target:self action:@selector(detailButtonClicked)];
}

#pragma mark - 详情按钮点击

- (void)detailButtonClicked {
    if ([self.jianshuURL isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"暂无对应文章"];
        return;
    }
    CQDetailViewController *detailVC = [[CQDetailViewController alloc] initWithTitle:self.title jianshuURL:self.jianshuURL];
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
