//
//  DimImageViewController.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/8/16.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "DimImageViewController.h"
#import "GPUImage.h"
#import <Accelerate/Accelerate.h>

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

@interface DimImageViewController ()
@property (nonatomic, strong) UIImageView *myImageView1;
@property (nonatomic, strong) UIImageView *myImageView2;
@property (nonatomic, strong) UIImageView *myImageView3;
@property (nonatomic, strong) UIImageView *myImageView4;
@property (nonatomic, strong) UIImageView *myImageView5;
@end

@implementation DimImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100 , 100, 50)];
    self.myImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 160 , 100, 50)];
    self.myImageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 220 , 100, 200)];
    self.myImageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 280 , 100, 50)];
    self.myImageView5 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 340 , 100, 50)];
    
    
    UIImage *image = [UIImage imageNamed:@"img1.jpg"];
/*
 *实现毛玻璃效果的两种方式
 */
//    [self toolbarStyle];
//
//    [self uivisualEffectViewStyle];
    
/*
 *实现高斯模糊效果的三种方式
 */
        self.myImageView3.image = [self coreBlurImage:image withBlurNumber:5];
    
    
//        self.myImageView4.image = [self GPUImageStyleWithImage:image];
//
//        self.myImageView5.image = [self boxblurImage:image withBlurNumber:5];
    
    [self.view addSubview:self.myImageView1];
    [self.view addSubview:self.myImageView2];
    [self.view addSubview:self.myImageView3];
    [self.view addSubview:self.myImageView4];
    [self.view addSubview:self.myImageView5];
}

#pragma mark 在iOS 7之前系统的类提供UIToolbar来实现毛玻璃效果
- (void)toolbarStyle{
    
    CGRect toolbarRect = CGRectMake(0, 0,ScreenW/2,ScreenH);
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:toolbarRect];
    /*
     * UIBarStyleDefault          = 0,
     * UIBarStyleBlack            = 1,
     * UIBarStyleBlackOpaque      = 1, // Deprecated. Use UIBarStyleBlack
     * UIBarStyleBlackTranslucent = 2, // Deprecated. Use UIBarStyleBlack and set the translucent property to YES
     */
    toolbar.barStyle = UIBarStyleBlack;
    
    [self.myImageView1 addSubview:toolbar];
}

#pragma mark 在iOS 8之后苹果新增加了一个类UIVisualEffectView，通过这个类来实现毛玻璃效果
- (void)uivisualEffectViewStyle{
    /* NS_ENUM_AVAILABLE_IOS(8_0)
     * UIBlurEffectStyleExtraLight,//额外亮度，（高亮风格）
     * UIBlurEffectStyleLight,//亮风格
     * UIBlurEffectStyleDark,//暗风格
     * UIBlurEffectStyleExtraDark __TVOS_AVAILABLE(10_0) __IOS_PROHIBITED __WATCHOS_PROHIBITED,
     * UIBlurEffectStyleRegular NS_ENUM_AVAILABLE_IOS(10_0), // Adapts to user interface style
     * UIBlurEffectStyleProminent NS_ENUM_AVAILABLE_IOS(10_0), // Adapts to user interface style
     
     */
    //实现模糊效果
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    //毛玻璃视图
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];;
    effectView.frame = CGRectMake(0, 0, ScreenW/2, ScreenH);
    
    [self.myImageView2 addSubview:effectView];
}

#pragma mark iOS5.0之后就出现了Core Image的API,Core Image的API被放在CoreImage.framework库中, 在iOS和OS X平台上，Core Image都提供了大量的滤镜（Filter），在OS X上有120多种Filter，而在iOS上也有90多(比较吃内存，渲染速度慢)
- (UIImage *)coreBlurImage:(UIImage *)image withBlurNumber:(CGFloat)blur{
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
    //设置filter
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:@(blur) forKey:@"inputRadius"];
    
    //模糊图片
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *blurImage = [UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    return blurImage;
    
}

#pragma mark GPUImage的开源库实现毛玻璃效果(比较吃内存,相对Core Image好一点)
- (UIImage *)GPUImageStyleWithImage:(UIImage *)image{
    
    GPUImageGaussianBlurFilter *filter = [[GPUImageGaussianBlurFilter alloc] init];
    filter.blurRadiusInPixels = 10.0;//值越大，模糊度越大
    UIImage *blurImage = [filter imageByFilteringImage:image];
    return blurImage;
    
}

#pragma mark vImage属于Accelerate.Framework，需要导入 Accelerate下的 Accelerate头文件， Accelerate主要是用来做数字信号处理、图像处理相关的向量、矩阵运算的库。图像可以认为是由向量或者矩阵数据构成的，Accelerate里既然提供了高效的数学运算API，自然就能方便我们对图像做各种各样的处理 ，模糊算法使用的是vImageBoxConvolve_ARGB8888这个函数。
- (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur
{
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef img = image.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    //设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if(error){
        NSLog(@"error from convolution %ld", error);
    }
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate( outBuffer.data, outBuffer.width, outBuffer.height, 8, outBuffer.rowBytes, colorSpace, kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up CGContextRelease(ctx)
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    return returnImage;
    
}

@end
