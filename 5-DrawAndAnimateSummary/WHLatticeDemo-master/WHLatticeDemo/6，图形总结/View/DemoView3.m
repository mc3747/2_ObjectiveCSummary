//
//  DemoView3.m
//  WHLatticeDemo
//
//  Created by gjfax on 2019/12/20.
//  Copyright © 2019 remember17. All rights reserved.
//

#import "DemoView3.h"

@implementation DemoView3



-(void)drawRect:(CGRect)rect{

    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth = 2;
    layer.lineCap = kCALineCapRound;
    [self.layer addSublayer:layer];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.bounds.size.width/2];
    layer.path = path.CGPath;
}



@end
