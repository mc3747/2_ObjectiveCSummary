//
//  YUTestViewController.h
//  YUFoldingTableViewDemo
//
//  Created by administrator on 16/8/25.
//  Copyright © 2016年 timelywind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YUFoldingTableView.h"

@interface YUTestViewController : UIViewController  <YUFoldingTableViewDelegate>

@property (nonatomic, strong) NSArray<NSString *> *sectionTitles;
@property (nonatomic, strong) NSArray<NSArray *> *cellTitles;

@end
