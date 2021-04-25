//
//  Son1_ViewController.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/9/6.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "Son1_ViewController.h"

@interface Son1_ViewController ()

@end

@implementation Son1_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LBRandomColor;
    
}

- (void)didMoveToParentViewController:(UIViewController *)parent
{
    [super didMoveToParentViewController:parent];
    
    NSLog(@"Son1_ViewController - 被添加到父控制器中 - %@", parent);
}

@end
