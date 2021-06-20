//
//  LoadingButtonVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/10/14.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "LoadingButtonVC.h"

@interface LoadingButtonVC ()
@property (nonatomic, strong) IANActivityIndicatorButton *btn;
@end

@implementation LoadingButtonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _btn = [[IANActivityIndicatorButton alloc] init];
    _btn.frame = CGRectMake(15, 100, self.view.bounds.size.width - 30, 80);
    _btn.backgroundColor = [UIColor redColor];
    [_btn setTitle:@"这是一个神奇的button" forState:UIControlStateNormal];
    _btn.layer.cornerRadius = 10;
    [self.view addSubview:_btn];
    _btn.tag = 2423;
    __weak typeof(self) weakSelf = self;
    _btn.TouchBlock = ^(IANActivityIndicatorButton *myButton){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"测试:%d",myButton.tag);
        [myButton startButtonActivityIndicatorView];
        
        
        [strongSelf performSelector:@selector(after) withObject:strongSelf afterDelay:5];
    };
    
}

- (void)after
{
    [_btn endButtonActivityIndicatorView];
}

@end
