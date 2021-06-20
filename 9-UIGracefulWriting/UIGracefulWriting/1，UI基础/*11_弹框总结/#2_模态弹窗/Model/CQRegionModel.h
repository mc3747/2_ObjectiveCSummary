//
//  CQRegionModel.h
//  iOS_Storage
//
//  Created by 蔡强 on 2018/7/18.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQFilterBaseModel.h"

/** 大区model */
@interface CQRegionModel : CQFilterBaseModel

@property (nonatomic, copy) NSString *region_id;
@property (nonatomic, copy) NSString *region_name;

@end
