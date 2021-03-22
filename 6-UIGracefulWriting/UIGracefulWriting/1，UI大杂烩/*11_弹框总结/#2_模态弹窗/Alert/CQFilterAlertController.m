//
//  CQFilterAlertController.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/7/18.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQFilterAlertController.h"
#import "CQFilterCell.h"
#import "CQFilterRequest.h"

typedef NS_ENUM(NSUInteger, CQFilterType) {
    CQFilterTypeRegion,
    CQFilterTypeDepartment,
    CQFilterTypeHouse,
};

static NSString * const CQFilterCellReuseID = @"CQFilterCellReuseID";

@interface CQFilterAlertController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSString *regionID;
@property (nonatomic, copy) NSString *departmentID;
@property (nonatomic, copy) NSString *houseID;
@property (nonatomic, copy) FiltrateCompletion filtrateCompletion;

/** 列表 */
@property (nonatomic, strong) UITableView *tableView;
/** 组头标题数组 */
@property (nonatomic, strong) NSArray *sectionTitleArray;

/** 大区数组 */
@property (nonatomic, strong) NSMutableArray *regionArray;
/** 部门数组 */
@property (nonatomic, strong) NSMutableArray *departmentArray;
/** 门店数组 */
@property (nonatomic, strong) NSMutableArray *houseArray;

/** 选中的大区 */
@property (nonatomic, strong) CQRegionModel *selectedRegionModel;
/** 选中的部门 */
@property (nonatomic, strong) CQDepartmentModel *selectedDepartmentModel;
/** 选中的门店 */
@property (nonatomic, strong) CQHouseModel *selectedHouseModel;

@end

@implementation CQFilterAlertController

#pragma mark - getter

- (NSArray *)sectionTitleArray {
    if (!_sectionTitleArray) {
        _sectionTitleArray = @[@"大区", @"部门", @"门店"];
    }
    return _sectionTitleArray;
}

- (NSMutableArray *)regionArray {
    if (!_regionArray) {
        _regionArray = [NSMutableArray array];
    }
    return _regionArray;
}

- (NSMutableArray *)departmentArray {
    if (!_departmentArray) {
        _departmentArray = [NSMutableArray array];
    }
    return _departmentArray;
}

- (NSMutableArray *)houseArray {
    if (!_houseArray) {
        _houseArray = [NSMutableArray array];
    }
    return _houseArray;
}

#pragma mark - 构造方法

+ (instancetype)alertWithRegionID:(NSString *)regionID departmentID:(NSString *)departmentID houseID:(NSString *)houseID filtrateCompletion:(FiltrateCompletion)filtrateCompletion {
    CQFilterAlertController *alertController = [[CQFilterAlertController alloc] init];
    alertController.regionID = regionID;
    alertController.departmentID = departmentID;
    alertController.houseID = houseID;
    alertController.filtrateCompletion = filtrateCompletion;
    alertController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    return alertController;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // UI搭建
    [self setupUI];
    
    // 获取数据
    [SVProgressHUD show];
    [self loadDataSuccess:^{
        [SVProgressHUD dismiss];
        [self.tableView reloadData];
    } failure:^(NSString *errorMessage) {
        [SVProgressHUD showErrorWithStatus:errorMessage];
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

#pragma mark - UI搭建

- (void)setupUI {
    self.view.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5];
    
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[CQFilterCell class] forCellReuseIdentifier:CQFilterCellReuseID];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 300));
        make.center.mas_equalTo(self.view);
    }];
    
    UIButton *confirmButtom = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:confirmButtom];
    confirmButtom.backgroundColor = [UIColor orangeColor];
    [confirmButtom setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButtom addTarget:self action:@selector(confirmButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [confirmButtom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.tableView);
        make.top.mas_equalTo(self.tableView.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(40);
    }];
}

#pragma mark - 加载数据

