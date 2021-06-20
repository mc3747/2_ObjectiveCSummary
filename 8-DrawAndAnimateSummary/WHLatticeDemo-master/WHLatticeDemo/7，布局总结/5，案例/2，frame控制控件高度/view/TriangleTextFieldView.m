//
//  TriangleTextFieldView.m
//  WHLatticeDemo
//
//  Created by gjfax on 2019/12/13.
//  Copyright © 2019 remember17. All rights reserved.
//

#import "TriangleTextFieldView.h"
@interface TriangleTextFieldView()
@property (nonatomic, strong) UITextField  *textField;
@property (nonatomic, strong) UIView *triangleView;
@property (nonatomic, strong) UILabel      *warningLabel;
@end

@implementation TriangleTextFieldView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addTextFieldWithFrame:frame];
        [self addTriangleViewWithFrame:frame];
        [self addTipsViewWithFrame:frame];
    }
    return self;
}

-(void)addTextFieldWithFrame:(CGRect)frame{
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    textField.backgroundColor = [UIColor greenColor];
    textField.placeholder = @"测试";
    textField.keyboardType = UIKeyboardTypeNumberPad;
     [self addSubview:textField];
    _textField = textField;
}

-(void)addTriangleViewWithFrame:(CGRect)frame{
       UIView *triangleView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(frame) - 10, CGRectGetWidth(frame), 10)];
       CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
       shapeLayer.strokeColor = [UIColor redColor].CGColor;
       shapeLayer.lineWidth = 1.0f;
       shapeLayer.fillColor  = [UIColor redColor].CGColor;
       //定义画图的path
       UIBezierPath *path = [[UIBezierPath alloc] init];
       CGPoint point1 = CGPointMake(40, 0);
       CGPoint point2 = CGPointMake(47, 10);
       CGPoint point3 = CGPointMake(33, 10);
       //path移动到开始画图的位置
       [path moveToPoint:point1];
       [path addLineToPoint:point2];
       [path addLineToPoint:point3];
       //关闭path
       [path closePath];
       //三角形内填充颜色
       shapeLayer.path = path.CGPath;
       [triangleView.layer addSublayer:shapeLayer];
       [self addSubview:triangleView];
       _triangleView = triangleView;
       _triangleView.hidden = YES;
}
-(void)addTipsViewWithFrame:(CGRect)frame{
       UILabel *warningLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height, frame.size.width, 30)];
       warningLabel.backgroundColor = [UIColor blueColor];
       warningLabel.textColor = [UIColor orangeColor];
       warningLabel.numberOfLines = 2;
       warningLabel.alpha = 1;
       warningLabel.font = [UIFont systemFontOfSize:14.f];
       [self addSubview:warningLabel];
       _warningLabel = warningLabel;
        _warningLabel.hidden = YES;
}

-(void)showWarning:(NSString *)warning{
    WeakSelf;
    weakSelf.frame = CGRectMake(weakSelf.frame.origin.x, weakSelf.frame.origin.y, weakSelf.frame.size.width, weakSelf.frame.size.height + 30);
      [self setNeedsLayout];
    
    [UIView animateWithDuration:0.3 animations:^{

        weakSelf.triangleView.hidden = NO;
        weakSelf.warningLabel.hidden = NO;
        weakSelf.warningLabel.text = warning;
    }];
}

-(void)hideWarning{
    WeakSelf;
    weakSelf.frame = CGRectMake(weakSelf.frame.origin.x, weakSelf.frame.origin.y, weakSelf.frame.size.width, weakSelf.frame.size.height - 30);
      [self setNeedsLayout];
    [UIView animateWithDuration:0.3f animations:^{

        weakSelf.triangleView.hidden = YES;
        weakSelf.warningLabel.hidden = YES;
    }];
   
}
// =====================================================
/*
 自定义view frame改变，影响vc的2种方法
 1，view不变，vc触发控件后，再写一遍约束关系
 2，view改变frame后，调用setNeedsLayout，自动会调用控制器的viewDidLayoutSubviews
 3，view改变frame后，在view的layoutsubView中，强制调用vc的viewDidLayoutSubviews方法
 */
// =====================================================
//- (void)layoutSubviews {
//    [super layoutSubviews];
//    [[self viewController] viewDidLayoutSubviews];
//}
//
//- (UIViewController *)viewController {
//    for (UIView* next = [self superview]; next; next = next.superview) {
//        UIResponder *nextResponder = [next nextResponder];
//        if ([nextResponder isKindOfClass:[UIViewController class]]) {
//            return (UIViewController *)nextResponder;
//        }
//    }
//    return nil;
//}
@end
