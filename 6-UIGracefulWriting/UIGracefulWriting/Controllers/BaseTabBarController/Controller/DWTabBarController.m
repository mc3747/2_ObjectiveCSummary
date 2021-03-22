//
//  DWTabBarController.m
//  DWCustomTabBarDemo
//
//  Created by Damon on 10/20/15.
//  Copyright © 2015 damonwong. All rights reserved.
//

#import "DWTabBarController.h"

#import "ViewController.h"
#import "Base_2_ViewController.h"
#import "Base_3_ViewController.h"
#import "Base_4_ViewController.h"

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
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    ViewController *mainVC = [storyboard instantiateInitialViewController];
    UIViewController *mainVC = [self getMainVC];
    
    [self addOneChildViewController:[[JDCustomNavigationController alloc]initWithRootViewController:mainVC]
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
    
    
    [self addOneChildViewController:[[JDCustomNavigationController alloc]initWithRootViewController:[[Base_4_ViewController alloc]init]]
                          WithTitle:@"UI框架"
                          imageName:@"account_normal"
                  selectedImageName:@"account_highlight"];
    
}
#pragma mark -  返回主控制器
- (UIViewController *)getMainVC {
    Common_ViewController *vc = [[Common_ViewController alloc] init];
    vc.title = @"UI总结";
    vc.vcNameArray =
@[
@[@"CQJigsawViewController"],
  @[@"ClickableLabelVC",@"DAViewController",@"AttributedClickableLabelVC",@"LabelLeaveSpaceVC",@"CountDownLabelVC",@"LabelAlignVC",@"AdjustSizeVC",@"MoneyAnimationVC"],
@[@"EnlargeButtonVC",@"SGImagePositionVC",@"UnderlineButtonVC",@"SGEventVC",@"SGCountdownVC",@"JMButtonVC",@"LoadingButtonVC",@"AnimatingButtonVC"],
@[@"TabView_1_ViewController",@"TableView_plain_ViewController",@"TableView_group_ViewController",@"TabView_2_ViewController",@"TabView_3_ViewController",@"NotEquelCellHeightVC",@"GracefulTableViewVC",@"TabView_5_ViewController",@"TabView_6_ViewController",@"NoDataTableViewVC",@"MemoTableViewController"],
  @[@"ScrollPageVC"],
  @[@"SWRevealVC"],
  @[@"InputFloatVC",@"InputFilterVC",@"CorverUpKeyboardVC",@"CoverKeyboardHeavyClassVC",@"InputWithSpaceVC",@"InputHistoryVC",@"FourElementViewController"],
  @[@"TextViewViewController",@"TextViewCategoryVC"],
  @[@"WonderfulColorVC",@"ShadeEffectVC"],
  @[@"IconFontViewController"],
@[@"AlertViewController",@"AlertTableViewController",@"ActionSheetTableViewController",@"ShowViewController",@"MoreAlertManageVC",@"RightUpPullDownVC"],
  @[@"RichTextVC"],
  @[@"NineGridVC"],
  @[@"SelfCascadeVC",@"YZDropViewController",@"DropDownViewController",],
  @[@"FatherAndSonVC",@"Switch2_ViewController",@"Switch3_ViewController",@"Switch4_ViewController",@"STListController"],
  @[@"TestViewController"],
  @[@"IndexAnimationVC"],
  @[@"DimImageViewController",@"ScreenShotVC",@"CreateQRCodeVC"]];
    
vc.subtitleArray = @[
  @[@"比例拼图"],
@[@"可点击label",@"可点击label（轻量型）",@"可点击label（自定义总结）",@"label留白",@"倒计时label",@"label文字对齐各种效果",@"自适应宽高的label",@"金额跳动label"],
@[@"扩大点击button",@"文字图片组合button",@"带下划线button",@"防重复点击button",@"倒计时button",@"各种样式的button",@"带loading框的button",@"点击后变形动画的button"],
@[@"原生常用",@"plain格式",@"group格式",@"自定义等高",@"常用自定义不等高",@"自定义不等高的5种写法",@"优雅地写",@"炫酷效果",@"性能优化",@"无数据动画",@"便签效果"],
  @[@"ScrollView相关"],
  @[@"CollectionView相关"],
  @[@"输入上浮",@"输入过滤",@"键盘遮挡问题(轻量级)",@"键盘遮挡问题（中量级）",@"输入带空格的封装",@"输入值联想",@"银行四要素大总结"],
  @[@"textview设置下划线",@"占位符+自动高度+添加图片"],
  @[@"完美颜色",@"渐变效果"],
  @[@"IconFont的使用"],
  @[@"系统alert和sheet",@"LEE的alert",@"LEE的sheet",@"JXT的Alert汇总",@"多级弹窗控制",@"仿微信右上角下拉"],
  @[@"富文本总结"],
  @[@"九宫格总结"],
  @[@"自己总结",@"袁崢二级菜单",@"仿美团二级菜单",],
  @[@"父子控制器",@"袁崢切换",@"SGPagingView横向切换",@"JXCategory横向切换",@"ST顶部可滚动切换"],
  @[@"测试控制器跳转过渡页"],
  @[@"索引动画总结"],
  @[@"模糊效果",@"截屏展示",@"生成二维码"]];
    
    
    vc.sectionTitleArray =@[@"view相关",@"lable相关",@"button相关",@"tableView相关",@"scrollView相关",
                            @"collectionView相关",@"textField相关",@"textView相关",@"颜色总结",@"字体总结",
                            @"弹框总结",@"富文本总结",@"九宫格总结",@"多级联动总结",@"导航切换总结",@"跳转方案总结",@"索引动画总结",@"其他效果"];
    return vc;
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
