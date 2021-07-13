//
//  ArchitectureVC.m
//  排序总结
//
//  Created by kk on 2021/4/6.
//  Copyright © 2021 macheng. All rights reserved.
//

#import "ArchitectureVC.h"
#import "MJNewsViewController.h"
@interface ArchitectureVC ()

@end

@implementation ArchitectureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)action1:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MJNewsViewController" bundle:nil];
    UITableViewController *vc = [storyboard instantiateInitialViewController];
    
    [self.navigationController pushViewController:vc animated:true];
}
- (IBAction)action2:(id)sender {
    GJSPushViewControllerWithName(@"MVCViewController", @"MVC2", true);
}
- (IBAction)action3:(id)sender {
    GJSPushViewControllerWithName(@"MVPViewController", @"MVP", true);
}

- (IBAction)action4:(id)sender {
    GJSPushViewControllerWithName(@"MVVMViewController", @"MVVM1", true);
}

- (IBAction)action5:(id)sender {
    GJSPushViewControllerWithName(@"JNViewController", @"MVVM2", true);
}


@end
