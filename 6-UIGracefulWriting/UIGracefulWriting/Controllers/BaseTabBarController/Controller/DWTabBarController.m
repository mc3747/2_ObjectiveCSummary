//
//  DWTabBarController.m
//  DWCustomTabBarDemo
//
//  Created by Damon on 10/20/15.
//  Copyright © 2015 damonwong. All rights reserved.
//

#import "DWTabBarController.h"
#import "Base_1_ViewController.h"
#import "Base_2_ViewController.h"
#import "Base_3_ViewController.h"
#import "Base_4_ViewController.h"
#import "LayerAndAnimateVC.h"

#import "JDCustomNavigationController.h"
#import "DWTabBar.h"

#define DWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define DWRandomColor DWColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

@implementation DWTabBarController

#pragma mark -
#pragma mark - Life Cycle

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
// tabBar设置
    // 设置 TabBarItemTestAttributes 的颜色。
    [self setUpTabBarItemTextAttributes];
    
    // 设置子控制器
    [self setUpChildViewController];
    
    // 处理tabBar，使用自定义 tabBar 添加 发布按钮
    [self setUpTabBar];
    
    [[UITabBar appearance] setBackgroundImage:[self imageWithColor:[UIColor whiteColor]]];
    
    //去除 TabBar 自带的顶部阴影
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
 
// navigationBar设置
    //设置导航控制器颜色为黄色
    [[UINavigationBar appearance] setBackgroundImage:[self imageWithColor:DWColor(253, 218, 68)] forBarMetrics:UIBarMetricsDefault];

    //设置导航控制器文字颜色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[DWColor(253, 218, 68) reverseColor]}];
    
}

#pragma mark - Private Methods

/**
 *  利用 KVC 把 系统的 tabBar 类型改为自定义类型。
 */
- (void)setUpTabBar{
    
    [self setValue:[[DWTabBar alloc] init] forKey:@"tabBar"];
}


/**
 *  tabBarItem 的选中和不选中文字属性
 */
- (void)setUpTabBarItemTextAttributes{
    
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateHighlighted];
    
}


/**
 *  添加子控制器，我这里值添加了4个，没有占位自控制器
 */
- (void)setUpChildViewController{

    
    [self addOneChildViewController:[[JDCustomNavigationController alloc]initWithRootViewController:[[Base_1_ViewController alloc] init]]
                          WithTitle:@"UI总结"
                          imageName:@"home_normal"
                  selectedImageName:@"home_highlight"];
    
    [self addOneChildViewController:[[JDCustomNavigationController alloc]initWithRootViewController:[[Base_2_ViewController alloc] init]]
                          WithTitle:@"UI高阶"
                          imageName:@"mycity_normal"
                  selectedImageName:@"mycity_highlight"];
    
    
    [self addOneChildViewController:[[JDCustomNavigationController alloc]initWithRootViewController:[[Base_3_ViewController alloc]init]]
                          WithTitle:@"UI借鉴"
                          imageName:@"message_normal"
                  selectedImageName:@"message_highlight"];
    
    
    [self addOneChildViewController:[[JDCustomNavigationController alloc]initWithRootViewController:[[LayerAndAnimateVC alloc]init]]
                          WithTitle:@"UI绘制"
                          imageName:@"account_normal"
                  selectedImageName:@"account_highlight"];
    
}

/**
 *  添加一个子控制器
 *
 *  @param viewController    控制器
 *  @param title             标题
 *  @param imageName         图片
 *  @param selectedImageName 选中图片
 */

- (void)addOneChildViewController:(UIViewController *)viewController WithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    
    viewController.view.backgroundColor     = DWRandomColor;
    viewController.tabBarItem.title         = title;
    viewController.tabBarItem.image         = [UIImage imageNamed:imageName];
    UIImage *image = [UIImage imageNamed:selectedImageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = image;
    [self addChildViewController:viewController];
    
}


//这个方法可以抽取到 UIImage 的分类中
- (UIImage *)imageWithColor:(UIColor *)color
{
    NSParameterAssert(color != nil);
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // Create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);   // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
