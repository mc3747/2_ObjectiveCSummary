//
//  NetworkVC.m
//  NetworkSummary
//
//  Created by gjfax on 2018/10/9.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "NetworkVC.h"
#import "SelfMonitorServerVC.h"

@implementation NetworkVC
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"网络";
}
- (IBAction)monitorServerAction:(id)sender {
    SelfMonitorServerVC *vc = [SelfMonitorServerVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
