//
//  PackageCollectionViewVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/4/24.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "PackageCollectionViewVC.h"
#import "HActiveCollectionView.h"
@interface PackageCollectionViewVC ()

@end

@implementation PackageCollectionViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layput  =[[UICollectionViewFlowLayout alloc]init];
    layput.itemSize = CGSizeMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0);
    layput.minimumLineSpacing = 0;
    layput.minimumInteritemSpacing = 0;
    
    
    HActiveCollectionView *tableView = [[HActiveCollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layput];
    [self .view addSubview:tableView];
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (int index=0; index<10; index++) {
        [array addObject:[NSString stringWithFormat:@"index=%d",index]];
    }
    tableView.dataArray  =array;
    [tableView setGetCell_HActiveTableView:^(HActiveCollectionViewCell * _Nonnull cell, NSIndexPath * _Nonnull cellIndexPath) {
        
        CGRect rect  =CGRectMake(0, 0, layput.itemSize.width, layput.itemSize.height);
        
        UIView *view  =[[UIView alloc]initWithFrame:rect];
        view.backgroundColor = [UIColor colorWithRed:(cellIndexPath.row*7.5)/255.0 green:(cellIndexPath.row*3+150)/255.0 blue:(cellIndexPath.row*2+100)/255.0 alpha:1];
        [cell addSubview:view];
        
    }];
    
    [tableView setDidSelectRowCell_HActiveTableView:^(HActiveCollectionViewCell * _Nonnull cell, NSIndexPath * _Nonnull cellIndexPath) {
        
        NSLog(@"   %d",cellIndexPath.row);
    }];
}



@end
