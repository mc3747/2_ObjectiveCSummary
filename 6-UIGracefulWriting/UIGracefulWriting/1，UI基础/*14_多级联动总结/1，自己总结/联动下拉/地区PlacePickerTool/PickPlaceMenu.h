//
//  PickPlaceMenu.h
//  RHPlacePick
//
//  Created by 郭人豪 on 2017/3/28.
//  Copyright © 2017年 Abner_G. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceModel.h"

typedef void(^ClickMenuBlock) (NSString *provinceString,NSString *cityString,NSString *districtString);

@interface PickPlaceMenu : UIView

//配置：数据 + 级联的个数
- (void)configViewWithData:(NSMutableArray<Province *> *)dataArray tabNum:(NSUInteger)tabNum inSuperView:(UIView *)superView;

//复原
- (void)reset;

@property (nonatomic, copy) ClickMenuBlock clickMenuBlock;

@end



