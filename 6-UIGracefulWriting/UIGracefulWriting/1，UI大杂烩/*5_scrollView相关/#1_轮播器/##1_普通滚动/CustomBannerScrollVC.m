//
//  CustomBannerScrollVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/4/9.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "CustomBannerScrollVC.h"
#import "CustomBannerScrollView.h"

@interface CustomBannerScrollVC ()

@end

@implementation CustomBannerScrollVC

- (void)viewDidLoad {
    [super viewDidLoad];
    CustomBannerScrollView *bannerView = [[CustomBannerScrollView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 150) ];
    [bannerView configPictures:@[@"0_full",@"1_full",@"2_full"]];
    [self.view addSubview:bannerView];
}


@end
