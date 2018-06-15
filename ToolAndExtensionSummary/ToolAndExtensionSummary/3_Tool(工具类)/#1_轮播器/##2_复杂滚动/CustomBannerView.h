//
//  CustomBannerView.h
//  ToolAndExtensionSummary
//
//  Created by gjfax on 2018/6/15.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYCyclePagerView.h"
#import "TYPageControl.h"

@interface CustomBannerView : UIView

- (instancetype)initWithFrame:(CGRect)frame datas:(NSArray *)datas;
@property (nonatomic, strong) TYCyclePagerView *pagerView;
@property (nonatomic, strong) TYPageControl *pageControl;
@end
