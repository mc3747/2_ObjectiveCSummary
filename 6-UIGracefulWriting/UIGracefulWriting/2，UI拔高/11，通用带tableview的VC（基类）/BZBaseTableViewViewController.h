//
//  BZBaseTableViewViewController.h
//  UIGracefulWriting
//
//  Created by gjfax on 2019/5/10.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "BZBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BZBaseTableViewViewController : BZBaseViewController
@property(nonatomic,strong) UITableView * tableView;
@property(nonatomic,strong) NSArray * dataSource;

-(void)setupTableView;
@end

NS_ASSUME_NONNULL_END
