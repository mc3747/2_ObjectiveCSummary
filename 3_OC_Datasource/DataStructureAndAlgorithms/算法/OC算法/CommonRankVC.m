//
//  CommonRankVC.m
//  DataStructureAndAlgorithms
//
//  Created by gjfax on 2018/5/22.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "CommonRankVC.h"
#import "RankManager1.h"
#import "RankManager2.h"
#import "RankManager3.h"
#import "RankManager4.h"
#import "RankManager5.h"
#import "RankManager6.h"
#import "RankManager7.h"
#import "RankManager8.h"

#import "DCLog.h"
@interface CommonRankVC ()

@end

@implementation CommonRankVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MCColorLightGreen;
    [self addStackView];
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@12,@15.8,@19,@10,@14,nil];
    
    
    if (_indexInt == 0) {
        [RankManager1 oneRankWithOCAscend:array];
        
    } else if (_indexInt == 1) {
        [RankManager2 twoRankWithOCAscend:array];
        
    } else if (_indexInt == 2) {
        [RankManager3 threeRankWithOCAscend:array leftIndex:2 rightIndex:3];
        
    } else if (_indexInt == 3) {
        [RankManager4 fourRankWithOCAscend:array];
        
    } else if (_indexInt == 4) {
        [RankManager5 fiveRankWithOCAscend:array];
        
    } else if (_indexInt == 5) {
        [RankManager6 sixRankWithOCAscend:array];
        
    } else if (_indexInt == 6) {
        [RankManager7 sevenAscendingOrderSort:array];
        
    } else if (_indexInt == 7) {
        [RankManager8 eightRankWithOCAscend:array];
        
    } else {
        
    }
}

/**  UIStackViewDistribution
 UIStackViewDistributionFill = 0,
 UIStackViewDistributionFillEqually,
 UIStackViewDistributionFillProportionally,
 UIStackViewDistributionEqualSpacing,
 UIStackViewDistributionEqualCentering,
 */
/**  UIStackViewAlignment
 UIStackViewAlignmentFill,
 UIStackViewAlignmentLeading,
 UIStackViewAlignmentTop = UIStackViewAlignmentLeading,
 UIStackViewAlignmentFirstBaseline,
 UIStackViewAlignmentCenter,
 UIStackViewAlignmentTrailing,
 UIStackViewAlignmentBottom = UIStackViewAlignmentTrailing,
 UIStackViewAlignmentLastBaseline,
 */
- (void)addStackView {
    UIStackView *containerView = [[UIStackView alloc] init];
    containerView.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.5];
    //子控件的布局方向
    containerView.axis = UILayoutConstraintAxisHorizontal;
    containerView.distribution = UIStackViewDistributionFillEqually;
    containerView.spacing = 10;
    containerView.alignment = UIStackViewAlignmentFill;
    containerView.frame = CGRectMake(0, 100, MAIN_SCREEN_WIDTH, 200);
    [self.view addSubview:containerView];
    
    NSArray *titleArray = @[@"显示日志",@"隐藏日志"];
    for (NSInteger i = 0; i < titleArray.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setBackgroundColor:RandColor];
        [button addTarget:self action:@selector(showLog) forControlEvents:UIControlEventTouchUpInside];
        [containerView addArrangedSubview:button];
    };
    
}

- (void)showLog {
    [DCLog changeVisible];
}


@end
