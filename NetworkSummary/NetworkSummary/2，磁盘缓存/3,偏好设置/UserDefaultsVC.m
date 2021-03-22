//
//  UserDefaultsVC.m
//  NetworkSummary
//
//  Created by gjfax on 2018/11/15.
//  Copyright © 2018 macheng. All rights reserved.
//

#import "UserDefaultsVC.h"
#import "SDUserDefaults.h"
#import "SDTextModel.h"
#import "LCUserDefaultsModel.h"
#import "NormalPackageUserDefaultVC.h"
@interface UserDefaultsVC ()

@end

@implementation UserDefaultsVC
// =====================================================
/*
 偏好设置： 很多iOS应用都支持偏好设置，比如保存用户名、密码、字体大小等设置，iOS提供了一套标准的解决方案来为应用加入偏好设置功能。每个应用都有个NSUserDefaults实例，通过它来存取偏好设置
 
 用NSUserDefaults存储的数据下次程序运行的时候依然存在，那么它把数据存储在什么地方了呢？
其实它存储在应用程序内置（沙盒）的一个plist文件里，路径是 /Library/Prefereces它的存储形式其实就是一种XML格式的文件
 */
// =====================================================
- (void)viewDidLoad {
    [super viewDidLoad];

    [self baseUse];
    
    [self modelPackageUse];
}
#pragma mark -  基本使用
- (void)baseUse{
    // 沙盒路径
    NSString *sandboxPath = NSHomeDirectory();
    NSLog(@"%@",sandboxPath);
    
    // 保存数据
    //获取NSUserDefaults对象
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //保存数据
    [defaults setObject:@"jack" forKey:@"name"];
    [defaults setInteger:20 forKey:@"age"];
    [defaults setBool:YES forKey:@"sex"];//YES表示性别为男性
    //同步数据
    [defaults synchronize];
    
    // 读取数据
    //获取NSUserDefaults对象
    //读取数据（类型需要与存储时保持一致）
    NSString *name = [defaults objectForKey:@"name"];
    NSInteger age = [defaults integerForKey:@"age"];
    BOOL sex = [defaults boolForKey:@"sex"];
    NSLog(@"name:%@;age:%ld;sex:%i",name,(long)age,sex);
    
    // 删除数据
    //    [defaults removeObjectForKey:@"sex"];
}
#pragma mark -  普通封装

- (IBAction)normalPackageAction:(id)sender {
    NormalPackageUserDefaultVC *vc = [[NormalPackageUserDefaultVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -  NSCopying封装
- (IBAction)addAction:(id)sender {
    [SDUserDefaults standardUserDefaults].SDName = @"用户数据";
    SDTextModel *testModel = [[SDTextModel alloc] init];
    testModel.sdName = @"骚栋";
    testModel.sdAge = @(15);
    testModel.sdLocation = @"北京";
    [SDUserDefaults standardUserDefaults].testModel = testModel;
    [[SDUserDefaults standardUserDefaults] saveUserInfoAction];
}

- (IBAction)deleteAction:(id)sender {
    /*****删除数据*****/
//    [[SDUserDefaults standardUserDefaults] deleteUserInfo];
    
}

- (IBAction)modifyAction:(id)sender {
    [SDUserDefaults standardUserDefaults].testModel.sdName = @"小狗";
    [[SDUserDefaults standardUserDefaults] saveUserInfoAction];
}

- (IBAction)queryAction:(id)sender {
    /*****获取数据*****/
    NSLog(@"%@",[SDUserDefaults standardUserDefaults].SDName);
    NSLog(@"%@",[SDUserDefaults standardUserDefaults].testModel.sdName);
    NSLog(@"%@",[SDUserDefaults standardUserDefaults].testModel.sdAge);
    NSLog(@"%@",[SDUserDefaults standardUserDefaults].testModel.sdLocation);
}

#pragma mark -  模型继承封装
- (void)modelPackageUse{
    // Init
    LCUserDefaultsModel *userDefaultsModel = [LCUserDefaultsModel userDefaultsModel];
    
    // demo举例：存值与取值
    NSLog(@"name = %@", userDefaultsModel.name);
    userDefaultsModel.name = @"Near1sssss";
    NSLog(@"gender = %ld", (long)userDefaultsModel.gender);
    userDefaultsModel.gender += 1;
    NSLog(@"age = %ld", userDefaultsModel.age);
    userDefaultsModel.age += 1;
    NSLog(@"floatNumber = %f", userDefaultsModel.floatNumber);
    userDefaultsModel.floatNumber += 1;
    NSLog(@"doubleNumber = %f", userDefaultsModel.doubleNumber);
    userDefaultsModel.doubleNumber += 1;
    NSLog(@"isMan = %d", userDefaultsModel.isMan);
    userDefaultsModel.isMan = !userDefaultsModel.isMan;
}
@end
