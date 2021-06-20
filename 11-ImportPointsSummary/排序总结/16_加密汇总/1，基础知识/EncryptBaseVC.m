//
//  EncryptBaseVC.m
//  排序总结
//
//  Created by gjfax on 2019/1/22.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "EncryptBaseVC.h"

@interface EncryptBaseVC ()
@property (weak, nonatomic) IBOutlet UITextView *textView1;
@property (weak, nonatomic) IBOutlet UITextView *textView2;
@property (weak, nonatomic) IBOutlet UITextView *textView3;


@end

@implementation EncryptBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showTextView1];
    [self showTextView2];
    [self showTextView3];
}

#pragma mark -  基础讲解
- (void)showTextView1 {
    _textView1.text = @"1，哈希算法：把任意长度的输入通过散列算法变换成固定长度的输出，该输出就是散列值。这种转换是一种压缩映射。特点1：散列值的空间通常远小于输入的空间；特点2：不同的输入可能会散列成相同的输出，所以不可能从散列值来确定唯一的输入值。例子：MD5，SHA-1,HMAC \n 2，对称加密：秘钥一样；例子：AES，DES，3DES； \n 3非对称加密：公钥公开，用来加密；私钥解密，归密钥的生成者所有；例子：RSA，DSA，ECC \n 4,编码方法，例如：Base64，基于64个可打印字符来表示二进制数据的方法 \n 5,编码格式 例如：ASCII、ISO8859-1、GB2312、GBK、UTF-8、UTF-16";
}
#pragma mark -  苹果加密函数
- (void)showTextView2 {
    _textView2.text = @"";
}
#pragma mark -  应用情景
- (void)showTextView3 {
     _textView3.text = @"";
}

@end
