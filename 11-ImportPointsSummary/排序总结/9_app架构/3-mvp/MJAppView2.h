//
//  MJAppView.h
//  测试架构
//
//  Created by MJ Lee on 2018/7/13.
//  Copyright © 2018年 MJ Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MJAppView2;

@protocol MJAppViewDelegate <NSObject>
@optional
- (void)appViewDidClick:(MJAppView2 *)appView;
@end

@interface MJAppView2 : UIView
- (void)setName:(NSString *)name andImage:(NSString *)image;
@property (weak, nonatomic) id<MJAppViewDelegate> delegate;
@end
