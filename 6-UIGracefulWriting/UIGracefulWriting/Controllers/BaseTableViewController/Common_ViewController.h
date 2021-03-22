//
//  Common_ViewController.h
//  ReactNativeDemo
//
//  Created by gjfax on 2018/7/31.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <UIKit/UIKit.h>
// =====================================================
/*
 注意：数据源是二维数组:
 例如：
 self.vcNameArray = @[@[@"CustomBannerScrollVC"],@[@"SDViewController"],@[@"BannerDemoVC"]];
 self.subtitleArray = @[@[@"普通滚动"],@[@"循环滚动"],@[@"复杂滚动"]];
 
 */
// =====================================================
typedef void (^ClickCellBlock) (NSIndexPath *indexPath);

@interface Common_ViewController : UIViewController
@property (nonatomic, copy) NSArray *vcNameArray;
@property (nonatomic, strong) NSArray *subtitleArray;
@property (nonatomic, strong) NSArray *sectionTitleArray;
@property (nonatomic, copy) ClickCellBlock clickBlock;

- (void)getSelfDefinedBlock:(ClickCellBlock)clickBlock with:(BOOL)isSelfDefined;

@end
