//
//  CommonCoverVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/4/29.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "CommonCoverVC.h"
#import "CoverDemoVC1.h"
#import "CoverDemoVC2.h"
#import "CoverDemoVC3.h"
#import "CoverDemoVC4.h"

@interface CommonCoverVC ()

@end

@implementation CommonCoverVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)demo1Action:(id)sender {
    CoverDemoVC1 *vc =  [CoverDemoVC1 new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)demo2Action:(id)sender {
    CoverDemoVC2 *vc =  [CoverDemoVC2 new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)demo3Action:(id)sender {
    CoverDemoVC3 *vc =  [CoverDemoVC3 new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)demo4Action:(id)sender {
    CoverDemoVC4 *vc =  [CoverDemoVC4 new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
