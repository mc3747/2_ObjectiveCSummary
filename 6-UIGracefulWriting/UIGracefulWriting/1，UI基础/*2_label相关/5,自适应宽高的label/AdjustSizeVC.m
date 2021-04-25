//
//  ViewController.m
//  LabelDemo
//
//  Created by zhuchenglong on 16/7/22.
//  Copyright © 2016年 zhuchenglong. All rights reserved.
//

#import "AdjustSizeVC.h"
#import "NSObject+size.h"
//应用程序的屏幕宽、高
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kWidth  [UIScreen mainScreen].bounds.size.width
@interface AdjustSizeVC ()

@end

@implementation AdjustSizeVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
//    普通label宽度适应内容
    UILabel *normalLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 66, 200, 50)];
    normalLabel1.backgroundColor = [UIColor cyanColor];
    
    normalLabel1.text = @"普通label宽度适应内容:我已知晓,且已阅读并同意以上条款";
    normalLabel1.font = [UIFont systemFontOfSize:13];
    normalLabel1.numberOfLines = 0;
    [normalLabel1 sizeToFit];//-------->注意和上面一句代码顺序不能颠倒
    [self.view addSubview:normalLabel1];
    
//    普通label字体适应宽度
    UILabel *normalLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, 200, 50)];
    normalLabel2.backgroundColor = [UIColor brownColor];
    normalLabel2.text = @"普通label字体适应宽度:我已知晓,且已阅读并同意以上条款";
    normalLabel2.adjustsFontSizeToFitWidth = YES;//默认为NO-------->注意和上面一句代码顺序不能颠倒
    [self.view addSubview:normalLabel2];
    
    //Label的宽度自适应
    UILabel *textLabel1 = [[UILabel alloc]init];
    textLabel1.backgroundColor = [UIColor yellowColor];
    textLabel1.font = [UIFont systemFontOfSize:13];
    textLabel1.text = @"1，label宽度自适应：我是宽度自适应哈哈哈哈哈哈哈66-->";
    CGRect frame1 = [textLabel1 getFrameWithFreeWidth:CGPointMake(10, 200) maxHight:30];
    textLabel1.frame = frame1;
    [self.view addSubview:textLabel1];
    
    
    //Label的高度自适应
    UILabel *textLabel2 = [[UILabel alloc]init];
    textLabel2.backgroundColor = [UIColor redColor];
    textLabel2.text = @"2，label高度自适应：我是高度自适应哈哈哈嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘻嘻嘻嘻-->";
    CGRect frame2 = [textLabel2 getFrameWithFreeHight:CGPointMake(10, 250) maxWidth:250];
    textLabel2.frame = frame2;
    [self.view addSubview:textLabel2];
    
   
    //Label的宽度自适应----->带字间距
    UILabel *textLabel3 = [[UILabel alloc]init];
    textLabel3.backgroundColor = [UIColor blueColor];
    textLabel3.text = @"3，label带字间距的宽度自适应：我是宽度自适应哈哈哈哈66-->";
    CGRect frame3 = [textLabel3 getFrameWithFreeWidth:CGPointMake(10, 350) maxHight:30 textSpace:5];
    textLabel3.frame = frame3;
    [self.view addSubview:textLabel3];

    
    //Label的高度自适应----->带行间距
    UILabel *textLabel4 = [[UILabel alloc]init];
    textLabel4.backgroundColor = [UIColor greenColor];
    textLabel4.text = @"4，label带行间距的宽度自适应：我是高度自适应哈哈哈嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘻嘻嘻嘻啦啦啦啦啦啦啦啦啦啦啦啦啦啦-->";
    CGRect frame4 = [textLabel4 getFrameWithFreeHight:CGPointMake(10, 450) maxWidth:250 textSpace:3 lineSpace:15];
    textLabel4.frame = frame4;
    [self.view addSubview:textLabel4];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *title = @"5，button自适应宽度：啦啦啦啦---我是Button---啦啦啦啦";
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = [UIColor orangeColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.frame = [button getFrameWithFreeWidth:CGPointMake(10, 650) maxHight:35];
    [self.view addSubview:button];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
