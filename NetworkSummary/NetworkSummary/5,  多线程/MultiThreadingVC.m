//
//  MultiThreadingVC.m
//  排序总结
//
//  Created by gjfax on 2018/10/26.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "MultiThreadingVC.h"
#import "GCDViewController.h"
#import "NSOperationVC.h"
#import "NSThreadVC.h"
#import "MultiThreadApplicationVC.h"
#import "GCDTableViewController.h"
#import "MultiThreadViewController.h"
@interface MultiThreadingVC ()

@end

@implementation MultiThreadingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)NSThreadAction:(id)sender {
    NSThreadVC *threadVC = [[NSThreadVC alloc] init];
    [self.navigationController pushViewController:threadVC animated:YES];
}
- (IBAction)GCDAction:(id)sender {
    GCDViewController *GCDVC = [[GCDViewController alloc] init];
    [self.navigationController pushViewController:GCDVC animated:YES];
}
- (IBAction)GCDAction2:(id)sender {
    GCDTableViewController *GCDVC = [[GCDTableViewController alloc] init];
    [self.navigationController pushViewController:GCDVC animated:YES];
}
- (IBAction)GCDAction3:(id)sender {
    MultiThreadViewController *GCDVC = [[MultiThreadViewController alloc] init];
    [self.navigationController pushViewController:GCDVC animated:YES];
}

- (IBAction)NSOperationAction:(id)sender {
    NSOperationVC *operationVC = [[NSOperationVC alloc] init];
    [self.navigationController pushViewController:operationVC animated:YES];
}

- (IBAction)MultiThreadApplicationAction:(id)sender {
    MultiThreadApplicationVC *operationVC = [[MultiThreadApplicationVC alloc] init];
    [self.navigationController pushViewController:operationVC animated:YES];
}

@end
