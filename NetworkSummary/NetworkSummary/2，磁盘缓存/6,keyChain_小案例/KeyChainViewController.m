//
//  KeyChainViewController.m
//  NetworkSummary
//
//  Created by gjfax on 2020/3/18.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "KeyChainViewController.h"
#import <Security/Security.h>
#import "KeyChainManager.h"

@interface KeyChainViewController ()
@property (weak, nonatomic) IBOutlet UITextField *keyChainTextField;

@end
// =====================================================
/*
 使用keychain目录:
 1,导入框架 Security.framework
 2,打开KeyChain Sharing开关
 3,使用api方法,增删改查
    SecItemAdd;
    SecItemUpdate;
    SecItemCopyMatching;
    SecItemDelete;
 */
// =====================================================
@implementation KeyChainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

//新增
- (IBAction)demo1:(id)sender {
    BOOL save = [KeyChainManager keyChainSaveData:@"思念诉说，眼神多像云朵" withIdentifier:_keyChainTextField.text];
    if (save) {
        NSLog(@"存储成功");
    }else {
        NSLog(@"存储失败");
    };
   
}

//删除
- (IBAction)demo2:(id)sender {
    // 删除数据
    [KeyChainManager keyChainDelete:_keyChainTextField.text];
}

//修改
- (IBAction)demo3:(id)sender {
    BOOL updata = [KeyChainManager keyChainUpdata:@"长发落寞，我期待的女孩" withIdentifier:_keyChainTextField.text];
    if (updata) {
        NSLog(@"更新成功");
    }else{
        NSLog(@"更新失败");
    }
    // 读取数据
    NSString * readUpdataString = [KeyChainManager keyChainReadData:_keyChainTextField.text];
    NSLog(@"获取更新后得到的数据:%@",readUpdataString);
}

//查询
- (IBAction)demo4:(id)sender {
 // 读取数据
 NSString * readDeleteString = [KeyChainManager keyChainReadData:_keyChainTextField.text];
 NSLog(@"获取删除后得到的数据:%@",readDeleteString);
}


@end
