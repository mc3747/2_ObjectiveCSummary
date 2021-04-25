//
//  DemoView5.m
//  WHLatticeDemo
//
//  Created by gjfax on 2019/12/20.
//  Copyright © 2019 remember17. All rights reserved.
//

#import "DemoView5.h"

@implementation DemoView5


- (void)drawRect:(CGRect)rect {
     CGContextRef ctx = UIGraphicsGetCurrentContext();
     CGLayerRef cg=CGLayerCreateWithContext(ctx, rect.size, NULL);
    //需要将CGLayerContext来作为缓存context，这个是必须的
     CGContextRef layerContext=CGLayerGetContext(cg);
       UIImage *image = [UIImage imageNamed:@"home_spring_bg"];
//    CGContextDrawImage(layerContext, rect, image.CGImage);
    drawImage(layerContext, image.CGImage, rect);
    CGContextDrawLayerAtPoint(ctx, CGPointMake(0, 0), cg);

}

//绘制处理的图像需要旋转
void drawImage(CGContextRef context, CGImageRef image , CGRect rect){
    CGContextSaveGState(context);

    CGContextTranslateCTM(context, rect.origin.x, rect.origin.y);
    CGContextTranslateCTM(context, 0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, -rect.origin.x, -rect.origin.y);
    CGContextDrawImage(context, rect, image);

    CGContextRestoreGState(context);
}
@end
