//
//  SwipEditorCellVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/2/16.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "SwipEditorCellVC.h"
#import "PLTableViewController.h"
#import "PLCustomTableViewController.h"
@interface SwipEditorCellVC ()

@end

@implementation SwipEditorCellVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)systemLeftAction:(id)sender {
    PLTableViewController *vc = [[PLTableViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)selfDefinedLeftAction:(id)sender {
    PLCustomTableViewController *vc = [[PLCustomTableViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
