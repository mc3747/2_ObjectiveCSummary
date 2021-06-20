//
//  BaseTabBarVC.m
//  CJWBaseObject_OC
//
//  Created by 陈经伟 on 2019/3/2.
//  Copyright © 2019 陈经伟. All rights reserved.
//

#import "BaseTabBarVC.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController4.h"
#import "BaseNaviVC.h"

@implementation BaseTabBarVC
- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.tabBar.tintColor = UIColor.systemBlueColor;
    
    //统一调整 导航栏 设置
//    EasyNavigationOptions *options = [EasyNavigationOptions shareInstance];
//    options.titleColor = UIColorFromHex(0xFFFFFF);
//    options.titleFont = [UIFont systemFontOfSize:19];
//    options.navigationBackButtonImage = [UIImage imageNamed:@"back_btn"];
//    options.buttonTitleColor = UIColorFromHex(0xFFFFFF);
//    options.navBackGroundColor = UIColorTheme;
    
    [self addChirdVC];
}

- (void)addChirdVC{
    ViewController1 *vc1 = [ViewController1 new];
    
    ViewController2 *vc2 = [ViewController2 new];
    
    ViewController3 *vc3 = [ViewController3 new];
    
    ViewController4 *vc4 = [ViewController4 new];
    
    [self setupChirdVC:vc1 :@"国内大厂" imageName:@"home_tabbar_1_"];
    [self setupChirdVC:vc2 :@"国际大厂" imageName:@"home_tabbar_2_"];
    [self setupChirdVC:vc3 :@"优秀仓库" imageName:@"home_tabbar_3_"];
    [self setupChirdVC:vc4 :@"优秀个人" imageName:@"home_tabbar_4_"];
}

- (void)setupChirdVC:(UIViewController *)vc :(NSString *)title imageName:(NSString *)imageName{
    vc.tabBarItem.title = title;
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.image = image;
    UIImage *pressImage = [UIImage imageNamed:@"home_tabbar_press"];
//    pressImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = pressImage;
    BaseNaviVC *navi = [[BaseNaviVC alloc] initWithRootViewController:vc];
    [self addChildViewController:navi];
    
}
@end
