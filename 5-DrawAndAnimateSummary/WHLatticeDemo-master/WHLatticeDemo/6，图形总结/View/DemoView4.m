//
//  DemoView4.m
//  WHLatticeDemo
//
//  Created by gjfax on 2019/12/20.
//  Copyright © 2019 remember17. All rights reserved.
//

#import "DemoView4.h"

@implementation DemoView4


- (void)drawRect:(CGRect)rect {
      CAShapeLayer *layer = [CAShapeLayer layer];
      layer.strokeColor = [UIColor blueColor].CGColor;
      layer.fillColor = [UIColor clearColor].CGColor;
      layer.lineWidth = 2;
      layer.lineCap = kCALineCapRound;
      [self.layer addSublayer:layer];
    
    //Core Graphics
     CGMutablePathRef path = CGPathCreateMutable();
     CGPathAddRoundedRect(path, nil, self.bounds, self.bounds.size.width/2, self.bounds.size.height/2);
     CGPathCloseSubpath(path);
     layer.path = path;
     CGPathRelease(path);
}


@end
