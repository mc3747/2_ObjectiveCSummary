//
//  Base_2_ViewController.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/3/13.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "Base_1_ViewController.h"

@interface Base_1_ViewController ()

@end

@implementation Base_1_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UI总结";
    self.vcNameArray =@[
    @[@"ClickableLabelVC"],
    @[@"ClickableLabelVC",@"DAViewController",@"AttributedClickableLabelVC",@"LabelLeaveSpaceVC",@"CountDownLabelVC",@"LabelAlignVC",@"AdjustSizeVC",@"MoneyAnimationVC"],
    @[@"EnlargeButtonVC",@"SGImagePositionVC",@"UnderlineButtonVC",@"SGEventVC",@"SGCountdownVC",@"JMButtonVC",@"LoadingButtonVC",@"AnimatingButtonVC"],
    @[@"TabView_1_ViewController",@"TableView_plain_ViewController",@"TableView_group_ViewController",@"ElegantTableViewVC",@"TabView_2_ViewController",@"TabView_3_ViewController",@"NotEquelCellHeightVC",@"GracefulTableViewVC",@"TabView_5_ViewController",@"TabView_6_ViewController",@""],
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
    
    self.subtitleArray = @[
        @[@"控件的快速写法"],
    @[@"可点击label",@"可点击label（轻量型）",@"可点击label（自定义总结）",@"label留白",@"倒计时label",@"label文字对齐各种效果",@"自适应宽高的label",@"金额跳动label"],
    @[@"扩大点击button",@"文字图片组合button",@"带下划线button",@"防重复点击button",@"倒计时button",@"各种样式的button",@"带loading框的button",@"点击后变形动画的button"],
    @[@"原生常用",@"plain格式",@"group格式",@"一般封装",@"自定义等高",@"常用自定义不等高",@"自定义不等高的5种写法",@"优雅地写",@"炫酷效果",@"性能优化",@""],
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
    
    
    self.sectionTitleArray =@[@"view相关",@"lable相关",@"button相关",@"tableView相关",@"scrollView相关",
                              @"collectionView相关",@"textField相关",@"textView相关",@"颜色总结",@"字体总结",
                              @"弹框总结",@"富文本总结",@"九宫格总结",@"多级联动总结",@"导航切换总结",@"跳转方案总结",@"索引动画总结",@"其他效果"];
}




@end
