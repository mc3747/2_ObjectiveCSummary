//
//  CQJigsawViewController.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/6/23.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQJigsawViewController.h"
#import "CQCategoryView.h"

@interface CQJigsawViewController () <CQCategoryViewDelegate>

@property (nonatomic, strong) CQCategoryView *categoryView;

@end

@implementation CQJigsawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.categoryView = [[CQCategoryView alloc] init];
    [self.view addSubview:self.categoryView];
    self.categoryView.delegate = self;
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT);
        make.left.right.mas_offset(0);
    }];
    
    // 加载本地数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"jigsaw_list" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    NSError *error = nil;
    CQCategoryModel *model = [[CQCategoryModel alloc] initWithDictionary:responseDict[@"data"] error:&error];
    self.categoryView.model = model;
}

#pragma mark - Delegate - CategoryView

// 筛选按钮点击
- (void)categoryView:(CQCategoryView *)categoryView filtrateButtonClicked:(UIButton *)filtrateButton {
    NSLog(@"筛选按钮点击");
}

// cell点击
- (void)categoryView:(CQCategoryView *)categoryView clickedCellAtIndex:(NSInteger)index {
    NSLog(@"点击第%ld个cell", (long)index);
}

@end
