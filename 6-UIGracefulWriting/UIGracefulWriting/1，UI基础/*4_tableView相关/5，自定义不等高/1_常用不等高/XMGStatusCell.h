//
//  XMGStatusCell.h
//  07-自定义非等高cell-xib
//
//  Created by xiaomage on 15/6/2.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMGStatus;

@interface XMGStatusCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** 微博模型数据 */
@property (nonatomic, strong) XMGStatus *status;
@end
