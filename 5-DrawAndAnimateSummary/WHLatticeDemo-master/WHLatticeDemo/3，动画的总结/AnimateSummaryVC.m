//
//  AnimateSummaryVC.m
//  WHLatticeDemo
//
//  Created by gjfax on 2018/11/6.
//  Copyright © 2018 remember17. All rights reserved.
//

#import "AnimateSummaryVC.h"
#import "UIViewAnimationVC.h"
#import "CALayerAnimationVC.h"
#import "ThirdPartAnimationVC.h"
#import "RefreshAnimateVC.h"

@interface AnimateSummaryVC ()

@end

@implementation AnimateSummaryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)viewAnimateAction:(id)sender {
    UIViewAnimationVC *vc = [[UIViewAnimationVC alloc] initWithNibName:@"UIViewAnimationVC" bundle:nil];
    vc.title = @"UIView动画";
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)layerAnimateAction:(id)sender {
    CALayerAnimationVC *vc = [[CALayerAnimationVC alloc] initWithNibName:@"CALayerAnimationVC" bundle:nil];
       vc.title = @"CALayer核心动画";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)thirdPartAnimateAction:(id)sender {
    ThirdPartAnimationVC *vc = [[ThirdPartAnimationVC alloc] initWithNibName:@"ThirdPartAnimationVC" bundle:nil];
    vc.title = @"第三方动画";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)refreshAnimateAction:(id)sender {
    RefreshAnimateVC *vc = [[RefreshAnimateVC alloc] init];
    vc.title = @"刷新动画";
    [self.navigationController pushViewController:vc animated:YES];
}



@end
