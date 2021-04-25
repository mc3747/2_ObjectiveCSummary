//
//  NineGridUsingCollectionVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/10/30.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "NineGridUsingCollectionVC.h"
#import "BaseCollectionVC.h"
#import "PackageCollectionVC.h"
@interface NineGridUsingCollectionVC ()

@end

@implementation NineGridUsingCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)baseAction:(id)sender {
    BaseCollectionVC *vc = [[BaseCollectionVC alloc] initWithNibName:@"NineGridUsingCollectionVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)packageAction:(id)sender {
    PackageCollectionVC *vc = [[PackageCollectionVC alloc] init];
    GJSPushViewController(vc, YES);
}


@end
