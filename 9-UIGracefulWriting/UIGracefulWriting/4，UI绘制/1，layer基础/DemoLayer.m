//
//  DemoLayer.m
//  WHLatticeDemo
//
//  Created by gjfax on 2018/10/30.
//  Copyright © 2018年 remember17. All rights reserved.
//

#import "DemoLayer.h"

@implementation DemoLayer
- (void)setFrame:(CGRect)frame
{
    NSLog(@"%s",__func__);
    [super setFrame:frame];
}

- (void)setBounds:(CGRect)bounds
{
    NSLog(@"%s",__func__);
    [super setBounds:bounds];
}

- (void)setPosition:(CGPoint)position
{
    NSLog(@"%s",__func__);
    [super setPosition:position];
}

- (void)setTransform:(CATransform3D)transform {
    NSLog(@"%s",__func__);
    [super setTransform:transform];
}

- (void)setAnchorPoint:(CGPoint)anchorPoint {
    NSLog(@"%s",__func__);
    [super setAnchorPoint:anchorPoint];
}

-(void)drawInContext:(CGContextRef)ctx {
    NSLog(@"%s",__func__);
    [super drawInContext:ctx];
}

-(void)addAnimation:(CAAnimation *)anim forKey:(NSString *)key {
    NSLog(@"anim : %@, for key:%@", anim, key);
    [super addAnimation:anim forKey:key];
}


@end
