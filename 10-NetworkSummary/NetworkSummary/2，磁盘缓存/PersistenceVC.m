//
//  PersistenceVC.m
//  NetworkSummary
//
//  Created by gjfax on 2018/10/9.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "PersistenceVC.h"

@interface PersistenceVC ()

@end

@implementation PersistenceVC

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)SandBoxPathAction:(id)sender {
    [self pushVCWithVCName:@"SandBoxVC" title:@"沙盒机制"];
}


- (IBAction)PlistFileAction:(id)sender {
     [self pushVCWithVCName:@"PlistFileVC" title:@"plist文件"];
}


- (IBAction)UserDefaultsAction:(id)sender {
     [self pushVCWithVCName:@"UserDefaultsVC" title:@"偏好设置"];
}


- (IBAction)ArchiveAction:(id)sender {
     [self pushVCWithVCName:@"ArchiveVC" title:@"归档"];
}


- (IBAction)DatabaseAction:(id)sender {
     [self pushVCWithVCName:@"DatabaseVC" title:@"数据库"];
}

- (IBAction)KeyChainAction:(id)sender {
    [self pushVCWithVCName:@"KeyChainViewController" title:@"KeyChain小案例"];
}
- (IBAction)keyChainBigDemo:(id)sender {
     [self pushVCWithVCName:@"JTAccountsViewController" title:@"KeyChain大案例"];
}


- (void)pushVCWithVCName:(NSString *)vcName title:(NSString *)vcTitle {
    NSString *className =  vcName;
    Class class = NSClassFromString(className);
    UIViewController *controller = [[class alloc] init];
    controller.title = vcTitle;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
