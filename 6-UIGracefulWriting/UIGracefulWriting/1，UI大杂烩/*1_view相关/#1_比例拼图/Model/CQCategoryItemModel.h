//
//  CQCategoryItemModel.h
//  iOS_Storage
//
//  Created by 蔡强 on 2018/6/23.
//  Copyright © 2018年 蔡强. All rights reserved.
//

@interface CQCategoryItemModel : CQBaseModel

/** 品类名 */
@property (nonatomic, copy) NSString *name;
/** 销售额 */
@property (nonatomic, assign) CGFloat sale_amount;
/** 销售额同比 */
@property (nonatomic, copy) NSString *gross_margin_ratio;

/** 占比 */
@property (nonatomic, assign) CGFloat ratio;

@property (nonatomic, assign) CGFloat size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@end
