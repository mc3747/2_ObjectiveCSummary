//
//  ViewController.m
//  Interview04-MVC-Apple
//
//  Created by MJ Lee on 2018/7/17.
//  Copyright © 2018年 MJ Lee. All rights reserved.
//

#import "MVVMViewController.h"
#import "MJAppViewModel.h"

@interface MVVMViewController ()
@property (strong, nonatomic) MJAppViewModel *viewModel;
@end

@implementation MVVMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewModel = [[MJAppViewModel alloc] initWithController:self];
}

@end
