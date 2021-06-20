//
//  CQDepartmentModel.h
//  iOS_Storage
//
//  Created by 蔡强 on 2018/7/18.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQFilterBaseModel.h"

/** 部门model */
@interface CQDepartmentModel : CQFilterBaseModel

@property (nonatomic, copy) NSString *department_id;
@property (nonatomic, copy) NSString *department_name;

@end
