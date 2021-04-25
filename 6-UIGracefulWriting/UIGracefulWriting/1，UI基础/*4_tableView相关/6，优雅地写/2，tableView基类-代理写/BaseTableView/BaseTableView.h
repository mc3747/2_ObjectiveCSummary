/*********************************************************/
/*                                                       *
 *                                                       *
 *   Follow your heart, but take your brain with you.    *
 *                                                       *
 *                                                       *
 *********************************************************/
//
//  BaseTableView.h
//  LYFBaseTableView
//
//  Created by 刘一峰 on 2017/7/10.
//  Copyright © 2017年 刘一峰. All rights reserved.
//


#import "BaseEmptyTableView.h"

//渲染cell
typedef UITableViewCell *(^CallbackCell)(UITableViewCell * cell,NSIndexPath * indexPath);

//点击cell
typedef void(^CallbackDidSelectedCell)(UITableViewCell * cell,NSIndexPath * indexPath);

@interface BaseTableView : BaseEmptyTableView

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)CallbackCell callbackCell;
@property(nonatomic,strong)CallbackDidSelectedCell callbackDidSelectedCell;

/**
 NOTE:
 初始化tableview的时候，一定要记得调用这个block 把cell的重用标识符给回川给BaseTableview，否则重用会出现问题
 */
- (instancetype)initWithFrame:(CGRect)frame callbackIdentifier:(NSString * (^)(void))callbackIdentifier;
@end

