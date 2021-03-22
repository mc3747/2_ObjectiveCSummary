//
//  ViewController.m
//  WHLatticeDemo
//
//  Created by 吴浩 on 2017/6/14.
//  Copyright © 2017年 remember17. All rights reserved.
//  https://github.com/remember17/WHLatticeDemo

#import "LayerBaseVC.h"
#import "DemoView.h"

@interface LayerBaseVC()<CALayerDelegate>
@property (nonatomic, weak) UIView *layerView;
@end
@implementation LayerBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *color = [UIColor colorWithRed:arc4random_uniform(256)/255.0
                                          green:arc4random_uniform(256)/255.0
                                           blue:arc4random_uniform(256)/255.0
                                          alpha:1.0];
    self.navigationController.navigationBar.barTintColor = color;
}

#pragma mark -  1，UIView和CALayer的基本显示
- (IBAction )testViewAndLayer1:(id)sender {
    UIView *layerView = [[UIView alloc] init];
    layerView.bounds = CGRectMake(0, 0, 200, 200);
    layerView.center = self.view.center;
    layerView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:layerView];
    
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    //add it to our view
    [layerView.layer addSublayer:blueLayer];
}

#pragma mark -  2，UIView和CALayer底层调用顺序
- (IBAction)testViewAndLayer2:(id)sender {
    DemoView *demoView = [[DemoView alloc] initWithFrame:CGRectMake(50, 100, 100, 50)];
    demoView.backgroundColor = [UIColor redColor];
    [self.view addSubview:demoView];
}

#pragma mark -  3，测试锚点
- (IBAction)testAnchopoint:(id)sender {
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(200, 200, 100, 100)];
    view1.backgroundColor = [UIColor redColor];
    UIView *subView1 = [[UIView alloc] initWithFrame:CGRectMake(80, 0, 20, 20)];
    subView1.backgroundColor = [UIColor orangeColor] ;
    [view1 addSubview:subView1];
    [self.view addSubview:view1];
    NSLog(@"view1❎：anchorPoint:%@  🍉 position:%@,🍉frame: %@",NSStringFromCGPoint(view1.layer.anchorPoint),NSStringFromCGPoint(view1.layer.position),NSStringFromCGRect(view1.frame));
    
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(200, 200, 100, 100)];
    view2.backgroundColor = [UIColor yellowColor];
    view2.layer.anchorPoint = CGPointMake(0, 0);
    //    view2.layer.position = CGPointMake(100, 100);
    UIView *subView2 = [[UIView alloc] initWithFrame:CGRectMake(80, 0, 20, 20)];
    subView2.backgroundColor = [UIColor brownColor];
    [view2 addSubview:subView2];
    [self.view addSubview:view2];
    NSLog(@"view2❎：anchorPoint:%@  🍉 position:%@,🍉frame: %@",NSStringFromCGPoint(view2.layer.anchorPoint),NSStringFromCGPoint(view2.layer.position),NSStringFromCGRect(view2.frame));
    
    
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(200, 200, 100, 100)];
    view3.backgroundColor = [UIColor greenColor];
    view3.layer.anchorPoint = CGPointMake(1, 1);
    //     view3.layer.position = CGPointMake(200, 200);
    UIView *subView3 = [[UIView alloc] initWithFrame:CGRectMake(80, 0, 20, 20)];
    subView3.backgroundColor = [UIColor blueColor];
    [view3 addSubview:subView3];
    [self.view addSubview:view3];
    NSLog(@"view3❎：anchorPoint:%@  🍉 position:%@,🍉frame: %@",NSStringFromCGPoint(view3.layer.anchorPoint),NSStringFromCGPoint(view3.layer.position),NSStringFromCGRect(view3.frame));
}



#pragma mark -  4，测试寄宿图1
/*
 寄宿图方法1：
 contents属性:图片
 contentGravity属性（对应UIView的contentMode）内容在图层的边界中怎么对齐：kCAGravityResizeAspect图层中等比例拉伸
 contentsScale属性：寄宿图的像素尺寸和视图大小的比例
 maskToBounds属性：对应UIView的clipsToBounds属性
 contentsRect属性(显示部分)：默认是{0, 0, 1, 1}，相对于寄宿图的尺寸的
 contentsCenter属性（拉伸压缩）：它定义了图层中的可拉伸区域和一个固定的边框，contentsCenter是{0, 0, 1, 1}，这意味着如果layer的大小改变了，那么寄宿图将会根据 contentsGravity 均匀地拉伸开
 
 */
