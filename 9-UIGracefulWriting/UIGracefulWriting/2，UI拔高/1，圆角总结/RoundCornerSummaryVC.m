//
//  RoundCornerSummary.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/5/5.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "RoundCornerSummaryVC.h"
#import "QQCornerViewController.h"
#import "EffectiveCornerVC.h"
#import "JMCornerViewController.h"

@interface RoundCornerSummaryVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;


@property (weak, nonatomic) IBOutlet UIImageView *imageView4;
@property (weak, nonatomic) IBOutlet UIImageView *imageView5;


@end

@implementation RoundCornerSummaryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testImage1];
    [self testImage2];
    [self testImageView1];
    [self testImageView2];
    [self testImageView3];
}
#pragma mark -  设置image
- (void)testImage1{
    self.imageView4.frame =CGRectMake(20, 50, 80, 80);
    self.imageView4.backgroundColor = [UIColor redColor];
   UIImage *image = [UIImage imageNamed:@"bookface.jpg"];
    self.imageView4.image = [self imageWithRoundedCornersSize:15.f usingImage:image];
}
- (void)testImage2{
      self.imageView5.frame =CGRectMake(120, 50, 80, 80);
     self.imageView5.backgroundColor = [UIColor redColor];
    UIImage *image = [UIImage imageNamed:@"bookface.jpg"];
    self.imageView5.image = [self makeRoundedImage:image radius:15.f];
}
#pragma mark -  设置imageView
//1，设置layer的cornerRadius和masksToBounds
-(void)testImageView1{
    self.imageView1.frame = CGRectMake(20, 50, 80, 80);
    _imageView1.image = [UIImage imageNamed:@"bookface.jpg"];
    //只需要设置layer层的两个属性
    //设置圆角
    _imageView1.layer.cornerRadius = _imageView1.frame.size.width / 2;
    //将多余的部分切掉
    _imageView1.layer.masksToBounds = YES;
}

//2，使用贝塞尔曲线UIBezierPath和Core Graphics框架画出一个圆角
-(void)testImageView2{
    self.imageView2.frame =CGRectMake(120, 50, 80, 80);
    _imageView2.image = [UIImage imageNamed:@"bookface.jpg"];
    //开始对imageView进行画图
    UIGraphicsBeginImageContextWithOptions(_imageView2.bounds.size, NO, 1.0);
    //使用贝塞尔曲线画出一个圆形图
    [[UIBezierPath bezierPathWithRoundedRect:_imageView2.bounds cornerRadius:_imageView2.frame.size.width] addClip];
    [_imageView2 drawRect:_imageView2.bounds];
    _imageView2.image = UIGraphicsGetImageFromCurrentImageContext();
    //结束画图
    UIGraphicsEndImageContext();
}

//3，使用UIBezierPath和CAShapeLayer设置圆角：性能最高
-(void)testImageView3{
    self.imageView3.frame = CGRectMake(220, 50, 80, 80);
    self.imageView3.image = [UIImage imageNamed:@"bookface.jpg"];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.imageView3.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(25, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.imageView3.bounds;
    maskLayer.path = maskPath.CGPath;
    self.imageView3.layer.mask = maskLayer;
}

#pragma mark -  第三方示例
- (IBAction)test1:(id)sender {
    QQCornerViewController *vc = [QQCornerViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)test2:(id)sender {
    EffectiveCornerVC *vc = [EffectiveCornerVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)test3:(id)sender {
    JMCornerViewController *vc = [JMCornerViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark -  处理image圆角的方法
//方法1
- (UIImage *)imageWithRoundedCornersSize:(float)cornerRadius usingImage:(UIImage *)original
{
    CGRect frame = CGRectMake(0, 0, original.size.width, original.size.height);
    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContextWithOptions(original.size, NO, 1.0);
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:frame
                                cornerRadius:cornerRadius] addClip];
    // Draw your image
    [original drawInRect:frame];
    // Retrieve and return the new image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//方法2
-(UIImage *)makeRoundedImage:(UIImage *) image
                      radius: (float) radius;
{
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    imageLayer.contents = (id) image.CGImage;
    
    imageLayer.masksToBounds = YES;
    imageLayer.cornerRadius = radius;
    
    UIGraphicsBeginImageContext(image.size);
    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return roundedImage;
}
@end
