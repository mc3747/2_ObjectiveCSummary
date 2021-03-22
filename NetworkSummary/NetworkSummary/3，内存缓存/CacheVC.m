//
//  CacheVC.m
//  NetworkSummary
//
//  Created by gjfax on 2018/10/9.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "CacheVC.h"
#import "NSCacheVC.h"

@interface CacheVC ()

@end

@implementation CacheVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"缓存";
}
- (IBAction)demo1:(id)sender {
    NSCacheVC *vc = [NSCacheVC new];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
