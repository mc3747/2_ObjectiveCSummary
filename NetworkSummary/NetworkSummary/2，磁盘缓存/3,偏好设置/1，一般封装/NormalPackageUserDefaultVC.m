//
//  NormalPackageUserDefaultVC.m
//  NetworkSummary
//
//  Created by gjfax on 2019/4/24.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "NormalPackageUserDefaultVC.h"
#import "MCUserDefaultTool.h"

static NSString *const HActiveMangerID = @"HActiveManger";
@interface NormalPackageUserDefaultVC ()

@end

@implementation NormalPackageUserDefaultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self creatHActiveManger];
}

/**
 数据存储功能
 */
-(void)creatHActiveManger
{
    
    [MCUserDefaultTool deletedAllKey:HActiveMangerID Complete:^(BOOL complete, NSMutableArray * _Nonnull completeArray) {
        
        NSLog(@"   %d   %@",complete,completeArray);
        
    }];
    
    CGSize Manin = [UIScreen mainScreen].bounds.size;
    
    UIButton * creatHActiveManger = [self reutnBtnWithTitleString:@"开始保存数据" frame:CGRectMake((Manin.width-100)/2.0, 100, 200, 30) btnTag:100];
    [self.view addSubview:creatHActiveManger];
    
    
    UIButton * addHActiveManger = [self reutnBtnWithTitleString:@"增加保存数据" frame:CGRectMake((Manin.width-100)/2.0, 200, 200, 30) btnTag:200];
    [self.view addSubview:addHActiveManger];
    
    
    UIButton * updateHActiveManger = [self reutnBtnWithTitleString:@"更新数据" frame:CGRectMake((Manin.width-100)/2.0, 300, 200, 30) btnTag:300];
    [self.view addSubview:updateHActiveManger];
    
    
    UIButton * deletedHActiveManger = [self reutnBtnWithTitleString:@"删除保存数据" frame:CGRectMake((Manin.width-100)/2.0, 400, 200, 30) btnTag:400];
    [self.view addSubview:deletedHActiveManger];
    
}
-(void)btnClcik:(UIButton *)btn
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"小白" forKey:@"name"];
    [dict setObject:@"28" forKey:@"age"];
    
    
    NSMutableArray *array  =[NSMutableArray array];
    [array addObject:dict];
    switch (btn.tag) {
        case 100:
            [MCUserDefaultTool saveParameter:@"rrrr" Key:HActiveMangerID Complete:^(BOOL complete,NSMutableArray *completeArray) {
                
                NSLog(@"   %d   %@",complete,completeArray);
                
            }];
            break;
            
        case 200:
            [MCUserDefaultTool addSaveParameter:array Key:HActiveMangerID Complete:^(BOOL complete,NSMutableArray *completeArray) {
                
                NSLog(@"   %d   %@",complete,completeArray);
                
            }];
            break;
            
        case 300:
            [MCUserDefaultTool updateMajorValue:@"王小明" Key:HActiveMangerID majorkey:@"name" Complete:^(BOOL complete,NSMutableArray *completeArray) {
                
                NSLog(@"   %d   %@",complete,completeArray);
                
            }];
            break;
            
        case 400:
            
            [MCUserDefaultTool deletedMajorkey:@"age" MajorValue:@"28" Key:HActiveMangerID Complete:^(BOOL complete,NSMutableArray *completeArray) {
                NSLog(@"   %d   %@",complete,completeArray);
                
            }];
            
            break;
            
        default:
            break;
    }
}


-(UIButton *)reutnBtnWithTitleString:(NSString *)titleString frame:(CGRect)frame btnTag:(int)btnTag

{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame  =frame;
    [btn setTitle:titleString forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.tag =btnTag;
    [btn addTarget:self action:@selector(btnClcik:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
@end
