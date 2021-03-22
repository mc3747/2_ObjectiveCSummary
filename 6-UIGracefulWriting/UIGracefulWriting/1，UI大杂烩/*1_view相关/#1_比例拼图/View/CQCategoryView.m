//
//  CQCategoryView.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/6/23.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQCategoryView.h"
#import "CQCategoryItemCell.h"
#import "CQCategoryItemModel.h"

static NSString * const CQCategoryItemCellReuseID = @"CQCategoryItemCellReuseID";

@interface CQCategoryView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation CQCategoryView

#pragma mark - 构造方法

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - UI搭建

- (void)setupUI {
    CALayer *blackLayer = [[CALayer alloc] init];
    [self.layer addSublayer:blackLayer];
    blackLayer.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00].CGColor;
    blackLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 10);
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [self addSubview:titleLabel];
    titleLabel.text = @"品类销售分析";
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(20);
    }];
    
    // 筛选按钮
    UIButton *filtrateButton = [[UIButton alloc] init];
    [self addSubview:filtrateButton];
    [filtrateButton setTitle:@"点击筛选" forState:UIControlStateNormal];
    [filtrateButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [filtrateButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [filtrateButton addTarget:self action:@selector(filtrateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [filtrateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-12);
        make.top.bottom.mas_equalTo(titleLabel);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    [self addSubview:lineView];
    lineView.backgroundColor = [UIColor blackColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(2);
        make.right.mas_equalTo(self);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(filtrateButton.mas_bottom);
    }];
    
    UICollectionViewFlowLayout *normalLayout = [[UICollectionViewFlowLayout alloc] init];
    normalLayout.itemSize = CGSizeMake(40, 200);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0) collectionViewLayout:normalLayout];
    [self addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor colorWithRed:0.36 green:0.34 blue:0.42 alpha:1.00];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsHorizontalScrollIndicator = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerClass:[CQCategoryItemCell class] forCellWithReuseIdentifier:CQCategoryItemCellReuseID];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom);
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(SCREEN_WIDTH);
    }];
}

#pragma mark - 筛选按钮点击

- (void)filtrateButtonClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(categoryView:filtrateButtonClicked:)]) {
        [self.delegate categoryView:self filtrateButtonClicked:sender];
    }
}

#pragma mark - set model

- (void)setModel:(CQCategoryModel *)model {
    _model = model;
    
    CGFloat totalSaleAmount = 0;
    for (CQCategoryItemModel *itemModel in _model.category_sale) {
        totalSaleAmount += itemModel.sale_amount;
    }
    
    for (CQCategoryItemModel *itemModel in _model.category_sale) {
        if (totalSaleAmount == 0) {
            // 特殊处理只有一个item，并且SaleAmount还是0的情况
            itemModel.ratio = 1;
        } else {
            itemModel.ratio = itemModel.sale_amount/totalSaleAmount;
        }
    }
    
    // 计算列数
    NSInteger listCount = 0;
    for (int i = 0; i < _model.category_sale.count; i++) {
        if (i * i < _model.category_sale.count && (i+1) * (i+1) >= _model.category_sale.count) {
            listCount = i+1;
            break;
        }
    }
    
    // 计算行数
    NSInteger rowCount = ceil(_model.category_sale.count / (CGFloat)listCount);
    
    // 这个方阵是listCount*rowCount的矩阵（最后一排可能不足listCount）
    // 同一排的cell高度相同
    for (int i = 0; i < rowCount; i++) { // 行
        CGFloat rowArea = 0; // 行面积
        for (int j = 0; j < listCount; j++) { // 列
            if (i*listCount+j>=_model.category_sale.count) {
                break;
            }
            CQCategoryItemModel *itemModel = _model.category_sale[i*listCount+j];
            itemModel.size = itemModel.ratio * (self.collectionView.width*self.collectionView.width);
            rowArea += itemModel.size;
        }
        // 计算cell的宽高
        for (int j = 0; j < listCount; j++) { // 列
            if (i*listCount+j>=_model.category_sale.count) {
                break;
            }
            CQCategoryItemModel *itemModel = _model.category_sale[i*listCount+j];
            itemModel.height = rowArea / self.collectionView.width;
            itemModel.width = itemModel.size / itemModel.height;
        }
    }
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView DataSource && Delegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CQCategoryItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CQCategoryItemCellReuseID forIndexPath:indexPath];
    cell.model = self.model.category_sale[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CQCategoryItemModel *model = self.model.category_sale[indexPath.row];
    // 减去0.01，避免因小数不精确存储导致一组cell宽度相加超过collectionView的宽度
    return CGSizeMake(model.width-0.01, model.height);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.category_sale.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(categoryView:clickedCellAtIndex:)]) {
        [self.delegate categoryView:self clickedCellAtIndex:indexPath.row];
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

@end
