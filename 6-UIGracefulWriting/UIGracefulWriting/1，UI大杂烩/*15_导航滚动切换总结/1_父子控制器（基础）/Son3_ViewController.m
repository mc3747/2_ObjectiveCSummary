//
//  Son3_ViewController.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/9/6.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "Son3_ViewController.h"

@interface Son3_ViewController ()

@end

@implementation Son3_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LBRandomColor;
}

- (void)didMoveToParentViewController:(UIViewController *)parent
{
    [super didMoveToParentViewController:parent];
    
    NSLog(@"Son3_ViewController - 被添加到父控制器中 - %@", parent);
}

@end
