//
//  ScreenShotVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/8/31.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "ScreenShotVC.h"
#import "TestPushVC.h"

@interface ScreenShotVC ()
@property (nonatomic, strong) UIView *shotView;
@property (nonatomic, strong) UIImage *shotImage;
@property (nonatomic, strong) UIImageView *shotImageView;
@end

@implementation ScreenShotVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"截屏反馈";
   
    
    UIView *testView1 = [[UIView alloc] initWithFrame:CGRectMake(40, 80, 50, 50)];
    testView1.backgroundColor =  [UIColor greenColor];
    testView1.tag = 22221;
     UITapGestureRecognizer *gesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeColor:)];
    [testView1 addGestureRecognizer:gesture1];
    [self.view addSubview:testView1];
    
    UIView *testView2 = [[UIView alloc] initWithFrame:CGRectMake(100, 80, 50, 50)];
    testView2.tag = 22222;
    testView2.backgroundColor =  [UIColor redColor];
    UITapGestureRecognizer *gesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeColor:)];
    [testView2 addGestureRecognizer:gesture2];
    [self.view addSubview:testView2];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userDidTakeScreenshot:)
                                                 name:UIApplicationUserDidTakeScreenshotNotification
                                               object:nil];
    
}
#pragma mark -改变颜色
- (void)changeColor:(UITapGestureRecognizer *)sender {
    if (sender.view.tag == 22221 || sender.view.tag == 22222) {
        sender.view.backgroundColor = [self RandomColor];
    };
}
#pragma mark - 用户截屏通知事件
- (void)userDidTakeScreenshot:(NSNotification *)notification {
    NSLog(@"检测到截屏");
//    _shotImage = [self yg_screenshot];
//    _shotImageView.image = _shotImage;
//
//    [self showShotScreen];
//
    [self getScreenshot:notification];
}


- (void)getScreenshot:(NSNotification *)notification{
    NSLog(@"捕捉截屏事件");
    
    //获取截屏图片
    UIImage *image = [UIImage imageWithData:[self imageDataScreenShot]];
    
    //显示图片
    UIImageView *imgV = [[UIImageView alloc]initWithImage:image];
    imgV.frame = [UIScreen mainScreen].bounds;
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    backView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.8];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [shareBtn setTintColor:[UIColor whiteColor]];
    shareBtn.frame = CGRectMake(SCREEN_WIDTH/5,SCREEN_HEIGHT ,SCREEN_WIDTH*3/5,50);
    [shareBtn.layer setMasksToBounds:YES];
    [shareBtn.layer setBorderWidth:1];
    shareBtn.layer.cornerRadius = 6;
    [shareBtn setTitle:@"分享给好友" forState:UIControlStateNormal];
    shareBtn.backgroundColor = [self RandomColor];
    [shareBtn addTarget:self action:@selector(shareBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [backView addSubview:imgV];
    [backView addSubview:shareBtn];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:backView];
    
    [UIView animateWithDuration:0.5 animations:^{
        imgV.transform = CGAffineTransformMakeScale(0.8, 0.8);
        shareBtn.transform = CGAffineTransformMakeTranslation(0, -50);
    }];
    //3秒后消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [backView removeFromSuperview];
    });
}
- (NSData *)imageDataScreenShot
{
    CGSize imageSize = CGSizeZero;
    imageSize = [UIScreen mainScreen].bounds.size;
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        }
        else
        {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return UIImagePNGRepresentation(image);
}

-(void)shareBtn:(UIButton *)sender{
    
    NSLog(@"分享");
}

#pragma mark -  截屏的图
- (UIImage *)yg_screenshot {
    
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
    //     [TOP_VIEW.layer renderInContext:UIGraphicsGetCurrentContext()]; // 此方法，除却iOS8以外其他系统都OK
    [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:NO];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);//数值 0 - 1 之间
    image = [UIImage imageWithData:imageData];
    return image;
}

#pragma mark -  展示截屏
- (void)showShotScreen {
    [UIView animateWithDuration:0.2f animations:^{
        self.shotView.hidden = NO;
    }];
    [self performSelector:@selector(hideShotScreen) withObject:nil afterDelay:5.f];
}

#pragma mark -  隐藏截屏
- (void)hideShotScreen {
    self.shotView.hidden = YES;
}
#pragma mark -  点击跳转
- (void)tapToJump {
    [self hideShotScreen];
    TestPushVC *vc = [[TestPushVC alloc] init];
    vc.image = _shotImage;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -  截屏view
- (UIView *)shotView
{
    if (!_shotView) {
        _shotView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 120, ([UIScreen mainScreen].bounds.size.height - 200) / 2.f, 100, 200)];
        _shotView.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToJump)];
        [_shotView addGestureRecognizer:gesture];
        [self.view addSubview:_shotView];
        
        // 手动截取当前屏幕图片
        _shotImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 150)];
        _shotImageView.image = _shotImage;
        [_shotView addSubview:_shotImageView];
        
        // 底部文字
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 160, 100, 40)];
        textLabel.text = @"点击反馈";
        textLabel.textColor = [UIColor whiteColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        [_shotView addSubview:textLabel];
    }
    
    return _shotView;
}

#pragma mark -  随机色
- (UIColor *)RandomColor {
    NSInteger aRedValue = arc4random() % 255;
    NSInteger aGreenValue = arc4random() % 255;
    NSInteger aBlueValue = arc4random() % 255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue / 255.0f green:aGreenValue / 255.0f blue:aBlueValue / 255.0f alpha:1.0f];
    return randColor;
}

@end
