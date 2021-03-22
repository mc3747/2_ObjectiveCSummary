//
//  CALayerAnimationVC.m
//  WHLatticeDemo
//
//  Created by gjfax on 2018/11/6.
//  Copyright © 2018 remember17. All rights reserved.
//

#import "CALayerAnimationVC.h"


@interface CALayerAnimationVC ()

@end

@implementation CALayerAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)hiddenAnimateAction:(id)sender {
}

- (IBAction)baseAnimateAction:(id)sender {
    [self pushVC:@"BaseAnimationController"];
}
- (IBAction)keyFrameAnimateAction:(id)sender {
    [self pushVC:@"KeyFrameAnimationController"];
}

- (IBAction)groupAnimateAction:(id)sender {
    [self pushVC:@"GroupAnimationController"];
}
- (IBAction)transitionAnimateAction:(id)sender {
    [self pushVC:@"TransitionAnimationController"];
}

- (IBAction)exampleAnimateAction:(id)sender {
    [self pushVC:@"ComprehensiveCaseController"];
}

#pragma mark -  通用push方法
- (void)pushVC:(NSString *)vcName {
    Class class = NSClassFromString(vcName);
    if (class) {
        UIViewController *vc = [[class alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    
}

@end
