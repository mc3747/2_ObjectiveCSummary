//
//  NineGridUsingMasonryVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/10/30.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "NineGridUsingMasonryVC.h"
#import "NSArray+Sudoku.h"

@interface NineGridUsingMasonryVC ()

@end

@implementation NineGridUsingMasonryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGrid1];
}

- (void)addGrid1 {
//    UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 10, 10);
//     make.edges.equalTo(superview).with.insets(padding);

    

// TODO: 可变宽高，固定间隙
    UIView *containerView1 = [self returnContainerView];
    [containerView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(100);
        make.right.offset(-15);
        make.height.offset(250);
    }];
    [containerView1.subviews  mas_distributeSudokuViewsWithFixedItemWidth:0
                                                         fixedItemHeight:0
                                                        fixedLineSpacing:10
                                                   fixedInteritemSpacing:20
                                                               warpCount:3
                                                              topSpacing:10
                                                           bottomSpacing:10
                                                             leadSpacing:10
                                                             tailSpacing:10];
// TODO: 固定宽高，可变间隙
    UIView *containerView2 = [self returnContainerView];
    [containerView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(360);
        make.right.offset(-15);
        make.height.offset(200);
    }];
    [containerView2.subviews mas_distributeSudokuViewsWithFixedItemWidth:50
                                                            fixedItemHeight:50
                                                                  warpCount:4
                                                                 topSpacing:10
                                                              bottomSpacing:10
                                                                leadSpacing:10
                                                                tailSpacing:10];
// TODO: 固定宽高，固定间隙
    UIView *containerView3 = [self returnContainerView];
    [containerView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(570);
        make.right.offset(-15);
        make.height.offset(200);
    }];
    [containerView3.subviews mas_distributeSudokuViewsWithFixedItemWidth:50 fixedItemHeight:50 fixedLineSpacing:5 fixedInteritemSpacing:5 warpCount:4 topSpacing:10 bottomSpacing:10 leadSpacing:10 tailSpacing:10];
}

#pragma mark -  容器view
- (UIView *)returnContainerView {
    UIView *containerView = [[UIView alloc] init];
    [self.view addSubview:containerView];
    containerView.backgroundColor = LBRandomColor;
    containerView.layer.borderWidth = 2;
    containerView.layer.borderColor = LBRandomColor.CGColor;
    
    // TODO:给该容器添加布局代码
    
    // TODO:  为该容器添加宫格View
    for (int i = 0; i < 10; i++) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = LBRandomColor;
        [containerView addSubview:view];
    }
    return containerView;
}
@end
