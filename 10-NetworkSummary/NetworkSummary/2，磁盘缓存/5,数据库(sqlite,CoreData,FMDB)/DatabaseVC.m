//
//  DatabaseVC.m
//  NetworkSummary
//
//  Created by gjfax on 2018/11/15.
//  Copyright © 2018 macheng. All rights reserved.
//

#import "DatabaseVC.h"
#import "SqliteVC.h"
#import "CoreDataVC.h"
#import "FmdbVC_1.h"
#import "FmdbVC_2.h"
#import "FmdbPackageVC.h"
// =====================================================
/*
 FMDB和coreData区别：
 
 一、FMDB：用OC封装C语言SQLite3

 1.非苹果官方，第三方

 2.还是需要程序员编写SQL语句

 二、CoreData：用OC封装C语言SQLite3，相对FMDB来说较重量级

 1.苹果官方

 2.不需要程序员编写SQL语句。

 */
// =====================================================
@interface DatabaseVC ()

@end

@implementation DatabaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)sqliteAction:(id)sender {
    SqliteVC *vc = [[SqliteVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)CoreDataAction:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"CoreDataVC" bundle:nil];
    UIViewController *vc = [storyboard instantiateInitialViewController];
     [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)FmdbAction1:(id)sender {
    FmdbVC_1 *vc = [[FmdbVC_1 alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)FmdbAction2:(id)sender {
    FmdbVC_2 *vc = [[FmdbVC_2 alloc] initWithNibName:@"FmdbVC_2" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)FmdbPackageAction:(id)sender {
    FmdbPackageVC *vc = [[FmdbPackageVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