- (IBAction)testLayerImage:(id)sender {
    for (int i = 0; i < 7; i++) {
        UIView *layerView = [[UIView alloc] init];
        layerView.frame = CGRectMake(100, 100 + 80 * i, 70, 70);
        layerView.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:layerView];
        
        UIImage *image = [UIImage imageNamed:@"tom1.png"];
        CALayer *blueLayer = [CALayer layer];
        blueLayer.frame = CGRectMake(10, 10, 50.0f, 50.0f);
        blueLayer.contents = (__bridge id)image.CGImage;
        [layerView.layer addSublayer:blueLayer];
        
        if (i == 1) {
            //
            blueLayer.contentsGravity = kCAGravityResize;
        }else if (i == 2) {
            //
            blueLayer.contentsScale = [UIScreen mainScreen].scale;
        }else if (i == 3) {
            blueLayer.contentsGravity = kCAGravityResizeAspect;
            blueLayer.contentsRect = CGRectMake(0, 0, 1, 1);
            
            UIImage *image2 = [UIImage imageNamed:@"tom2.png"];
            CALayer *blue2Layer = [CALayer layer];
            blue2Layer.frame = CGRectMake(35, 10, 25.0f, 25.0f);
            blue2Layer.contents = (__bridge id)image2.CGImage;
            [layerView.layer addSublayer:blue2Layer];
            blue2Layer.contentsGravity = kCAGravityResizeAspect;
            blue2Layer.contentsRect = CGRectMake(0, 0, 1, 1);

            UIImage *image3 = [UIImage imageNamed:@"tom3.png"];
            CALayer *blue3Layer = [CALayer layer];
            blue3Layer.frame = CGRectMake(10, 35, 25.0f, 25.0f);
            blue3Layer.contents = (__bridge id)image3.CGImage;
            [layerView.layer addSublayer:blue3Layer];
            blue3Layer.contentsGravity = kCAGravityResizeAspect;
            blue3Layer.contentsRect = CGRectMake(0, 0, 1, 1);
            
            UIImage *image4 = [UIImage imageNamed:@"tom4.png"];
            CALayer *blue4Layer = [CALayer layer];
            blue4Layer.frame = CGRectMake(35, 35, 25.0f, 25.0f);
            blue4Layer.contents = (__bridge id)image4.CGImage;
            [layerView.layer addSublayer:blue4Layer];
            blue4Layer.contentsGravity = kCAGravityResizeAspect;
            blue4Layer.contentsRect = CGRectMake(0, 0, 1, 1);
        }else if (i == 4) {
            blueLayer.contentsGravity = kCAGravityResizeAspect;
            blueLayer.contentsCenter = CGRectMake(0, 0, 0.5, 0.5);
        };
    };
    
}
#pragma mark -  5，测试寄宿图2
/*
 2，寄宿图方法2：遵守代理协议，绘制
 */
- (IBAction)testLayerImage2:(id)sender {
    //create sublayer
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(10,  10, 50, 50);
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    //set controller as layer delegate
    blueLayer.delegate = self;
    
    //ensure that layer backing image uses correct scale
    blueLayer.contentsScale = [UIScreen mainScreen].scale; //add layer to our view
    UIView *layerView = [[UIView alloc] init];
    layerView.frame = CGRectMake(200, 100 + 80 * 4, 70, 70);
    layerView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:layerView];
    [layerView.layer addSublayer:blueLayer];
    
    //force layer to redraw
    [blueLayer display];
}

//当需要被重绘时，CALayer会请求它的代理给它一个寄宿图来显示，
//-(void)displayLayer:(CALayer *)layer {
//
//}

//与上述方法，只能执行一个
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    //draw a thick red circle
    CGContextSetLineWidth(ctx, 10.0f);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}

/*
 寄宿图方法3,通过继承UIView并实现-drawRect:方法来自定义绘制
 外部调用-setNeedsDisplay

 */

@end
