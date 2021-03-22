//
//  BlockDemo2VC.m
//  排序总结
//
//  Created by gjfax on 2020/1/10.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "BlockDemo2VC.h"

@interface callbackBlock : NSObject
- (void)beginTask:(void(^)(void))callbackBlock;
@end

@implementation callbackBlock
- (void)beginTask:(void(^)(void))callbackBlock {
    NSLog(@"任务开始");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    NSLog(@"任务执行");
        callbackBlock();
    NSLog(@"任务已经结束");
    });
}
@end

@interface BlockDemo2VC ()

@end

@implementation BlockDemo2VC

- (void)viewDidLoad {
    [super viewDidLoad];
    callbackBlock *callback = [[callbackBlock alloc] init];
     [callback beginTask:^{
         NSLog(@"任务完成");
     }];
}


@end
