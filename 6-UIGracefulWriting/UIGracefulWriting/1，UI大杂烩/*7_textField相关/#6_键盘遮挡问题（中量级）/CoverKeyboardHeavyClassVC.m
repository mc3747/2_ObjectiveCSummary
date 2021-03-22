//
//  CoverKeyboardHeavyClassVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/4/30.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "CoverKeyboardHeavyClassVC.h"
#import "StyleVC1.h"
#import "StyleVC2.h"
#import "StyleVC3.h"

@interface CoverKeyboardHeavyClassVC ()

@end

@implementation CoverKeyboardHeavyClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)test1:(id)sender {
    StyleVC1 *vc = [StyleVC1 new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)test2:(id)sender {
    StyleVC2 *vc = [StyleVC2 new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)test3:(id)sender {
    StyleVC3 *vc = [StyleVC3 new];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
