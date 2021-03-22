/*********************************************************/
/*                                                       *
 *                                                       *
 *   Follow your heart, but take your brain with you.    *
 *                                                       *
 *                                                       *
 *********************************************************/
//
//  BaseRefreshTableView.m
//  BaseTableView
//
//  Created by 刘一峰 on 2017/7/10.
//  Copyright © 2017年 刘一峰. All rights reserved.
//

#import "BaseRefreshTableView.h"
#import <MJRefresh/MJRefresh.h>
@implementation BaseRefreshTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setConfigure];
    }
    return self;
}

- (void)setConfigure {
    [super setConfigure];
    self.supportRefreshUp = YES;
    self.supportRefreshDown = YES;
    //隐藏MJRrfresh的footer，个人习惯，感觉footer很难看突兀
    [self.mj_footer setAlpha:0];

    
}

- (void)autoRefresh{
    if (self.supportRefreshDown) {
        [self tableViewDidTriggerDownRefresh];
    }
}

- (void)tableViewDidTriggerDownRefresh {
    self.isLoading = YES;
    [self.dataArray removeAllObjects];
    
    //some codes what you want
    [self tableViewDidFinishRefreshByDragDown:YES];
}

- (void)tableViewDidTriggerUpRefresh {
    self.isLoading = YES;
    //some codes what you want
    [self tableViewDidFinishRefreshByDragDown:NO];
}

- (void)tableViewDidFinishRefreshByDragDown:(BOOL)isDragDown {
    
    if (self.iDelegate && [self.iDelegate respondsToSelector:@selector(requestDataByDelegate)]) {
        if (isDragDown) {
            //TODO - 刷新操作
            [self.iDelegate requestDataByDelegate];
            [self.mj_header endRefreshing];
        }else {
            //TODO --加载操作
            [self.iDelegate requestMoreDataByDelegate];
            [self.mj_footer endRefreshing];
            [self.mj_footer setAlpha:0];
        }
        self.isLoading = NO;
    }
}

- (void)setSupportRefreshUp:(BOOL)supportRefreshUp {
    if (_supportRefreshUp != supportRefreshUp) {
        _supportRefreshUp = supportRefreshUp;
        if (_supportRefreshUp) {
            self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(tableViewDidTriggerUpRefresh)];
        }else {
            [self.mj_footer removeFromSuperview];
        }
        
    }
    
}

- (void)setSupportRefreshDown:(BOOL)supportRefreshDown {
    if (_supportRefreshDown != supportRefreshDown) {
        _supportRefreshDown = supportRefreshDown;
        if (_supportRefreshDown) {
            self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(tableViewDidTriggerDownRefresh)];
        }else {
            [self.mj_header removeFromSuperview];
        }
    }
}


@end
