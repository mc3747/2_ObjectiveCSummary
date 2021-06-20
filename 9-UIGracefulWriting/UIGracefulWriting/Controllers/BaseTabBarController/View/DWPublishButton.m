//
//  DWPublishButton.m
//  DWCustomTabBarDemo
//
//  Created by Damon on 10/20/15.
//  Copyright © 2015 damonwong. All rights reserved.
//

#import "DWPublishButton.h"
#import "OverlayWindow.h"

@interface DWPublishButton ()<UIActionSheetDelegate>

@end

@implementation DWPublishButton


#pragma mark -
#pragma mark - Private Methods

//上下结构的 button
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 控件大小,间距大小
    CGFloat const imageViewEdge   = self.bounds.size.width * 0.6;
    CGFloat const centerOfView    = self.bounds.size.width * 0.5;
    CGFloat const labelLineHeight = self.titleLabel.font.lineHeight;
    CGFloat const verticalMarginT = self.bounds.size.height - labelLineHeight - imageViewEdge;
    CGFloat const verticalMargin  = verticalMarginT / 2;
    
    // imageView 和 titleLabel 中心的 Y 值
    CGFloat const centerOfImageView  = verticalMargin + imageViewEdge * 0.5;
    CGFloat const centerOfTitleLabel = imageViewEdge  + verticalMargin * 2 + labelLineHeight * 0.5 + 5;
    //imageView position 位置
    
    self.imageView.bounds = CGRectMake(0, 0, imageViewEdge, imageViewEdge);
    self.imageView.center = CGPointMake(centerOfView, centerOfImageView);
    
    //title position 位置
    
    self.titleLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, labelLineHeight);
    self.titleLabel.center = CGPointMake(centerOfView, centerOfTitleLabel);
    
}

#pragma mark -
#pragma mark - Life Cycle

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
    }
    
    return self;
}

#pragma mark -
#pragma mark - Public Methods

+(instancetype)publishButton{
    
    DWPublishButton *button = [[DWPublishButton alloc]init];
    
    [button setImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateNormal];
    [button setTitle:@"发布" forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:9.5];
    
    [button sizeToFit];
    
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
    
}


#pragma mark -
#pragma mark - Event Response

- (void)clickPublish {
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UIViewController *viewController = tabBarController.selectedViewController;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil
                                                            delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"1，弹框UI调试-苹果开源", @"2，浮球-双击状态栏", @"3，显示日志-见importPoints的app",
                                                        @"4，滴滴开源的DoraemonKit-见大厂的app",
                                  @"5，美图开源的MTHawkeye",
                                  @"6，陈奕龙的GodEye-swift写的",
                                  @"7,Flex工具-老外写的",
                                  nil];
    [actionSheet showInView:viewController.view];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"buttonIndex = %ld", buttonIndex);
    if (buttonIndex == 0) {
#if DEBUG
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        if (@available(iOS 11.0, *)) {
            // Simulate two finger click status bar events
            // 模拟两个手指点击状态栏的事件
            id overlayClass = NSClassFromString(@"UIDebuggingInformationOverlay");
            [overlayClass performSelector:NSSelectorFromString(@"overlay")];
            id handlerClass = NSClassFromString(@"UIDebuggingInformationOverlayInvokeGestureHandler");
            
            id handler = [handlerClass performSelector:NSSelectorFromString(@"mainHandler")];
            [handler performSelector:NSSelectorFromString(@"_handleActivationGesture:") withObject:[[OverlayWindow alloc] init]];
        } else {
            id overlayClass = NSClassFromString(@"UIDebuggingInformationOverlay");
            id overlay = [overlayClass performSelector:NSSelectorFromString(@"overlay")];
            [overlay performSelector:NSSelectorFromString(@"toggleVisibility")];
        };
#pragma clang diagnostic pop
#endif

    }else if(buttonIndex == 1){
        
    }else{
        
    }
}


@end
