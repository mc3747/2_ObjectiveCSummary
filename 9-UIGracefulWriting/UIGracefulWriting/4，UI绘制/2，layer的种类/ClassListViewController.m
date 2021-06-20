//
//  ClassListViewController.m
//  LayerPlayerOc
//
//  Created by 武蕴 on 15/8/17.
//  Copyright (c) 2015年 WymanY. All rights reserved.
//

#import "ClassListViewController.h"
#import "CALayerViewController.h"

//  随机色
#define RandColor RGBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

//  颜色
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

 /*
  ## CAShapeLayer
  
  `CAShapeLayer`是一个通过矢量图形而不是bitmap来绘制的图层子类。你指定诸如颜色和线宽等属性，用CGPath来定义想要绘制的图形，最后'CAShapeLayer'就自动渲染出来了
  
  
  ## CATextLayer
  
  它以图层的形式包含了`UILabel`几乎所有的绘制特性，并且额外提供了一些新的特性。同样，`CATextLayer`也要比UILabel渲染得快得多。很少有人知道在iOS 6及之前的版本，`UILabel`其实是通过WebKit来实现绘制的，这样就造成了当有很多文字的时候就会有极大的性能压力。而`CATextLayer`使用了Core text，并且渲染得非常快。
  
  
  ## CATransformLayer
  
  `CATransformLayer`不同于普通的`CALayer`，因为它不能显示它自己的内容。只有当存在了一个能作用域子图层的变换它才真正存在。`CATransformLayer`并不平面化它的子图层，所以它能够用于构造一个层级的3D结构，比如我的手臂示例
  
  
  ## CAGradientLayer
  
  `CAGradientLayer`是用来生成两种或更多颜色平滑渐变的。用Core Graphics复制一个`CAGradientLayer`并将内容绘制到一个普通图层的寄宿图也是有可能的，但是'CAGradientLayer'的真正好处在于绘制使用了硬件加速。
  
  
  ## CAReplicatorLayer
  
  `CAReplicatorLayer`的目的是为了高效生成许多相似的图层。它会绘制一个或多个图层的子图层，并在每个复制体上应用不同的变换。
  
  
  ## CAScrollLayer
  
  `CAScrollLayer`有一个`-scrollToPoint:`方法，它自动适应bounds的原点以便图层内容出现在滑动的地方。注意，这就是它做的所有事情。前面提到过，Core Animation并不处理用户输入，所以`CAScrollLayer`并不负责将触摸事件转换为滑动事件，既不渲染滚动条，也不实现任何iOS指定行为例如滑动反弹（当视图滑动超多了它的边界的将会反弹回正确的地方
  
  
  ## CATiledLayer
  
  `CATiledLayer`为载入大图造成的性能问题提供了一个解决方案：将大图分解成小片然后将他们单独按需载入。
  
  
  ## CAEmitterLayer
  
  `CAEmitterLayer`是一个高性能的粒子引擎，被用来创建实时例子动画如：烟雾，火，雨等等这些效果。
  
  
  ## CAEAGLLayer
  
  苹果引入了一个新的框架叫做`GLKit`，它去掉了一些设置OpenGL的复杂性，提供了一个叫做`CLKView`的`UIView`的子类，帮你处理大部分的设置和绘制工作。前提是各种各样的OpenGL绘图缓冲的底层可配置项仍然需要你用`CAEAGLLayer`完成，它是`CALayer`的一个子类，用来显示任意的OpenGL图形。
  */
@interface ClassListViewController ()
@property (nonatomic,strong) NSArray *classes;

@end

@implementation ClassListViewController

- (NSArray *)classes
{
    if (_classes == nil) {
        _classes = @[@[@"CALayer",@"Manage and animate visual content"],
                     @[@"CAScrollLayer",@"Display portion of a scrollable layer"],
                     @[@"CATextLayer",@"Render plain text or attributed strings"],
                     @[@"AVPlayerLayer",@"Display an AV player"],
                     @[@"CAGradientLayer",@"Apply a color gradient over the background"],
                     @[@"CAReplicatorLayer", @"Duplicate a source layer"],
                     @[@"CATiledLayer", @"Asynchronously draw layer content in tiles"],
                     @[@"CAShapeLayer", @"Draw using scalable vector paths"],
                     @[@"CAEAGLLayer", @"Draw OpenGL content"],
                     @[@"CATransformLayer", @"Draw 3D structures"],
                     @[@"CAEmitterLayer", @"Render animated particles"]
                     ];
    }
    return _classes;
}


- (void)viewDidLoad {
    [super viewDidLoad];
     [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ClassCell"];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.classes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassCell" forIndexPath:indexPath];
    cell.textLabel.text = self.classes[indexPath.row][0];
    cell.detailTextLabel.text = self.classes[indexPath.row][1];
    cell.imageView.image = [UIImage imageNamed:self.classes[indexPath.row][0]];
    
    return cell;
}

#pragma mark -uitableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identerfier = self.classes[indexPath.row][0];
    
    if ([@"CALayer" isEqualToString:identerfier]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ClassListViewController" bundle:nil];
        CALayerViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"CALayerViewController"];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else {
        NSString *className = [NSString stringWithFormat:@"%@VC",identerfier];
        Class class = NSClassFromString(className);
        if (class) {
            UIViewController *vc = [[class alloc] init];
            vc.view.backgroundColor = RandColor;
            vc.title = identerfier;
            [self.navigationController pushViewController:vc animated:YES];
        };

    }
}


@end
