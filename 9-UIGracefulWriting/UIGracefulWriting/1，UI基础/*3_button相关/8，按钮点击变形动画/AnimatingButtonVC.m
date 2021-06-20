//
//  AnimationingButtonVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/10/14.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "AnimatingButtonVC.h"
#import "DeformationButton.h"

@interface AnimatingButtonVC ()
@property (nonatomic, strong) DeformationButton *deformationBtn;
@end

@implementation AnimatingButtonVC

- (UIColor *)getColor:(NSString *)hexColor
{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _deformationBtn = [[DeformationButton alloc]initWithFrame:CGRectMake(100, 100, 140, 36) withColor:[self getColor:@"e13536"]];
    [self.view addSubview:_deformationBtn];

    [_deformationBtn.forDisplayButton setTitle:@"微博注册" forState:UIControlStateNormal];
    [_deformationBtn.forDisplayButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_deformationBtn.forDisplayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_deformationBtn.forDisplayButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
    [_deformationBtn.forDisplayButton setImage:[UIImage imageNamed:@"微博logo.png"] forState:UIControlStateNormal];

    [_deformationBtn addTarget:self action:@selector(btnEvent) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(testTap)];
    [self.view addGestureRecognizer:tap];
}

- (void)testTap{
    NSLog(@"testTap");
     _deformationBtn.isLoading = YES;
}

- (void)btnEvent{
    NSLog(@"btnEvent");
    _deformationBtn.isLoading = NO;
}

@end
