/*********************************************************/
/*                                                       *
 *                                                       *
 *   Follow your heart, but take your brain with you.    *
 *                                                       *
 *                                                       *
 *********************************************************/
//
//  BaseRefreshTableView.h
//  BaseTableView
//
//  Created by 刘一峰 on 2017/7/10.
//  Copyright © 2017年 刘一峰. All rights reserved.
//

#import "BaseTableView.h"
typedef NS_ENUM(NSInteger, PYTableViewRefreshType) {
    PYTableViewRefreshTypeNone = 1,
    PYTableViewRefreshTypeHeader,
    PYTableViewRefreshTypeFooter,
    PYTableViewRefreshTypeHeaderAndFooter
};

@interface BaseRefreshTableView : BaseTableView

@property (nonatomic) BOOL  supportRefreshDown;//是否支持下拉刷新
@property (nonatomic) BOOL  supportRefreshUp;//是否支持上拉加载


/**
 *  自动刷新
 */
- (void)autoRefresh;
/**
 *  下拉刷新事件
 */
- (void)tableViewDidTriggerDownRefresh;
/**
 *  上拉加载事件
 */
- (void)tableViewDidTriggerUpRefresh;
/**
 *  停止刷新
 */
- (void)tableViewDidFinishRefreshByDragDown:(BOOL)isDragDown;

@end
