//
//  NineGridUsingFrameVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/10/30.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "NineGridUsingFrameVC.h"
#import "NineGridFrameView.h"

@interface NineGridUsingFrameVC ()

@end

@implementation NineGridUsingFrameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *picArray = [NSMutableArray array];
    for (int i = 0; i < 16; i++) {
        NSString *imageName = [NSString stringWithFormat:@"test_%d",i];
        [picArray addObject:imageName];
    }
    NineGridFrameView *view = [[NineGridFrameView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT - 100) imageArray:picArray];
    view.indexPathBlock = ^(NSString * _Nonnull row, NSString * _Nonnull col) {
        
        MCLog(@"%@%@",FMT_STR(@"第%@行",row), FMT_STR(@"第%@列",col));
        
    };
    [self.view addSubview:view];
}



@end
