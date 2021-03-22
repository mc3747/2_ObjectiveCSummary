//
//  CQFilterViewController.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/7/18.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQFilterViewController.h"
#import "CQFilterAlertController.h"

@interface CQFilterViewController ()

/** 大区label */
@property (nonatomic, strong) UILabel *regionLabel;
/** 部门label */
@property (nonatomic, strong) UILabel *departmentLabel;
/** 门店label */
@property (nonatomic, strong) UILabel *houseLabel;

@end

@implementation CQFilterViewController {
    /** 当前大区id */
    NSString *_currentRegionID;
    /** 当前部门id */
    NSString *_currentDepartmentID;
    /** 当前门店id */
    NSString *_currentHouseID;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 默认”所有大区“”所有部门“”所有门店“
    _currentRegionID     = @"0";
    _currentDepartmentID = @"0";
    _currentHouseID      = @"0";
    
    // 筛选按钮
    UIButton *filterButton = [[UIButton alloc] init];
    [self.view addSubview:filterButton];
    [filterButton setTitle:@"点击筛选" forState:UIControlStateNormal];
    filterButton.backgroundColor = [UIColor redColor];
    [filterButton addTarget:self action:@selector(filterButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [filterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(150);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    // 创建三个label
    NSMutableArray *labelsArray = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        UILabel *label = [[UILabel alloc] init];
        [self.view addSubview:label];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        label.adjustsFontSizeToFitWidth = YES;
        label.backgroundColor = [UIColor yellowColor];
        [labelsArray addObject:label];
        switch (i) {
            case 0:
            {
                self.regionLabel = label;
                self.regionLabel.text = @"所有大区";
            }
                break;
                
            case 1:
            {
                self.departmentLabel = label;
                self.departmentLabel.text = @"所有部门";
            }
                break;
                
            case 2:
            {
                self.houseLabel = label;
                self.houseLabel.text = @"所有门店";
            }
                break;
                
            default:
                break;
        }
    }
    [labelsArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:10 tailSpacing:10];
    [labelsArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(filterButton.mas_bottom).mas_offset(30);
        make.height.mas_equalTo(40);
    }];
}

#pragma mark - 筛选按钮点击

- (void)filterButtonClicked {
    // 弹窗
    CQFilterAlertController *alertController = [CQFilterAlertController
                                                alertWithRegionID:_currentRegionID
                                                departmentID:_currentDepartmentID
                                                houseID:_currentHouseID
                                                filtrateCompletion:^(CQRegionModel *selectedRegionModel, CQDepartmentModel *selectedDepartmentModel, CQHouseModel *selectedHouseModel)
    {
        // 筛选完成的回调
        _currentRegionID     = selectedRegionModel.region_id;
        _currentDepartmentID = selectedDepartmentModel.department_id;
        _currentHouseID      = selectedHouseModel.house_id;
        self.regionLabel.text     = selectedRegionModel.region_name;
        self.departmentLabel.text = selectedDepartmentModel.department_name;
        self.houseLabel.text      = selectedHouseModel.house_name;
    }];
    // 弹窗show出来
    [self presentViewController:alertController animated:NO completion:nil];
}

@end
