//
//  CustomTabBarVC.m
//  IOS_KnowledgePoints
//
//  Created by gjfax on 2017/12/27.
//  Copyright © 2017年 macheng. All rights reserved.
//

#import "CustomTabBarVC.h"
#import "CustomBaseVC.h"
#import "CustomNaviVC.h"

@interface CustomTabBarVC ()

@end

@implementation CustomTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubControllers];
    
}



#pragma mark - 添加子控制器
- (void)addSubControllers {
    NSArray *nomarlImageArr = @[@"tabbar_mainframe_25x23_",@"tabbar_contacts_27x23_",@"tabbar_discover_23x23_",@"tabbar_me_23x23_"];
    NSArray *selectImageArr = @[@"tabbar_mainframeHL_25x23_",@"tabbar_contactsHL_27x23_",@"tabbar_discoverHL_23x23_",@"tabbar_meHL_23x23_"];
    
    //  基础
    CustomBaseVC *homeVc = [[CustomBaseVC alloc] init];
    [self addOneChildVc:homeVc title:@"基础" imageName:nomarlImageArr[0] selectedImageName:selectImageArr[0]];
    
    //  UI
    CustomBaseVC *productVc = [[CustomBaseVC alloc] init];
    [self addOneChildVc:productVc title:@"UI" imageName:nomarlImageArr[1] selectedImageName:selectImageArr[1]];
    
    //  进阶
    CustomBaseVC *assetVc = [[CustomBaseVC alloc] init];
    [self addOneChildVc:assetVc title:@"进阶" imageName:nomarlImageArr[2] selectedImageName:selectImageArr[2]];
    
    //  大神
    CustomBaseVC *moreVc=[[CustomBaseVC alloc] init];
    [self addOneChildVc:moreVc title:@"大神" imageName:nomarlImageArr[3] selectedImageName:selectImageArr[3]];
    
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbarBkg_5x49_@2x"];
}

#pragma mark - 设置每个子控制器
- (void)addOneChildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    //  设置tabbar 和 navi 的title
    childVc.title = title;
    
    //  设置图标
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    childVc.tabBarItem.image = image;
    childVc.tabBarItem.selectedImage = selectedImage;
    
    //  添加为tabbar控制器的子控制器
    CustomNaviVC *nav = [[CustomNaviVC alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}


@end
