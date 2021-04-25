//
//  CAScrollLayerVC.m
//  WHLatticeDemo
//
//  Created by gjfax on 2018/11/6.
//  Copyright © 2018 remember17. All rights reserved.
//

#import "CAScrollLayerVC.h"
#import "PDScrollView.h"

@interface CAScrollLayerVC ()

@end

@implementation CAScrollLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PDScrollView *scrollView = [[PDScrollView alloc] initWithFrame:CGRectMake(50, 100, 200, 200)];
    scrollView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:scrollView];
    
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    subView.backgroundColor = [UIColor redColor];
    [scrollView addSubview:subView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
