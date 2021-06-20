//
//  ViewController.m
//  Json转模型
//
//  Created by ZSMAC on 2017/10/18.
//  Copyright © 2017年 ZSMAC. All rights reserved.
//

#import "ZSAnalysisVC.h"
#import "ZSAnalysisClass.h"
#import "CityNameModel.h"
#import "MyModel.h"
#import "People.h"
@interface ZSAnalysisVC ()

@end

@implementation ZSAnalysisVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGreen];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(100, 100, 150, 30);
    [btn setTitle:@"Data/Json转模型" forState:UIControlStateNormal];
    btn.backgroundColor=[UIColor redColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame=CGRectMake(100, 150, 150, 30);
    [btn2 setTitle:@"字典转模型" forState:UIControlStateNormal];
    btn2.backgroundColor=[UIColor redColor];
    [btn2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton * btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame=CGRectMake(100, btn2.frame.origin.y+btn2.frame.size.height+20, 150, 30);
    [btn3 setTitle:@"模型 转 字典" forState:UIControlStateNormal];
    btn3.backgroundColor=[UIColor redColor];
    [btn3 addTarget:self action:@selector(btn3Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
 
    
}
#pragma mark Data Json 解析转模型D
- (void)btnClick{
    NSString *jsonPath=[[NSBundle mainBundle]pathForResource:@"province_data.json" ofType:nil];
    NSData *jsonData=[[NSData alloc]initWithContentsOfFile:jsonPath];

    /* CityNameModel
     连级模型 下级模型名 一定要和父类属性名一致
     连级模型 下级模型名 一定要和父类属性名一致
     连级模型 下级模型名 一定要和父类属性名一致
     */

    ZSAnalysisClass * zsClass = [[ZSAnalysisClass alloc]parsingWithData:jsonData modelClassName:@"CityNameModel"];
    CityNameModel * model =zsClass.paresData;
    NSLog(@"--%@--%@",zsClass.paresData,model.province);
}

#pragma mark 字典转模型
- (void)btn2Click {
    
    NSMutableDictionary * dict2 = [[NSMutableDictionary alloc] init];
    [dict2 setObject:@"张三" forKey:@"name"];
    [dict2 setObject:@"24" forKey:@"age"];
    
     NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"属性1" forKey:@"attribute1"];
    [dict setObject:@"属性2" forKey:@"attribute2"];
    [dict setObject:@[dict2] forKey:@"People"];
    
    ZSAnalysisClass * zsClass = [[ZSAnalysisClass alloc]parsingWithData:dict modelClassName:@"MyModel"];
    MyModel * model;
    if (zsClass.isOk) {
         model =zsClass.paresData;
    } else {
        model=[[MyModel alloc] init];
    }
    NSLog(@"--%@--%@",zsClass.paresData,model.People);
}
#pragma mark 模型转字典
- (void)btn3Click {
    People * peopleModel = [[People alloc] init];
    peopleModel.name=@"张三";
     peopleModel.age=@"24";
    
    MyModel * model = [[MyModel alloc] init];
    model.attribute1=@"属性1";
    model.attribute2=@"属性2";
    model.People=@[peopleModel];
    
    NSDictionary * dict = [model reflectModelToDict];
    NSLog(@"模型转字典-%@",dict);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
