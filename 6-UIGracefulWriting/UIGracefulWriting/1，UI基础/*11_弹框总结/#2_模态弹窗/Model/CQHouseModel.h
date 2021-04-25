//
//  CQHouseModel.h
//  iOS_Storage
//
//  Created by 蔡强 on 2018/7/18.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQFilterBaseModel.h"

/** 门店model */
@interface CQHouseModel : CQFilterBaseModel

@property (nonatomic, copy) NSString *house_id;
@property (nonatomic, copy) NSString *house_name;

@end
