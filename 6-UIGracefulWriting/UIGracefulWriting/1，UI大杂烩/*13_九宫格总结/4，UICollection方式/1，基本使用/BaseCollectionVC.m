//
//  ViewController.m
//  UICollectionViewDemo1
//
//  Created by user on 15/11/1.
//  Copyright © 2015年 BG. All rights reserved.
//

#import "BaseCollectionVC.h"
#import "BaseCollectionCell.h"

static NSString * const CellReuseIdentify = @"CellReuseIdentify";
static NSString * const SupplementaryViewHeaderIdentify = @"SupplementaryViewHeaderIdentify";
static NSString * const SupplementaryViewFooterIdentify = @"SupplementaryViewFooterIdentify";
@interface BaseCollectionVC ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation BaseCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark -  创建UICollectionViewFlowLayout
/*
 
 1、首先一个重要的属性是itemSize，它定义了每一个item的大小。通过设定itemSize可以全局地改变所有cell的尺寸，如果想要
     对某个cell制定尺寸，可以使用-collectionView:layout:sizeForItemAtIndexPath:方法。
 2、间隔 可以指定item之间的间隔和每一行之间的间隔，和size类似，有全局属性，也可以对每一个item和每一个section做出设定：
         @property (CGSize) minimumInteritemSpacing
         @property (CGSize) minimumLineSpacing
         -collectionView:layout:minimumInteritemSpacingForSectionAtIndex:
         -collectionView:layout:minimumLineSpacingForSectionAtIndex:
 3、滚动方向 由属性scrollDirection确定scroll view的方向，将影响Flow Layout的基本方向和由header及footer确定
     的section之间的宽度
         UICollectionViewScrollDirectionVertical
         UICollectionViewScrollDirectionHorizontal
 4、Header和Footer尺寸 同样地分为全局和部分。需要注意根据滚动方向不同，header和footer的高和宽中只有一个会起作用。
     垂直滚动时section间宽度为该尺寸的高，而水平滚动时为宽度起作用。
         @property (CGSize) headerReferenceSize
         @property (CGSize) footerReferenceSize
         -collectionView:layout:referenceSizeForHeaderInSection:
         -collectionView:layout:referenceSizeForFooterInSection:
 5、缩进
         @property UIEdgeInsets sectionInset;
         -collectionView:layout:insetForSectionAtIndex:
 */
- (UICollectionViewFlowLayout *)returnLayout {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    // 组间距
//    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    // 行间距
    layout.minimumLineSpacing = 10;
    // 元素间距
    layout.minimumInteritemSpacing = 10;
    // 元素大小
    layout.itemSize = CGSizeMake((self.view.frame.size.width - 20)/3.0, 100);
    // header和footer范围
    layout.headerReferenceSize = CGSizeMake(100, 10);
    layout.footerReferenceSize = CGSizeMake(100, 20);
    return layout;
}
#pragma mark -  创建collectionView
- (void)setupViews{
//    创建
    UICollectionViewFlowLayout *layout = [self returnLayout];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT - 100) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    
//注册：cell，header，footer都可以注册和重用
//    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellReuseIdentify];
    [collectionView registerNib:[UINib nibWithNibName:@"BaseCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CellReuseIdentify];
    //UICollectionElementKindSectionHeader注册是固定的
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SupplementaryViewHeaderIdentify];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:SupplementaryViewFooterIdentify];
}

#pragma mark - UICollectionViewDataSource method
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 10;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BaseCollectionCell *cell = (BaseCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellReuseIdentify forIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.textLabel.text = [NSString stringWithFormat:@"(%zd,%zd)", indexPath.section, indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        UICollectionReusableView *supplementaryView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SupplementaryViewHeaderIdentify forIndexPath:indexPath];
        supplementaryView.backgroundColor = [UIColor greenColor];
        return supplementaryView;
    }
    else if([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *supplementaryView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:SupplementaryViewFooterIdentify forIndexPath:indexPath];
        supplementaryView.backgroundColor = [UIColor redColor];
        return supplementaryView;
    }
    return nil;
}

#pragma mark - UICollectionViewDelegate method
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor blueColor];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = nil;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"section:%li ✅ row%li",indexPath.section,indexPath.row);
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{
    if ([NSStringFromSelector(action) isEqualToString:@"copy:"]
        || [NSStringFromSelector(action) isEqualToString:@"paste:"])
        return YES;
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{
    NSLog(@"复制之后，可以插入一个新的cell");
}


#pragma mark - UICollectionViewDelegateFlowLayout method
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if(section == 1){
        return CGSizeMake(100, 50);
    }
    return CGSizeMake(100, 10);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
