//
//  NotEquelCellHeightVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/4/15.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "NotEquelCellHeightVC.h"

@interface NotEquelCellHeightVC ()

@end

@implementation NotEquelCellHeightVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    AsyncDisplayKit改成了Texture，暂未处理
    self.vcNameArray = @[@[@"AutolayoutTableViewController",
                           @"CountHeightTableViewController",
                           @"FrameCountTableViewController",
                           @"YYKitTableViewController",
                           @"",]];
    
    self.subtitleArray = @[@[@"autolay方式",
                             @"countHeight方式",
                             @"Frame方式",
                             @"YYKit方式",
                             @"AsyncDisplayKit方式"
                             ]];
    
}



@end
