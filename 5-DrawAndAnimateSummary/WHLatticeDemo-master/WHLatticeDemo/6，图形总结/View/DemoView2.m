//
//  DemoView2.m
//  WHLatticeDemo
//
//  Created by gjfax on 2019/12/20.
//  Copyright © 2019 remember17. All rights reserved.
//

#import "DemoView2.h"

@implementation DemoView2


- (void)drawRect:(CGRect)rect {
    CGContextRef con = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(con, CGRectMake(0,0,50,50));
    CGContextSetFillColorWithColor(con, [UIColor greenColor].CGColor);
    CGContextFillPath(con);
}

//- (void)drawRect:(CGRect)rect
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    UIImage *image = [UIImage imageNamed:@"addText.png"];
//    CGRect rect1 = CGRectMake(100.0, 100.0, 100.0, 100.0);
////    CGContextDrawImage(context, rect1, [image CGImage]);
//    drawImage(context, [image CGImage], rect1);
//}
// 
//void drawImage(CGContextRef context, CGImageRef image , CGRect rect){
//    CGContextSaveGState(context);
//    
//    CGContextTranslateCTM(context, rect.origin.x, rect.origin.y);
//    CGContextTranslateCTM(context, 0, rect.size.height);
//    CGContextScaleCTM(context, 1.0, -1.0);
//    CGContextTranslateCTM(context, -rect.origin.x, -rect.origin.y);
//    CGContextDrawImage(context, rect, image);
//    
//    CGContextRestoreGState(context);
//}


@end
