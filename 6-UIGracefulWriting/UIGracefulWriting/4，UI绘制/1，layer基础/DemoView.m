//
//  DemoView.m
//  WHLatticeDemo
//
//  Created by gjfax on 2018/10/30.
//  Copyright © 2018年 remember17. All rights reserved.
//

#import "DemoView.h"
#import "DemoLayer.h"

@implementation DemoView

+ (Class)layerClass {
    NSLog(@"%s",__func__);
    return [DemoLayer class];
}

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

- (void)setCenter:(CGPoint)center
{
    NSLog(@"%s",__func__);
    [super setCenter:center];
}

- (void)setTransform:(CGAffineTransform)transform {
    NSLog(@"%s",__func__);
    [super setTransform:transform];
}

-(void)drawRect:(CGRect)rect {
    NSLog(@"%s",__func__);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //画线
    //ctx 的备份
    CGContextSaveGState(ctx);
    CGContextSetLineWidth(ctx, 5);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextSetRGBStrokeColor(ctx, 1, 1, 0, 1);
    CGContextMoveToPoint(ctx, 0, 120);    //起点
    CGContextAddLineToPoint(ctx, 200, 120); //画线
    CGContextStrokePath(ctx);
}

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    NSLog(@"%s",__func__);
    [super drawLayer:layer inContext:ctx];
}

-(id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event {
    id<CAAction> action = [super actionForLayer:layer forKey:event];
    NSLog(@"action for layer: %@, for key:%@ is %@", layer, event, action);
    return action;
}



@end
