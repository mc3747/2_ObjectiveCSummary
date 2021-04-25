//
//  UIButton+touch.h
//  LiqForDoctors
//
//  Created by StriEver on 16/3/10.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

 /*特别注意：添加防止重复点击的分类后
  按钮就无法响应双击效果（安全键盘的字母切换双击效果就响应不了）
  不赞成直接把分类直接拖到项目中去
  */
#define defaultInterval .2  //默认时间间隔

@interface UIButton (category2)
/**设置点击时间间隔*/
@property (nonatomic, assign) NSTimeInterval timeInterval;
@end
