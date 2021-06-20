//
//  CommonLoadingVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/4/30.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "CommonLoadingVC.h"
#import "LightLoadingVC.h"
#import "LightLoadingDropVC.h"
#import "StrongLoadingEasyShowVC.h"
#import "CQHomeTabBarController.h"
#import "ToastKeyPointVC.h"

@interface CommonLoadingVC ()

@end

@implementation CommonLoadingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)buttonAction1:(id)sender {
    LightLoadingVC *vc = [LightLoadingVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)buttonAction2:(id)sender {
    LightLoadingDropVC *vc = [LightLoadingDropVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)buttonAction3:(id)sender {
    StrongLoadingEasyShowVC *vc = [StrongLoadingEasyShowVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)buttonAction4:(id)sender {
    CQHomeTabBarController *vc = [CQHomeTabBarController new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)buttonAction5:(id)sender {
    ToastKeyPointVC *vc = [ToastKeyPointVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
