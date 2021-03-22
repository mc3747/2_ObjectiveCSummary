//
//  ImageCacheVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/5/5.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "ImageCacheVC.h"
#import "MemoryAndDiskCacheVC.h"
#import "MemoryAndDiskCachePackageVC.h"
@interface ImageCacheVC ()

@end

@implementation ImageCacheVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark -  基本思路
- (IBAction)testAction1:(id)sender {
    MemoryAndDiskCacheVC *vc = [MemoryAndDiskCacheVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -  小封装
- (IBAction)testAction2:(id)sender {
    MemoryAndDiskCachePackageVC *vc = [MemoryAndDiskCachePackageVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
//常见的内存缓存有NSCache、TMMemoryCache、PINMemoryCache、YYMemoryCache。常见的磁盘缓框架存有TMDiskCache、PINDiskCache、YYCache。
#pragma mark -  系统缓存方案NSURLCache

#pragma mark -  内存缓存:模型缓存，懒加载

#pragma mark -  硬盘缓存:沙盒缓存

#pragma mark -  第三方缓存方案：SD，YY，AFN

@end
