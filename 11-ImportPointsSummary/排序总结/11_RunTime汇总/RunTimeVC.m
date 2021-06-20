//
//  RunTimeVC.m
//  排序总结
//
//  Created by gjfax on 2018/10/17.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "RunTimeVC.h"
#define  kScreenWidth [UIScreen mainScreen].bounds.size.width
#define  kScreenWidth [UIScreen mainScreen].bounds.size.width
#define  kLineNum 3
#define  kLineSpacing 5
@interface MyCollectionViewCell:UICollectionViewCell
- (void)updateDisplay:(UIColor *)bgColor title:(NSString *)title;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation MyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame  {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor lightSalmon];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height * 0.25f, frame.size.width, frame.size.height * 0.5f)];
        titleLabel.numberOfLines = 0;
        titleLabel.font = [UIFont systemFontOfSize:14.f];
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return self;
}

- (void)updateDisplay:(UIColor *)bgColor title:(NSString *)title{
    _titleLabel.text = title;
    _titleLabel.backgroundColor = bgColor;
    
}
@end

@interface RunTimeVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) NSArray *classArray;
@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation RunTimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    _titleArray = @[@"1,runTime基础",@"2，消息机制",@"3，动态修改属性",@"4，动态添加属性",@"5，动态添加方法",@"6，动态交换方法",@"7，拦截替换方法",@"8，方法添加额外功能",@"9，自动归档",@"10，字典自动转模型",@"11，找到苹果所有类的属性，方法，协议",@"12，完美封装",@"13，关联对象及应用"];
        _classArray = @[@"RunTimeBaseVC",@"LNMessageViewController",@"LNChangeAttributesVC",@"LNAddAttributesViewController",@"LNAddMethodsViewController",@"LNExchangeMethodViewController",@"",@"",@"",@"",@"GetPrivateVC",@"PackageRuntimeVC",@"AssociatedMethodVC"];
    [self initCollectionView];
}

- (void)initCollectionView {
    /**创建layout*/
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    /**创建collectionView*/
    UICollectionView* collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor cyanColor];
    /**
     注册item和区头视图、区尾视图
     */
    [collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"MyCollectionViewCell"];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyCollectionViewHeaderView"];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"MyCollectionViewFooterView"];
    [self.view addSubview:collectionView];
    
  
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
/**
 分区个数
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
/**
 每个分区item的个数
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _titleArray.count;
}
/**
 创建cell
 */
- (__kindof MyCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifer = @"MyCollectionViewCell";
    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifer forIndexPath:indexPath];
    [cell updateDisplay:[UIColor plumColor] title:_titleArray[indexPath.item]];
    return cell;
}

/**
 创建区头视图和区尾视图
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader){
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MyCollectionViewHeaderView" forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor yellowColor];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:headerView.bounds];
        titleLabel.text = [NSString stringWithFormat:@"第%ld个分区的区头",indexPath.section];
        [headerView addSubview:titleLabel];
        return headerView;
    }else if(kind == UICollectionElementKindSectionFooter){
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MyCollectionViewFooterView" forIndexPath:indexPath];
        footerView.backgroundColor = [UIColor blueColor];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:footerView.bounds];
        titleLabel.text = [NSString stringWithFormat:@"第%ld个分区的区尾",indexPath.section];
        [footerView addSubview:titleLabel];
        return footerView;
    }
    return nil;
    
    
}
/**
 点击某个cell
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了第%ld分item",(long)indexPath.item);
    [self jumpToVC:_classArray[indexPath.row] title:_titleArray[indexPath.row]];
}
/**
 cell的大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemW = (kScreenWidth-(kLineNum+1)*kLineSpacing)/kLineNum-0.001;
    return CGSizeMake(itemW, itemW);
}
/**
 每个分区的内边距（上左下右）
 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(kLineSpacing, kLineSpacing, kLineSpacing, kLineSpacing);
}
/**
 分区内cell之间的最小行间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return kLineSpacing;
}
/**
 分区内cell之间的最小列间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return kLineSpacing;
}
/**
 区头大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kScreenWidth, 65);
}
/**
 区尾大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(kScreenWidth, 65);
}


#pragma mark -  跳转
- (void)jumpToVC:(NSString *)className title:(NSString *)classTitle{
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *ctrl = class.new;
        ctrl.title = classTitle;
        ctrl.view.backgroundColor = [UIColor lavender];
        [self.navigationController pushViewController:ctrl animated:YES];
    };
}
@end
