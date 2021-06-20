//
//  DemoView1.m
//  WHLatticeDemo
//
//  Created by gjfax on 2019/12/20.
//  Copyright © 2019 remember17. All rights reserved.
//

#import "DemoView1.h"

@implementation DemoView1


- (void)drawRect:(CGRect)rect {
    UIBezierPath *p = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,0,50,50)];
    [[UIColor yellowColor] setFill];
    [p fill];
}


@end
