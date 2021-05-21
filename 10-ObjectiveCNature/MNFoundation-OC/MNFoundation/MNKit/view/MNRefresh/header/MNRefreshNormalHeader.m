//
//  MNRefreshNormalHeader.m
//  MNKit
//
//  Created by Vincent on 2019/4/20.
//  Copyright © 2019 Vincent. All rights reserved.
//

#import "MNRefreshNormalHeader.h"

@interface MNRefreshNormalHeader ()
@property (nonatomic, weak) UIView *rotateView;
@property (nonatomic, weak) CAShapeLayer *rotateLayer;
@property (nonatomic, strong) UIBezierPath *bezierPath;
@end

#define MNRefreshRotateSize     20.f

@implementation MNRefreshNormalHeader
#pragma mark - 懒加载
- (UIBezierPath *)bezierPath {
    if (!_bezierPath) {
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:self.rotateLayer.center_mn
                                                            radius:MEAN(self.rotateLayer.width_mn)
                                                        startAngle:M_PI_2
                                                          endAngle:M_PI*2 + M_PI_2
                                                         clockwise:YES];
        _bezierPath = bezierPath;
    }
    return _bezierPath;
}

- (CAShapeLayer *)rotateLayer {
    if (!_rotateLayer) {
        CAShapeLayer *rotateLayer = [CAShapeLayer layer];
        rotateLayer.fillColor = [[UIColor clearColor] CGColor];
        rotateLayer.strokeColor = [[UIColor darkTextColor] CGColor];
        rotateLayer.lineWidth = 1.f;
        rotateLayer.lineCap = kCALineCapRound;
        rotateLayer.strokeStart = 0.f;
        rotateLayer.strokeEnd = 0.f;
        [self.layer addSublayer:_rotateLayer = rotateLayer];
    }
    return _rotateLayer;
}

#pragma mark - 重写父类的方法
- (void)prepare {
    [super prepare];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 1.2f;
    animation.toValue = @(M_PI*2.f);
    animation.autoreverses = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.repeatCount = FLT_MAX;
    animation.beginTime = CACurrentMediaTime();
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    //[self.rotateLayer removeAllAnimations];
    self.rotateLayer.size_mn = CGSizeMake(MNRefreshRotateSize, MNRefreshRotateSize);
    self.rotateLayer.path = self.bezierPath.CGPath;
    //[self.rotateLayer addAnimation:animation forKey:nil];
    //[self.rotateLayer pauseAnimation];
}

- (void)placeSubviews {
    [super placeSubviews];
    self.rotateLayer.center_mn = self.bounds_center;
    /*
    self.rotateLayer.centerX_mn = self.width_mn/2.f;
    self.rotateLayer.bottom_mn = self.height_mn - 15.f;
     */
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    
    CGFloat offsetY = [change[NSKeyValueChangeNewKey] CGPointValue].y;
    //CGFloat oldOffsetY = [change[NSKeyValueChangeOldKey] CGPointValue].y;
    
    if (offsetY <= -self.rotateLayer.top_mn && offsetY >= -self.height_mn) {
        if (self.state == MJRefreshStateIdle) {
            //NSLog(@"%.2f----%.2f",offsetY, fabs(self.height_mn - fabs(offsetY)));
            CGFloat ra = fabs(self.height_mn - fabs(offsetY))/self.rotateLayer.bottom_mn;
            //NSLog(@"%.2f",ra);
            self.rotateLayer.strokeEnd = (1.f- ra);
        }
    }
    
}

@end
