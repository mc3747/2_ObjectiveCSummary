//
//  NineGridVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/10/30.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "NineGridVC.h"

@interface NineGridVC ()

@end

@implementation NineGridVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *buttonNameArray = @[@"1，frame方式",@"2，masonry方式",@"3，stackView方式",@"4，UICollection方式",@"5，第三方BAGridView"];
    NSArray *vcNameArray = @[@"NineGridUsingFrameVC",@"NineGridUsingMasonryVC",@"NineGridUsingStackVC",@"NineGridUsingCollectionVC",@"BAGridVIewVC"];
    
    for (int i = 0; i < buttonNameArray.count; i++) {
        CGRect buttonRect = CGRectMake(20, 100 + 60 * i, 200, 50);
        UIButton *btn = [self returnButton:buttonRect buttonName:buttonNameArray[i] vcName:vcNameArray[i]];
        [self.view addSubview:btn];
    };
    
}


- (UIButton *)returnButton:(CGRect)rect buttonName:(NSString *)buttonName vcName:(NSString *)vcName {
    UIButton *button = [[UIButton alloc] initWithFrame:rect];
    UIColor *color = LBRandomColor;
    [button setBackgroundColor:color forState:UIControlStateNormal];
    [button setTitleColor:[color reverseColor] forState:UIControlStateNormal];
    [button setTitle:buttonName forState:UIControlStateNormal];
    [button.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [button GJSHandleCallBack:^(UIButton *button) {
        Class class = NSClassFromString(vcName);
        if (class) {
            UIViewController *ctrl = class.new;
            ctrl.view.backgroundColor = LBRandomColor;
            ctrl.title = buttonName;
            [self.navigationController pushViewController:ctrl animated:YES];
        }
    }];
    return button;
}

@end
