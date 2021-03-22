//
//  ViewController.m
//  自定义控件
//
//  Created by gjfax on 16/6/3.
//  Copyright © 2016年 macheng. All rights reserved.
//

#import "PureXibViewController.h"
#import "PureXibCustomModel.h"
#import "PureXibCustomView.h"

@interface PureXibViewController ()

@end

@implementation PureXibViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LBRandomColor;
    PureXibCustomView *customView = [PureXibCustomView customViewShow];
    [customView setFrame:CGRectMake(100, 100, customView.frame.size.width, customView.frame.size.height)];
    PureXibCustomModel *customModel = [PureXibCustomModel modelWithlabel:@"单肩包" andImage:@"photo"];
    customView.model = customModel;
    [self.view addSubview:customView];
    
}

@end
