//
//  WCYADImageView.h
//  test
//
//  Created by apple on 2017/8/18.
//  Copyright © 2017年 JIABIANWANGLUO. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 只能显示图片的广告页
 */

// 设置的跳过按钮类型
typedef NS_ENUM(NSInteger, SkipButtonType) {
    SkipButtonTypeNormalTimeAndText = 0,      //普通的倒计时+跳过
    SkipButtonTypeCircleAnimationTest,        //圆形动画+跳过
    SkipButtonTypeNormalText,                 //只有普通的跳过
    SkipButtonTypeNormalTime,                 //只有普通的倒计时
    SkipButtonTypeNone                        //无
};

typedef void(^adImageTouchBlock) (NSString *pushUrl);//跳转block回调 一般是网址之类的

@interface WCYADImageView : UIImageView

/** 广告图的显示时间（默认5秒）*/
@property (nonatomic, assign) NSUInteger duration;

/** 获取数据前，启动图的等待时间（若不设置则不启动等待机制）*/
@property (nonatomic, assign) NSUInteger waitTime;

/** 右上角按钮的样式（默认倒计时+跳过）*/
@property (nonatomic, assign) SkipButtonType skipType;

/** 广告图点击事件回调*/
@property (nonatomic, copy) adImageTouchBlock adImageTapBlock;

/** 加载广告图*/
- (void)reloadAdImageWithUrl:(NSString *)urlStr;

@end
