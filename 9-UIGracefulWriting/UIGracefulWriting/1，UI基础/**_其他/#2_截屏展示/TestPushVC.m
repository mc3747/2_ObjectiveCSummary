//
//  TestPushVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/8/31.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "TestPushVC.h"

@interface TestPushVC ()

@end

@implementation TestPushVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"截图跳转";
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIImageView *shotImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, 100, 100)];
    shotImageView.image = _image;
    [self.view addSubview:shotImageView];
}



@end