- (void)loadDataSuccess:(void (^)(void))success failure:(void (^)(NSString *errorMessage))failure {
    // 3个接口，全部请求成功后刷新tableView
    NSInteger totalCount = 3;
    __block NSInteger requestCount = 0;
    
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 获取大区列表
        [CQFilterRequest loadRegionArraySuccess:^(NSArray *regionArray) {
            for (NSDictionary *dict in regionArray) {
                NSError *error = nil;
                CQRegionModel *model = [[CQRegionModel alloc] initWithDictionary:dict error:&error];
                if ([model.region_id isEqualToString:self.regionID]) {
                    model.selected = YES;
                    self.selectedRegionModel = model;
                } else {
                    model.selected = NO;
                }
                [self.regionArray addObject:model];
            }
            
            if (++requestCount == totalCount) {
                dispatch_semaphore_signal(sem);
            }
        } failure:^(NSString *errorMessage) {
            !failure ?: failure(errorMessage);
        }];
        
        // 获取部门列表
        [CQFilterRequest loadDepartmentArraySuccess:^(NSArray *departmentArray) {
            for (NSDictionary *dict in departmentArray) {
                NSError *error = nil;
                CQDepartmentModel *model = [[CQDepartmentModel alloc] initWithDictionary:dict error:&error];
                if ([model.department_id isEqualToString:self.departmentID]) {
                    model.selected = YES;
                    self.selectedDepartmentModel = model;
                } else {
                    model.selected = NO;
                }
                [self.departmentArray addObject:model];
            }
            
            if (++requestCount == totalCount) {
                dispatch_semaphore_signal(sem);
            }
        } failure:^(NSString *errorMessage) {
            !failure ?: failure(errorMessage);
        }];
        
        // 获取门店列表
        [CQFilterRequest loadHouseArraySuccess:^(NSArray *houseArray) {
            for (NSDictionary *dict in houseArray) {
                NSError *error = nil;
                CQHouseModel *model = [[CQHouseModel alloc] initWithDictionary:dict error:&error];
                if ([model.house_id isEqualToString:self.houseID]) {
                    model.selected = YES;
                    self.selectedHouseModel = model;
                } else {
                    model.selected = NO;
                }
                [self.houseArray addObject:model];
            }
            
            if (++requestCount == totalCount) {
                dispatch_semaphore_signal(sem);
            }
        } failure:^(NSString *errorMessage) {
            !failure ?: failure(errorMessage);
        }];
        
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            success();
        });
    });
}

#pragma mark - 确定按钮点击

- (void)confirmButtonClicked {
    !self.filtrateCompletion ?: self.filtrateCompletion(self.selectedRegionModel, self.selectedDepartmentModel, self.selectedHouseModel);
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - 刷新

- (void)refresh {
    for (CQRegionModel *regionModel in self.regionArray) {
        regionModel.selected = [regionModel.region_id isEqualToString:self.selectedRegionModel.region_id];
    }
    
    for (CQDepartmentModel *departmentModel in self.departmentArray) {
        departmentModel.selected = [departmentModel.department_id isEqualToString:self.selectedDepartmentModel.department_id];
    }
    
    for (CQHouseModel *houseModel in self.houseArray) {
        houseModel.selected = [houseModel.house_id isEqualToString:self.selectedHouseModel.house_id];
    }
    
    [self.tableView reloadData];
}

#pragma mark - UITableView DataSource & Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionTitleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case CQFilterTypeRegion: // 大区
        {
            return self.regionArray.count;
        }
            break;
            
        case CQFilterTypeDepartment: // 部门
        {
            return self.departmentArray.count;
        }
            break;
            
        case CQFilterTypeHouse: // 门店
        {
            return self.houseArray.count;
        }
            break;
            
        default:
        {
            return 0;
        }
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CQFilterCell *cell = [tableView dequeueReusableCellWithIdentifier:CQFilterCellReuseID forIndexPath:indexPath];
    switch (indexPath.section) {
        case CQFilterTypeRegion: // 大区
        {
            cell.model = self.regionArray[indexPath.row];
        }
            break;
            
        case CQFilterTypeDepartment: // 部门
        {
            cell.model = self.departmentArray[indexPath.row];
        }
            break;
            
        case CQFilterTypeHouse: // 门店
        {
            cell.model = self.houseArray[indexPath.row];
        }
            break;
            
        default:
            break;
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionTitleArray[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case CQFilterTypeRegion: // 大区
        {
            self.selectedRegionModel = self.regionArray[indexPath.row];
        }
            break;
            
        case CQFilterTypeDepartment: // 部门
        {
            self.selectedDepartmentModel = self.departmentArray[indexPath.row];
        }
            break;
            
        case CQFilterTypeHouse: // 门店
        {
            self.selectedHouseModel = self.houseArray[indexPath.row];
        }
            break;
            
        default:
            break;
    }
    
    // 刷新
    [self refresh];
}

@end
