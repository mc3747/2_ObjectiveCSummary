//
//  CQCategoryView.h
//  iOS_Storage
//
//  Created by 蔡强 on 2018/6/23.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CQCategoryModel.h"

@class CQCategoryView;

@protocol CQCategoryViewDelegate <NSObject>

// 筛选按钮点击
- (void)categoryView:(CQCategoryView *)categoryView filtrateButtonClicked:(UIButton *)filtrateButton;
// cell点击
- (void)categoryView:(CQCategoryView *)categoryView clickedCellAtIndex:(NSInteger)index;

@end

@interface CQCategoryView : UIView

@property (nonatomic, strong) CQCategoryModel *model;
@property (nonatomic, weak) id <CQCategoryViewDelegate> delegate;

@end
