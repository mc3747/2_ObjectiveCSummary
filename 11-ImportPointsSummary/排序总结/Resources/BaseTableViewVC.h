//
//  BaseTableViewVC.h
//  排序总结
//
//  Created by gjfax on 2018/11/9.
//  Copyright © 2018 macheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewVC : UITableViewController
@property (nonatomic, strong) NSArray *contentArray;
@property (nonatomic, strong) NSArray *vcNameArray;
@property (nonatomic, strong) NSArray *vcTitleArray;
@end

NS_ASSUME_NONNULL_END
