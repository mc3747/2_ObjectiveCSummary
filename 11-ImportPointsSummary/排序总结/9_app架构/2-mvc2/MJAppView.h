//
//  MJAppView.h
//  测试架构
//
//  Created by MJ Lee on 2018/7/13.
//  Copyright © 2018年 MJ Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

//@interface MJAppView : UIView
//@property (weak, nonatomic, readonly) UIImageView *iconView;
//@property (weak, nonatomic, readonly) UILabel *nameLabel;
//@end

@class MJApp, MJAppView;

@protocol MJAppViewDelegate <NSObject>
@optional
- (void)appViewDidClick:(MJAppView *)appView;
@end

@interface MJAppView : UIView
@property (strong, nonatomic) MJApp *app;
@property (weak, nonatomic) id<MJAppViewDelegate> delegate;
@end
