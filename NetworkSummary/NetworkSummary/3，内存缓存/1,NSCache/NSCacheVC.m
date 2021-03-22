//
//  NSCacheVC.m
//  NetworkSummary
//
//  Created by gjfax on 2020/3/18.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "NSCacheVC.h"

@interface NSCacheVC () <NSCacheDelegate>
@property (nonatomic ,strong) NSCache *cache;
@end
// =====================================================
/*
 NSCache的属性:
 countLimit:最多对象个数
 totalCostLimit:最大内存
 
 */
// =====================================================
@implementation NSCacheVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self beginCache];
    [self readCache];
    self.view.backgroundColor = [UIColor lightGrayColor];
}
//写入缓存
- (void)beginCache {
    NSLog(@"开始写入缓存");
    for (int i = 0; i<10; i++) {
        NSString *obj = [NSString stringWithFormat:@"object--%d",i];
        [self.cache setObject:obj forKey:@(i) cost:1];
        
    }
}
//读取缓存
-(void)readCache{
    NSLog(@"开始读取缓存");
    for(int i = 0 ; i < 10 ; i ++){
        
        NSData *data = [self.cache objectForKey:@(i)];
        
        NSLog(@"%@",data);
        
    }
}
#pragma mark - NSCacheDelegate

- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
    
    //evict : 驱逐
    //当代理对象即将从缓存中移除时激活
    NSLog(@"✅%@", [NSString stringWithFormat:@"%@ will be evict",obj]);
}


#pragma mark - Getter

- (NSCache *)cache {
    if (!_cache) {
        _cache = [NSCache new];
        //设置最大缓存数量：10
        _cache.countLimit = 10;
        //设置最大缓存cost：5M
        _cache.totalCostLimit = 5 * 1024 * 1024;
        _cache.delegate = self;
    }
    return _cache;
}

@end
