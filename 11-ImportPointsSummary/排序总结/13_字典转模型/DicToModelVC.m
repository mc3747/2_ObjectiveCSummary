//
//  ViewController.m
//  字典转模型
//
//  Created by gjfax on 2017/10/30.
//  Copyright © 2017年 macheng. All rights reserved.
//

#import "DicToModelVC.h"
#import "TestModel.h"
#import "ZSAnalysisClass.h"
#import "MJExtension.h"
#import "YYModel.h"
#import "WHCModelVC.h"
#import "ZSAnalysisVC.h"
#import "MJExtensionVC.h"

@interface DicToModelVC ()
@property (nonatomic, strong) UITextView *logTextView;
@end

@implementation DicToModelVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = RandColor;
    
}

#pragma mark -  使用gjs的model工具：包含几种模型的写法
- (IBAction)test1:(id)sender {
    TestModel *model = [TestModel modelWithDict:[self getTestDic]];
    NSString *age = model.age;
    NSLog(@"%@",model);
    MCLogout(age);
}
#pragma mark -  测试ZSAnalysis
- (IBAction)test2:(id)sender {
//    ZSAnalysisClass *zsClass = [[ZSAnalysisClass alloc] parsingWithData:[self getTestDic] modelClassName:@"TestModel"];
//    TestModel *zsModel = zsClass.paresData;
//    NSString *zsName = zsModel.name;
//    NSString *zsAge = zsModel.age;
//    //    NSString *zsWidth = zsModel.frame[2].width;
//    NSLog(@"zsName%@",zsName);
//    NSLog(@"zsAge%@",zsAge);
    ZSAnalysisVC *vc = [[ZSAnalysisVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark -  测试YYModel
- (IBAction)test3:(id)sender {
    TestModel *model3 = [TestModel mj_objectWithKeyValues:[self getTestDic]];
    NSString *zsName3 = model3.name;
    NSString *zsAge3 = model3.age;
    NSString *zsWidth3 = model3.frame[0];
    NSLog(@"zsName3%@",zsName3);
    NSLog(@"zsAge3%@",zsAge3);
    NSLog(@"zsWidth3%@",zsWidth3);
}
#pragma mark -  测试MJExtension
- (IBAction)test4:(id)sender {
//    TestModel *model4 = [TestModel yy_modelWithDictionary:[self getTestDic]];
//    NSString *zsName4 = model4.name;
//    NSString *zsAge4 = model4.age;
//    NSString *zsWidth4 = model4.frame[0];
//    NSLog(@"zsName4%@",zsName4);
//    NSLog(@"zsAge4%@",zsAge4);
//    NSLog(@"zsWidth4%@",zsWidth4);
    MJExtensionVC *vc = [MJExtensionVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -  测试JsonModel
- (IBAction)test5:(id)sender {
    
}

#pragma mark -  测试WHCModel
- (IBAction)test6:(id)sender {
    WHCModelVC *vc = [WHCModelVC new];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark -  测试数据
- (NSDictionary *)getTestDic {
    NSDictionary *dic = @{@"name":@"Tom",
                          @"age":@"15",
                          @"frame":@[@{@"width":@"12",@"heighth":@"22"},
                                     @{@"width":@"13",@"heighth":@"33"},
                                     @{@"width":@"14",@"heighth":@"44"},
                                     @{@"width":@"15",@"heighth":@"55"}
                                  ]
                          };
    return dic;
}


@end
