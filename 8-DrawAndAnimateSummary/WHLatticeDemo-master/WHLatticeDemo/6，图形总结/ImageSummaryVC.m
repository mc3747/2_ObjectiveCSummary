//
//  ImageSummaryVC.m
//  WHLatticeDemo
//
//  Created by gjfax on 2019/2/22.
//  Copyright © 2019 remember17. All rights reserved.
//

#import "ImageSummaryVC.h"
#import "UIImage+CornerRadius.h"
#import "DemoView1.h"
#import "DemoView2.h"
#import "DemoView3.h"
#import "DemoView4.h"
#import "DemoView5.h"
#import "DemoView6.h"

@interface ImageSummaryVC ()

@end

@implementation ImageSummaryVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    上下文
    NSArray *imageArray = @[[self getImage1],[self getImage2]];
    for (int i = 0; i<imageArray.count;i++) {
        UIImage *image = (UIImage *)imageArray[i];
         UIImage *newImage = [image roundedCornerImageWithCornerRadius:15.f];
         UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*50 + 10*i, 100, image.size.width, image.size.height)];
          
           imageView.image = newImage;
           [self.view addSubview:imageView];
        
    };
//   view中绘制
    NSArray *viewArray = @[[DemoView1 new],[DemoView2 new],[DemoView3 new],[DemoView4 new]];
    for (int i = 0; i<viewArray.count;i++) {
        UIView *view = viewArray[i];
        view.frame = CGRectMake(i*50+10*i, 160, 50, 50);
        [self.view addSubview:view];
    }
//  layer中绘制
    UIImage *image = [UIImage imageNamed:@"home_spring_bg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    NSArray *viewArray2 = @[imageView,[DemoView5 new],[DemoView6 new]];
      for (int i = 0; i<viewArray2.count;i++) {
          UIView *view = viewArray2[i];
          view.frame = CGRectMake(i*50+10*i, 220, 50, 50);
          [self.view addSubview:view];
      }


}

#pragma mark -  上下文：UIKit获取
-(UIImage *)getImage1{
    // 获取图片上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(50,50), NO, 0);
    // 绘图
    UIBezierPath* p = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,0,50,50)];
    [[UIColor blueColor] setFill];
    [p fill];
    // 从图片上下文中获取绘制的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭图片上下文
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark -  上下文：CoreGraphics获取
-(UIImage *)getImage2{
    // 获取图片上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(50,50), NO, 0);
    // 绘图
    CGContextRef con = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(con, CGRectMake(0,0,50,50));
    CGContextSetFillColorWithColor(con, [UIColor orangeColor].CGColor);
    CGContextFillPath(con);
    // 从图片上下文中获取绘制的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭图片上下文
    UIGraphicsEndImageContext();
    return image;
}


@end
