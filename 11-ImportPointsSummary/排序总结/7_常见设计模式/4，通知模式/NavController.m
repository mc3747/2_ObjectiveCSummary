//
//  NavController.m
//  通知
//
//  Created by gjfax on 16/7/6.
//  Copyright © 2016年 macheng. All rights reserved.
//

#import "NavController.h"

@implementation NavController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goodbye:) name:@"goodbye" object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(welcome:) name:@"welcome" object:nil];
    
    
}

- (void)goodbye:(NSNotification *)notification {
    NSLog(@"nav say goodbye");
    
}

- (void)welcome:(NSNotification *)notification {
    NSLog(@"nav say welcome");
    
}

// 移除通知
//- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}

@end
