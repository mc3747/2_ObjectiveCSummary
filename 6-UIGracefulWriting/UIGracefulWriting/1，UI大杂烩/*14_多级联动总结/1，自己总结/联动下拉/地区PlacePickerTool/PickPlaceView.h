//
//  PickPlaceView.h
//  RHPlacePick
//
//  Created by 郭人豪 on 2017/3/28.
//  Copyright © 2017年 Abner_G. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickListCellBlock) (NSInteger cellIndex,NSString *cellString);
@interface PickPlaceView : UIView

@property (nonatomic, copy) ClickListCellBlock clickListCellBlock;

- (void)reloadViewWithData:(NSArray *)dataArr;

/**收起列表*/
- (void)hide;
@end


