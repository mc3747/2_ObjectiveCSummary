//
//  PlistFileVC.m
//  NetworkSummary
//
//  Created by gjfax on 2018/11/15.
//  Copyright © 2018 macheng. All rights reserved.
//

#import "PlistFileVC.h"

@interface PlistFileVC ()
@property (weak, nonatomic) IBOutlet UITextView *textView1;
@property (weak, nonatomic) IBOutlet UITextView *textView2;

@end

@implementation PlistFileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showText1];
    [self showText2];
}

// =====================================================
/*
 1，从已有的plist文件中获取
 */
// =====================================================
- (void)showText1 {
    // 获取沙盒路径
    NSString *sandboxPath = NSHomeDirectory();
    NSLog(@"沙盒路径：%@",sandboxPath);
    
    // 1.手动创建一个plist文件(在程序的运行中间可以读取，但是不能够修改)
    //新建如目录plist文件
    //读取数据
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"people.plist" ofType:nil];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSLog(@"%@",dic);
    
    // 2.在沙盒路径下创建和使用plist文件（可以动态地存取和删除）
    //获取沙盒中Documents目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *fileName =[plistPath1 stringByAppendingPathComponent:@"my1.plist"];
    //创建一个字典，将此字典对象存入上文创建的my.plist文件中
    NSDictionary *dic1 = @{@"name":@"jack", @"age":@"18", @"gender":@"male"};
    [dic1 writeToFile:fileName atomically:YES];
    //读取刚刚保存的数据
    NSDictionary *getDic = [NSDictionary dictionaryWithContentsOfFile:fileName];
    _textView1.text = [NSString stringWithFormat:@"✅1，从已有的plist创建✅:\n内容：%@:",getDic];
}

// =====================================================
/*
2， 直接创建plist
 */
// =====================================================
- (void)showText2 {
    //获取本地沙盒路径
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //获取完整路径
    NSString *documentsPath = [path objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"my2.plist"];
    
    NSMutableDictionary *usersDic = [[NSMutableDictionary alloc ] init];
    //设置属性值
    [usersDic setObject:@"孙大圣" forKey:@"name"];
    [usersDic setObject:@"sunwukong" forKey:@"password"];
    //写入文件
    [usersDic writeToFile:plistPath atomically:YES];
    //读取刚刚保存的数据
    NSDictionary *getDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    _textView2.text = [NSString stringWithFormat:@"✅2，直接从零的plist创建✅:\n内容：%@:",getDic];
}
@end
