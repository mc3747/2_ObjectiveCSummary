//
//  CreateQRCodeVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/2/21.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "CreateQRCodeVC.h"
#import "HTQRCodeCreater.h"

@interface CreateQRCodeVC ()
@property (nonatomic, weak) UIImageView *m_codeView;
@end

@implementation CreateQRCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addQRCode1];
    [self addQRCode2];
   
}

#pragma mark -  抽象
- (void)addQRCode1 {
    HTQRCodeCreater *qrCreater = [[HTQRCodeCreater alloc] init];
    UIImage *QRImage = [qrCreater createQRCodeWithUrlString:@"https://m.gjfax.com/activity/entry?gjsActivity=11&channel=87&trace_id=1&recommendNo=M2904&from=singlemessage&isappinstalled=0" qRCodeSize:180 centerLogo:[UIImage imageNamed:@"001"] logoSize:40];
    
    UIImageView *QRView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 180, 180)];
    QRView.image = QRImage;
    
    [self.view addSubview:QRView];
}

#pragma mark -  控制器中
- (void)addQRCode2 {
    // 1.创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复默认
    [filter setDefaults];
    
    // 3.给过滤器添加数据(正则表达式/账号和密码)
    NSString *dataString = @"https://m.gjfax.com/activity/entry?gjsActivity=11&channel=87&trace_id=1&recommendNo=M2904&from=singlemessage&isappinstalled=0";
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    
    // 4.获取输出的二维码
    CIImage *outputImage = [filter outputImage];
    
    
    // 5.显示二维码
    UIImageView *m_codeView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 300, 100, 100)];
    m_codeView.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:200];
    
    //6.添加长按手势
    UILongPressGestureRecognizer *gesture=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    gesture.minimumPressDuration=1.0f;
    gesture.numberOfTouchesRequired = 1;
    m_codeView.userInteractionEnabled=YES;
    [m_codeView addGestureRecognizer:gesture];
    
    [self.view addSubview:m_codeView];
    self.m_codeView = m_codeView;
}

- (void)longPress:(id)sender {
    NSLog(@"识别打印");
}
/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 */
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

@end
