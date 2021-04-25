//
//  XMGDealCell.h
//  06-自定义等高cell01-storyboard
//
//  Created by xiaomage on 15/6/2.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMGDeal;

@interface XMGDealCell : UITableViewCell
/** 团购模型数据 */
@property (nonatomic, strong) XMGDeal *deal;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end