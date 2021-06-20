//
//  ViewController.m
//  BSYAlertBoxDemo
//
//  Created by 白仕云 on 2018/5/16.
//  Copyright © 2018年 BSY.com. All rights reserved.
//

#import "CommonToastVC.h"
#import "BSYAlertBox.h"

@interface CommonToastVC ()

@end

@implementation CommonToastVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self creatUICenter];
    [self creatUILeft];
    [self creatUIBottom];
    [self creatUIRight];
    [self creatUITop];

}

- (void)creatUICenter {

    UIButton *btn =[UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.frame = CGRectMake(self.view.center.x-50, self.view.center.y-50, 100, 100);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClicCenter) forControlEvents:UIControlEventTouchUpInside];


}

- (void)creatUILeft {

    UIButton *btn =[UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.frame = CGRectMake(20, self.view.center.y-50, 100, 100);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClicLeft) forControlEvents:UIControlEventTouchUpInside];


}

- (void)creatUIBottom {

    UIButton *btn =[UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.frame = CGRectMake(self.view.center.x-50, self.view.frame.size.height-100, 100, 70);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClicBottom) forControlEvents:UIControlEventTouchUpInside];


}

- (void)creatUIRight {

    UIButton *btn =[UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.frame = CGRectMake(self.view.frame.size.width-70, self.view.center.y-50, 100, 70);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClicRight) forControlEvents:UIControlEventTouchUpInside];


}

- (void)creatUITop {

    UIButton *btn =[UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.frame = CGRectMake(self.view.center.x-50, 44, 100, 100);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClicTop) forControlEvents:UIControlEventTouchUpInside];


}


-(void)btnClicCenter
{


//    [[BSYAlertBox alloc]initCenterAlertBoxWithText:@"给个Star呗😂😂😂😂😂😂😂😂😂😂" During:2 textColor:[UIColor redColor] bgColor:[UIColor brownColor]];
    [[BSYAlertBox shareAlertBox] showCenterAlertBoxWithText:@"给个Star呗😂😂😂😂😂😂😂😂😂😂"];

}

-(void)btnClicLeft
{

    //        [[BSYAlertBox alloc]initLeftAlertWithText:@"给个Star呗😂😂😂😂😂😂😂😂😂😂" During:2 textColor:[UIColor redColor] bgColor:[UIColor brownColor]];
    [[BSYAlertBox shareAlertBox] showLeftAlertWithText:@"😂😂😂😂"];

}

-(void)btnClicBottom
{

    [[BSYAlertBox shareAlertBox] showBottomAlertWithText:@"提示错误❌❌❌❌❌❌❌❌❌❌" During:2 textColor:[UIColor redColor] bgColor:[UIColor orangeColor]];
//    [[BSYAlertBox alloc] initBottomAlertWithText:@"提示错误❌❌❌❌❌❌❌❌❌❌"];

}



-(void)btnClicRight
{
    //[[BSYAlertBox alloc]initRightAlertWithText:@"给个Star呗😂😂😂😂😂😂😂😂😂😂" During:2 textColor:[UIColor redColor] bgColor:[UIColor brownColor]];
    [[BSYAlertBox shareAlertBox] showRightAlertWithText:@"给个Star呗"];

}

-(void)btnClicTop
{

     [[BSYAlertBox shareAlertBox] showTopAlertWithText:@"给个Star呗 ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️！！！！" During:2 textColor:[UIColor redColor] bgColor:[UIColor yellowColor]];
//    [[BSYAlertBox alloc] initTopAlertWithText:@"给个Star呗😂😂😂😂😂😂😂😂😂😂"];

}


@end
