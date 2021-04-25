//
//  BAGridVIewVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/5/14.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "BAGridVIewVC.h"
#import "BAGridView.h"

@interface BAGridVIewVC ()
@property(nonatomic, strong) BAGridView *gridView;
@property(nonatomic, strong) BAGridView *gridView2;
@property(nonatomic, strong) BAGridView_Config *ba_GridViewConfig;
@property(nonatomic, strong) BAGridView_Config *ba_GridViewConfig2;
@property(nonatomic, strong) NSMutableArray  <BAGridItemModel *> *gridDataArray;
@property(nonatomic, strong) NSMutableArray  <BAGridItemModel *> *gridDataArray2;
@end

@implementation BAGridVIewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Wonderful_WhiteColor3;
    self.gridView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    self.gridView2.frame = CGRectMake(0, 250, SCREEN_WIDTH, 200);
    [self.view addSubview:self.gridView];
    [self.view addSubview:self.gridView2];
}

- (BAGridView_Config *)ba_GridViewConfig {
    if (!_ba_GridViewConfig) {
        _ba_GridViewConfig = [[BAGridView_Config alloc] init];
    }
    return _ba_GridViewConfig;
}
- (BAGridView_Config *)ba_GridViewConfig2 {
    if (!_ba_GridViewConfig2) {
        _ba_GridViewConfig2 = [[BAGridView_Config alloc] init];
    }
    return _ba_GridViewConfig2;
}

- (BAGridView *)gridView
{
    if (!_gridView)
    {
        self.ba_GridViewConfig.scrollEnabled = YES;
        // 是否显示分割线
        self.ba_GridViewConfig.showLineView = YES;
        // item：分割线颜色，默认：BAKit_Color_Gray_11【BAKit_Color_RGB(248, 248, 248)】
        self.ba_GridViewConfig.ba_gridView_lineColor = BAKit_Color_Red_pod;
        // item：每行 item 的个数，默认为4个
        self.ba_GridViewConfig.ba_gridView_rowCount = 4;
        // item：高度/宽度
        self.ba_GridViewConfig.ba_gridView_itemHeight = 100;
        //        self.ba_GridViewConfig.ba_gridView_itemWidth = kGridView_itemWidth;
        
        // item：图片与文字间距（或者两行文字类型的间距），默认：0
        self.ba_GridViewConfig.ba_gridView_itemImageInset = 5;
        //  item：title 颜色，默认：BAKit_Color_Black【[UIColor blackColor]】
        //            self.ba_GridViewConfig.ba_gridView_titleColor = BAKit_Color_Black;
        // item：title Font，默认：图文样式下 16，两行文字下（上25，下12）
        self.ba_GridViewConfig.ba_gridView_titleFont = [UIFont boldSystemFontOfSize:15];
        // item：背景颜色，默认：BAKit_Color_White
        self.ba_GridViewConfig.ba_gridView_backgroundColor = [UIColor yellowColor];
        // item：背景选中颜色，默认：无色
        self.ba_GridViewConfig.ba_gridView_selectedBackgroundColor = BAKit_Color_Red_pod;
        self.ba_GridViewConfig.dataArray = self.gridDataArray;
        //        self.ba_GridViewConfig.ba_gridView_itemEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        //        self.ba_GridViewConfig.minimumLineSpacing = 10;
        //        self.ba_GridViewConfig.minimumInteritemSpacing = 10;
        
         self.ba_GridViewConfig.gridViewType = BAGridViewTypeImageTitle;
        _gridView = [BAGridView ba_creatGridViewWithGridViewConfig:self.ba_GridViewConfig block:^(BAGridItemModel *model, NSIndexPath *indexPath) {
            
            BAKit_ShowAlertWithMsg_ios8(model.titleString);
        }];
    }
    return _gridView;
}

