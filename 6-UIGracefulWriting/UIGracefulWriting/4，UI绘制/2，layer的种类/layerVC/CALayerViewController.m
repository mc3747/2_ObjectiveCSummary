//
//  CALayerViewController.m
//  LayerPlayerOc
//
//  Created by 武蕴 on 15/8/17.
//  Copyright (c) 2015年 WymanY. All rights reserved.
//

#import "CALayerViewController.h"
#import "CALayerControlsViewController.h"

@interface CALayerViewController ()
{
    CALayer *_layer;
    UIImage *_star;
}
@property (weak, nonatomic) IBOutlet UIView *viewForLayer;
@property (weak, nonatomic) IBOutlet UIView *pushView;


@end

@implementation CALayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //setup Layer
    [self setUpLayer];
    [_viewForLayer.layer addSublayer:_layer];
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 200)];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    

#pragma mark -  通过一个控制器里的view嵌入embed另一个控制器的形式，进行传参
    for (UIView *subview in _pushView.subviews) {
        if ([subview isKindOfClass:[UITableView class]]) {
           CALayerControlsViewController *vc =  (CALayerControlsViewController *)[self getCurrentVCWithCurrentView:subview];
            vc.layerViewController = self;
             NSLog(@"子控制器%@",vc);
        }
        
        NSLog(@"子元素%@",subview);
    };

}

- (UIViewController *)getCurrentVCWithCurrentView:(UIView *)currentView
{
    for (UIView *next = currentView ; next ; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)setUpLayer
{
    //initlize
    _layer = [CALayer layer];
    _star = [UIImage imageNamed:@"star"];
    
    //set layer property
    _layer.frame = _viewForLayer.bounds;
    _layer.contents = (id)_star.CGImage;
    _layer.contentsGravity = @"center";
    _layer.geometryFlipped = NO;
    _layer.cornerRadius = 100.0;
    _layer.borderWidth = 12.0;
    _layer.backgroundColor = [UIColor greenColor].CGColor;
    _layer.borderColor = [UIColor whiteColor].CGColor;
    _layer.shadowOffset = CGSizeMake(0, 3);
    _layer.shadowOpacity = 0.7;
    _layer.shadowRadius = 3.0;
    _layer.magnificationFilter = kCAFilterLinear;
    
}





@end
