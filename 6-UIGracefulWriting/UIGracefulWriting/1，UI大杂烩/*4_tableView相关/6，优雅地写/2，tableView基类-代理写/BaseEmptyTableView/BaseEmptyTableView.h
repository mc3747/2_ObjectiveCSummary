/*********************************************************/
/*                                                       *
 *                                                       *
 *   Follow your heart, but take your brain with you.    *
 *                                                       *
 *                                                       *
 *********************************************************/
//
//  BaseTableView.h
//  BaseTableView
//
//  Created by 刘一峰 on 2017/7/10.
//  Copyright © 2017年 刘一峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseEmptyTableViewDelegate <NSObject>

- (void)requestDataByDelegate;

- (void)requestMoreDataByDelegate;

@end


@interface BaseEmptyTableView : UITableView

@property(nonatomic, copy) NSString * descriptionString;

@property(nonatomic, copy) NSString * emptyString;

@property(nonatomic, copy) NSString * emptyImageName;

@property(nonatomic, copy) NSString * imageNameWhenLoading;

@property(nonatomic, copy) NSString * buttomTitle;

@property(nonatomic, copy) NSString * buttonBgImageName;

@property(nonatomic, copy) NSString * buttonImageName;

@property (nonatomic,assign)BOOL isLoading;
// 显示暂位图时，是否允许滑动 default YES
@property(nonatomic, assign) BOOL isAllowScroll;
// 是否允许点击暂位信息，重新获取数据 default NO;
@property(nonatomic, assign) BOOL isAllowRequestDataByTap;
 //是否显示暂位文本信息 default YES;
@property(nonatomic, assign) BOOL isAllowDisplayPlaceholder;

@property(nonatomic,weak)id<BaseEmptyTableViewDelegate>iDelegate;

- (void)setConfigure;

@end
