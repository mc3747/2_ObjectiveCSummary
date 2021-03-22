//
//  AppDelegate+LaunchView.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/9/28.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "AppDelegate+LaunchView.h"
#import "WCYADImageView.h"

@implementation AppDelegate (LaunchView)
#pragma mark -  设置启动图片
-(void)initLaunchView:(UIApplication *)application WithOption:(NSDictionary *)launchOptions {
    WCYADImageView *adView = [[WCYADImageView alloc] init];
    adView.duration = 5;
    adView.waitTime = 0.5f;
    adView.skipType = SkipButtonTypeCircleAnimationTest;
    [adView reloadAdImageWithUrl: @"http://s8.mogucdn.com/p2/170223/28n_4eb3la6b6b0h78c23d2kf65dj1a92_750x1334.jpg"];
    adView.adImageTapBlock = ^(NSString *content) {
        NSLog(@"%@", content);
        
        // 判断非空后跳转
        if (content.length !=0) {
            // 一般是跳转h5页面。
            //        SMNewWebBridgeController *vc = [[SMNewWebBridgeController alloc] init];
            //        vc.loadUrl = content;
            //        vc.hidesBottomBarWhenPushed = YES;
            
            NSLog(@"跳转了");
        }
        
    };
    
    [self.window addSubview:adView];
}
@end
