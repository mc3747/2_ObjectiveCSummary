//
//  CustomView.h
//  自定义控件
//
//  Created by gjfax on 16/6/3.
//  Copyright © 2016年 macheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PureXibCustomModel;

@interface PureXibCustomView : UIView
// 模型属性
@property (nonatomic, strong) PureXibCustomModel *model;
// 初始化方法
+ (instancetype)customViewShow;
@end