- (BAGridView *)gridView2
{
    if (!_gridView2)
    {
        self.ba_GridViewConfig2.showLineView = YES;
        
        // item：分割线颜色，默认：BAKit_Color_Gray_11【BAKit_Color_RGB(248, 248, 248)】
        self.ba_GridViewConfig2.ba_gridView_lineColor = BAKit_Color_Red_pod;
        // item：每行 item 的个数，默认为4个
        self.ba_GridViewConfig2.ba_gridView_rowCount = 4;
        // item：高度
        self.ba_GridViewConfig2.ba_gridView_itemHeight = 100;
        self.ba_GridViewConfig2.ba_gridView_itemWidth = 0;
        // item：图片与文字间距（或者两行文字类型的间距），默认：0
        //            self.ba_GridViewConfig.ba_gridView_itemImageInset = 10;
        //  item：title 颜色，默认：BAKit_Color_Black【[UIColor blackColor]】
        self.ba_GridViewConfig2.ba_gridView_titleColor = BAKit_Color_Black_pod;
        //  item：Desc 颜色，默认：BAKit_Color_Gray_9【BAKit_Color_RGB(216, 220, 228)】
        self.ba_GridViewConfig2.ba_gridView_titleDescColor = BAKit_Color_Gray_7_pod;
        // item：title Font，默认：图文样式下 16，两行文字下（上25，下12）
        self.ba_GridViewConfig2.ba_gridView_titleFont = [UIFont boldSystemFontOfSize:25];
        // item：Desc Font，默认：两行文字下 12
        self.ba_GridViewConfig2.ba_gridView_titleDescFont = [UIFont boldSystemFontOfSize:15];
        // item：背景颜色，默认：BAKit_Color_White
        self.ba_GridViewConfig2.ba_gridView_backgroundColor = [UIColor blueColor];
        // item：背景选中颜色，默认：无色
        self.ba_GridViewConfig2.ba_gridView_selectedBackgroundColor = [UIColor greenColor];
        self.ba_GridViewConfig2.dataArray = self.gridDataArray2;
        self.ba_GridViewConfig2.gridViewType = BAGridViewTypeTitleImage;
        _gridView2 = [BAGridView ba_creatGridViewWithGridViewConfig:self.ba_GridViewConfig2 block:^(BAGridItemModel *model, NSIndexPath *indexPath) {
            
            BAKit_ShowAlertWithMsg_ios8(model.titleString);
        }];
    }
    return _gridView2;
}

- (NSMutableArray <BAGridItemModel *> *)gridDataArray
{
    if (!_gridDataArray)
    {
        _gridDataArray = @[].mutableCopy;
        
        // 可以为本地图片
        //        NSArray *imageNameArray = @[@"tabbar_mainframeHL", @"tabbar_mainframeHL", @"tabbar_mainframeHL", @"tabbar_mainframeHL", @"tabbar_mainframeHL"];
        // 也可以是网络图片
        
        NSArray *imageNameArray;
        NSArray *bgImageNameArray;
        
        if (self.ba_GridViewConfig.gridViewType == BAGridViewTypeBgImageTitle)
        {
            bgImageNameArray = @[@"http://image.zhangxinxu.com/image/study/s/s256/mm1.jpg",
                                 @"http://image.zhangxinxu.com/image/study/s/s256/mm2.jpg",
                                 @"http://image.zhangxinxu.com/image/study/s/s256/mm3.jpg",
                                 @"http://image.zhangxinxu.com/image/study/s/s256/mm4.jpg",
                                 @"http://image.zhangxinxu.com/image/study/s/s256/mm5.jpg"];
        }else{
            imageNameArray = @[@"http://image.zhangxinxu.com/image/study/s/s256/mm6.jpg",
                               @"http://image.zhangxinxu.com/image/study/s/s256/mm7.jpg",
                               @"http://image.zhangxinxu.com/image/study/s/s256/mm8.jpg",
                               @"http://image.zhangxinxu.com/image/study/s/s256/mm9.jpg",
                               @"http://image.zhangxinxu.com/image/study/s/s256/mm10.jpg"];
        };
        
        if (self.ba_GridViewConfig.gridViewType == BAGridViewTypeImageTitle || self.ba_GridViewConfig.gridViewType == BAGridViewTypeTitleImage)
        {
            bgImageNameArray = @[@"http://image.zhangxinxu.com/image/study/s/s256/mm1.jpg",
                                 @"http://image.zhangxinxu.com/image/study/s/s256/mm2.jpg",
                                 @"http://image.zhangxinxu.com/image/study/s/s256/mm3.jpg",
                                 @"http://image.zhangxinxu.com/image/study/s/s256/mm4.jpg",
                                 @"http://image.zhangxinxu.com/image/study/s/s256/mm5.jpg"];
        }
        
        NSArray *titleArray = @[@"小区tabbar_main", @"商圈", @"社交57128423", @"出行", @"武术"];
        
        for (NSInteger i = 0; i < titleArray.count; i++)
        {
            BAGridItemModel *model = [BAGridItemModel new];
            if (imageNameArray.count > 0)
            {
                model.imageName = imageNameArray[i];
            }
            if (bgImageNameArray.count > 0)
            {
                model.bgImageName = bgImageNameArray[i];
            }
            model.placdholderImageName = @"tabbar_mainframeHL";
            model.titleString = titleArray[i];
            
            [self.gridDataArray addObject:model];
        }
    }
    return _gridDataArray;
}

- (NSMutableArray <BAGridItemModel *> *)gridDataArray2
{
    if (!_gridDataArray2)
    {
        _gridDataArray2 = @[].mutableCopy;
        
        NSArray *titleArray = @[@"200", @"20", @"200", @"10"];
        NSArray *descArray = @[@"新增积分总量", @"返还积分总量", @"全返单元总量", @"每单元返还积分"];
        
        for (NSInteger i = 0; i < titleArray.count; i++)
        {
            BAGridItemModel *model = [BAGridItemModel new];
            model.desc = descArray[i];
            model.titleString = titleArray[i];
            
            [_gridDataArray2 addObject:model];
        }
    }
    return _gridDataArray2;
}

@end
