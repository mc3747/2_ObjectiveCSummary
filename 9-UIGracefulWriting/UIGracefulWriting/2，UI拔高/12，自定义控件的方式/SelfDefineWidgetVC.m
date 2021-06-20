//
//  SelfDefineWidgetVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/5/20.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "SelfDefineWidgetVC.h"
#import "PureCodeViewController.h"
#import "PureXibViewController.h"

@interface SelfDefineWidgetVC ()

@end

@implementation SelfDefineWidgetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)clickAction1:(id)sender {
    PureCodeViewController *vc = [PureCodeViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)clickAction2:(id)sender {
    PureXibViewController *vc = [PureXibViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
