//
//  CADisplayLinkVC.m
//  JX_GCDTimer
//
//  Created by ylgwhyh on 16/5/1.
//  Copyright © 2016年 com.joeyxu. All rights reserved.
//

#import "CADisplayLinkVC.h"

@interface CADisplayLinkVC ()

@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation CADisplayLinkVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor purpleColor];
    
    self.title = @"CADisplayLinkVC";
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleDisplayLink:)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];

    //停止的方法
//    [self.displayLink invalidate];
//    self.displayLink = nil;
}


- (void)handleDisplayLink:(CADisplayLink *)displayLink{
    NSLog(@"延迟执行....");
    //停止CADisplayLink
    [self.displayLink invalidate];
    self.displayLink = nil;
}



@end
