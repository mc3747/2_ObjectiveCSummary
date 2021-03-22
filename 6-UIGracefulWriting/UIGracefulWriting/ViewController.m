//
//  ViewController.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/6/13.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "ViewController.h"
#import "CommonViewController.h"

#import "BannerDemoVC.h"
#import "SDViewController.h"

#import "LeftViewController.h"
#import "RightViewController.h"
#import "SWRevealViewController.h"
#import "Demo1ViewController.h"
#import "CommonUnderlineButton.h"
#import "TextViewViewController.h"

#import "TabView_1_ViewController.h"
#import "TabView_2_ViewController.h"
#import "TabView_3_ViewController.h"
#import "TabView_4_ViewController.h"
#import "TabView_5_ViewController.h"
#import "TabView_6_ViewController.h"

#import "Common_ViewController.h"
#import "SGEventVC.h"
#import "SGCountdownVC.h"
#import "SGImagePositionVC.h"



@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIButton *btn5;
@property (weak, nonatomic) IBOutlet UIButton *btn6;
@property (weak, nonatomic) IBOutlet UIButton *btn7;
@property (weak, nonatomic) IBOutlet UIButton *btn8;
@property (weak, nonatomic) IBOutlet UIButton *btn9;
@property (weak, nonatomic) IBOutlet UIButton *btn10;
@property (weak, nonatomic) IBOutlet UIButton *btn11;
@property (weak, nonatomic) IBOutlet UIButton *btn12;
@property (weak, nonatomic) IBOutlet UIButton *btn13;
@property (weak, nonatomic) IBOutlet UIButton *btn14;
@property (weak, nonatomic) IBOutlet UIButton *btn15;
@property (weak, nonatomic) IBOutlet UIButton *btn16;
@property (weak, nonatomic) IBOutlet UIButton *btn17;
@property (weak, nonatomic) IBOutlet UIButton *btn18;
@property (weak, nonatomic) IBOutlet UIButton *btn19;
@property (weak, nonatomic) IBOutlet UIButton *btn20;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    NSArray *buttonArray = @[_btn1,_btn2,_btn3,_btn4,_btn5,_btn6,_btn7,_btn8,_btn9,_btn10,_btn11,_btn12,_btn13,_btn14,_btn15,_btn16,_btn17,_btn18,_btn19,_btn20];
    [buttonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = (UIButton*)obj;
        NSString *selName = [NSString stringWithFormat:@"test%li",idx + 1];
        SEL sel = NSSelectorFromString(selName);
        [button addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    }];
}




#pragma mark -  21,其他
- (void)test20 {
    Common_ViewController *vc = [[Common_ViewController alloc] init];
    
    vc.title = @"其他UI效果";
    
    vc.vcNameArray =
@[
@[@"CQJigsawViewController"],
@[@"ClickableLabelVC",@"LabelLeaveSpaceVC",@"CountDownLabelVC",@"LabelAlignVC",@"AdjustSizeVC",@"MoneyAnimationVC"],
@[@"EnlargeButtonVC",@"SGImagePositionVC",@"UnderlineButtonVC",@"SGEventVC",@"SGCountdownVC",@"JMButtonVC"],
@[@"TabView_1_ViewController",@"TabView_2_ViewController",@"TabView_3_ViewController",@"TabView_4_ViewController",@"TabView_5_ViewController",@"TabView_6_ViewController",@"NoDataTableViewVC",@"MemoTableViewController"],
@[@"ScrollPageVC"],
@[@"SWRevealVC"],
@[@"InputFloatVC",@"InputFilterVC"],
@[@"TextViewViewController"],
@[@"WonderfulColorVC",@"ShadeEffectVC"],
@[@"IconFontViewController"],
@[@"AlertViewController",@"AlertTableViewController",@"ActionSheetTableViewController",@"ShowViewController"],
@[@"RichTextVC"],
@[@"NineGridVC"],
@[@"SelfCascadeVC",@"YZDropViewController",@"DropDownViewController",],
@[@"FatherAndSonVC",@"Switch2_ViewController",@"Switch3_ViewController",@"Switch4_ViewController",@"STListController"],
@[@"TestViewController"],
@[@"DimImageViewController",@"ScreenShotVC",@"CreateQRCodeVC"]];

vc.subtitleArray = @[
@[@"比例拼图"],
@[@"可点击label",@"label留白",@"倒计时label",@"label文字对齐各种效果",@"自适应宽高的label",@"金额跳动label"],
@[@"扩大点击button",@"文字图片组合button",@"带下划线button",@"防重复点击button",@"倒计时button",@"各种样式的button"],
@[@"原生常用",@"自定义等高",@"自定义不等高",@"优雅地写",@"炫酷效果",@"性能优化",@"无数据动画",@"便签效果"],
@[@"ScrollView相关"],
@[@"CollectionView相关"],
@[@"输入上浮",@"输入过滤"],
@[@"textview设置下划线"],
@[@"完美颜色",@"渐变效果"],
@[@"IconFont的使用"],
@[@"系统alert和sheet",@"LEE的alert",@"LEE的sheet",@"JXT的Alert汇总"],
@[@"富文本总结"],
@[@"九宫格总结"],
@[@"自己总结",@"袁崢二级菜单",@"仿美团二级菜单"],
@[@"父子控制器",@"袁崢切换",@"SGPagingView横向切换",@"JXCategory横向切换",@"ST顶部可滚动切换"],
@[@"测试控制器跳转过渡页"],
@[@"模糊效果",@"截屏展示",@"生成二维码"]];

    
    vc.sectionTitleArray =@[@"view相关",@"lable相关",@"button相关",@"tableView相关",@"scrollView相关",
                            @"collectionView相关",@"textField相关",@"textView相关",@"颜色总结",@"字体总结",

                            @"弹框总结",@"富文本总结",@"九宫格总结",@"多级联动总结",@"导航切换总结",@"跳转方案总结",@"其他效果"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -  push出通用控制器
- (void)pushVCWithView:(UIView *)view {
    CommonViewController *vc = [[CommonViewController alloc] init];
    [vc.view addSubview:view];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
