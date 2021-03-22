//
//  MultiThreadViewController.m
//  NetworkSummary
//
//  Created by gjfax on 2020/3/16.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "MultiThreadViewController.h"
#import "GCDBaseViewController.h"
#import "GCDOtherViewController.h"
#import "NetWorkingViewController.h"

@interface MultiThreadViewController ()

@end

@implementation MultiThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)demo1:(id)sender {
    GCDBaseViewController *vc = [[GCDBaseViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)demo2:(id)sender {
    GCDOtherViewController *vc = [[GCDOtherViewController alloc] init];
       [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)demo3:(id)sender {
    NetWorkingViewController *vc = [[NetWorkingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
