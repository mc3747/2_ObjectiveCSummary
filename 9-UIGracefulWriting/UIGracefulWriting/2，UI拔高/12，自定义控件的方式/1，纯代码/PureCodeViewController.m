//
//  ViewController.m
//  自定义控件
//
//  Created by gjfax on 16/6/3.
//  Copyright © 2016年 macheng. All rights reserved.
//

#import "PureCodeViewController.h"
#import "PureCodeCustomModel.h"
#import "PureCodeCustomView.h"

@interface PureCodeViewController ()

@end

@implementation PureCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LBRandomColor;
    PureCodeCustomView *customView = [[PureCodeCustomView alloc] initWithFrame:CGRectMake(100, 100, 67, 100)];
    PureCodeCustomModel *customModel = [PureCodeCustomModel modelWithlabel:@"单肩包" andImage:@"photo"];
    customView.model = customModel;
    [self.view addSubview:customView];
    
}

@end
