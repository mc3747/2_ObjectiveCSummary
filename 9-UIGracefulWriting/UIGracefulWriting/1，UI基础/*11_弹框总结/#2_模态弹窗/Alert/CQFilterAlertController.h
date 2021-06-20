//
//  CQFilterAlertController.h
//  iOS_Storage
//
//  Created by 蔡强 on 2018/7/18.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CQRegionModel.h"
#import "CQDepartmentModel.h"
#import "CQHouseModel.h"

/**
 筛选完成的回调

 @param selectedRegionModel 选择的大区
 @param selectedDepartmentModel 选择的部门
 @param selectedHouseModel 选择的门店
 */
typedef void(^FiltrateCompletion)(CQRegionModel *selectedRegionModel, CQDepartmentModel *selectedDepartmentModel, CQHouseModel *selectedHouseModel);

@interface CQFilterAlertController : UIViewController

/**
 弹窗构造方法

 @param regionID 大区id
 @param departmentID 部门id
 @param houseID 门店id
 @param filtrateCompletion 筛选完成的回调
 @return 弹窗
 */
+ (instancetype)alertWithRegionID:(NSString *)regionID departmentID:(NSString *)departmentID houseID:(NSString *)houseID filtrateCompletion:(FiltrateCompletion)filtrateCompletion;

@end
