//
//  CalculateImageStorageVC.m
//  排序总结
//
//  Created by gjfax on 2018/11/12.
//  Copyright © 2018 macheng. All rights reserved.
//

#import "CalculateImageStorageVC.h"
#import "PhonoAlertTool.h"


@interface CalculateImageStorageVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *imageStorageLabel;
@property (weak, nonatomic) IBOutlet UILabel *testStorageLabel;


@end

@implementation CalculateImageStorageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [_imageStorageLabel adjustsFontSizeToFitWidth];
    [_testStorageLabel adjustsFontSizeToFitWidth];
    
}

- (IBAction)addImageAction:(id)sender {
     __weak typeof (self)weakSelf = self;
    [PhonoAlertTool showInView:self imageBlock:^(UIImage *image, CGFloat imageBytes) {
        weakSelf.imageView.image = image;
        // 真实image的大小
        weakSelf.imageStorageLabel.text = [NSString stringWithFormat:@"图片真实大小：%@",[weakSelf returnDisplayWithBytes:imageBytes]];
        // 测试计算image的大小
        weakSelf.testStorageLabel.text =  [NSString stringWithFormat:@"图片测试大小：%@",[weakSelf calulateImageFile3:image]];
    }];
    
}

- (IBAction)deleteImageAction:(id)sender {
    _imageView.image = nil;
    _imageStorageLabel.text = @"图片真实大小：0.00M";
    _testStorageLabel.text = @"图片测试大小：0.00M";
}

#pragma mark -  1,UIImageJPEGRepresentation 和UIImagePNGRepresentation计算
- (NSString *)calulateImageFile1:(UIImage *)image {
    NSData *data = UIImagePNGRepresentation(image);
    data = UIImageJPEGRepresentation(image, 1.0);
    if (!data) {
        data = UIImagePNGRepresentation(image);//需要改成0.5才接近原图片大小，原因请看下文
    }
    double dataLength = [data length] * 1.0;
    return [NSString stringWithFormat:@"%@",[self returnDisplayWithBytes:dataLength]];
}

#pragma mark -  2,像素bitmap 格式：bitmap 格式是未压缩
- (NSString *)calulateImageFile2:(UIImage *)image {
    
    long perMBBytes = 1024*1024;
    CGImageRef cgimage = image.CGImage;
    size_t bpp = CGImageGetBitsPerPixel(cgimage);
    size_t bpc = CGImageGetBitsPerComponent(cgimage);
    size_t bytes_per_pixel = bpp / bpc;
    long lPixelsPerMB = perMBBytes/bytes_per_pixel;
    long totalPixel = CGImageGetWidth(image.CGImage)*CGImageGetHeight(image.CGImage);
    long totalFileMB = totalPixel  /lPixelsPerMB;
    return [NSString stringWithFormat:@"%.2ldMB",totalFileMB];
}

#pragma mark -  afn估算图片的大小
- (NSString *)calulateImageFile3:(UIImage *)image {
    
    CGSize imageSize = CGSizeMake(image.size.width * image.scale, image.size.height * image.scale);
    CGFloat bytesPerPixel = 4.0;
    CGFloat bytesPerSize = imageSize.width * imageSize.height;
    CGFloat totalBytes = (UInt64)bytesPerPixel * (UInt64)bytesPerSize / (1024.0 * 1024.0);
    return [NSString stringWithFormat:@"%.2ldMB",(unsigned long)totalBytes];
}

#pragma mark -  网络图片的size
- (CGSize)getImageSizeWithURL:(NSURL *)url
{
    NSURL * mUrl = nil;
    if ([url isKindOfClass:[NSURL class]]) {
        mUrl = url;
    }
    if (!mUrl) {
        return CGSizeZero;
    }
    
    CGFloat width = 0, height = 0;
    CGImageSourceRef imageSourceRef = CGImageSourceCreateWithURL((CFURLRef)mUrl, NULL);
    if (imageSourceRef) {
        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, NULL);
        if (imageProperties != NULL) {
            CFNumberRef widthNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat64Type, &width);
            }
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat64Type, &height);
            }
            CFRelease(imageProperties);
        }
        CFRelease(imageSourceRef);
    }
    return CGSizeMake(width, height);
}

#pragma mark -  网络图片的存储大小
- (CGFloat)getImageFileSizeWithURL:(NSURL *)url
{
    NSURL *mUrl = nil;
    if ([url isKindOfClass:[NSURL class]]) {
        mUrl = url;
    }
    if (!mUrl) {
        return 0.0f;
    }
    
    CGFloat fileSize = 0;
    CGImageSourceRef imageSourceRef = CGImageSourceCreateWithURL((CFURLRef)mUrl, NULL);
    if (imageSourceRef) {
        CFDictionaryRef imageProperties = CGImageSourceCopyProperties(imageSourceRef, NULL);
        if (imageProperties != NULL) {
            CFNumberRef fileSizeNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyFileSize);
            if (fileSizeNumberRef != NULL) {
                CFNumberGetValue(fileSizeNumberRef, kCFNumberFloat64Type, &fileSize);
            }
            CFRelease(imageProperties);
        }
        CFRelease(imageSourceRef);
    }
    return fileSize;
}

#pragma mark -  根据bytes返回显示内容
- (NSString *)returnDisplayWithBytes:(CGFloat )bytes {
    
    NSArray *typeArray = @[@"bytes",@"KB",@"MB",@"GB",@"TB",@"PB", @"EB",@"ZB",@"YB"];
    NSInteger index = 0;
    while (bytes > 1024) {
        bytes /= 1024.0;
        index ++;
    }
    return [NSString stringWithFormat:@"%.2f%@",bytes,typeArray[index]];
}
@end
