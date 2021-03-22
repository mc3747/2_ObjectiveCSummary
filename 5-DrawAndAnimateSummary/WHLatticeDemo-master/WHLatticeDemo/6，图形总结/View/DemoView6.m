//
//  DemoView6.m
//  WHLatticeDemo
//
//  Created by gjfax on 2019/12/20.
//  Copyright © 2019 remember17. All rights reserved.
//

#import "DemoView6.h"

@implementation DemoView6


- (void)drawRect:(CGRect)rect {
    UIImage* image=[UIImage imageNamed:@"home_spring_bg"];
    CALayer *ly=[CALayer layer];
    ly.frame=rect;
    ly.contents=(__bridge id _Nullable)(image.CGImage);
    [self.layer addSublayer:ly];
}


@end
