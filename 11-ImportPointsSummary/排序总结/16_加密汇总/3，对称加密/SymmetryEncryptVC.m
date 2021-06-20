//
//  SymmetryEncryptVC.m
//  排序总结
//
//  Created by gjfax on 2019/1/22.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "SymmetryEncryptVC.h"
#import "GBEncodeTool.h"

@interface SymmetryEncryptVC ()
@property (weak, nonatomic) IBOutlet UITextField *aesTextfield;
@property (weak, nonatomic) IBOutlet UITextView *aesEncryptTextView;
@property (weak, nonatomic) IBOutlet UITextView *aesEncodeTextView;
@property (weak, nonatomic) IBOutlet UITextField *desTextfield;
@property (weak, nonatomic) IBOutlet UITextView *desEncryptTextView;
@property (weak, nonatomic) IBOutlet UITextView *desEncodeTextView;


@end

@implementation SymmetryEncryptVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
#pragma mark -  AES
/*
 AES全称Advanced Encryption Standard，中文名称叫高级加密标准，
 在密码学中被叫做Rijndael加密法，这个标准已经替代原来的DES，成为美国政府采用的一种区块加密标准。微信小程序中的加密传输就是使用的AES加密算法
 加密和解密：字节代换、行位移、列混合和轮密钥加
 */
- (IBAction)aesEncrypt:(id)sender {
      NSString *AES128Encode=[GBEncodeTool AES128Encrypt:_aesTextfield.text WithKey:PUBLIC_APP_KEY];
    _aesEncryptTextView.text = AES128Encode;
    
}
- (IBAction)aesEncode:(id)sender {
      NSString *AES128Decode=[GBEncodeTool AES128Decrypt:_aesEncryptTextView.text WithKey:PUBLIC_APP_KEY];
    _aesEncodeTextView.text = AES128Decode;
}


#pragma mark -  DES
/*

 DES全称为Data Encryption Standard，即数据加密标准，是一种使用密钥加密的块算法，
 1977年被美国联邦政府的国家标准局确定为联邦资料处理标准（FIPS），并授权在非密级政府通信中使用
 */

- (IBAction)desEncrypt:(id)sender {
     NSString *DES_CBC_EncodeStr=[GBEncodeTool DESEncrypt:_desTextfield.text Key:DES_KEY IV:DES_IV];
    _desEncryptTextView.text = DES_CBC_EncodeStr;
    
}

- (IBAction)desEncode:(id)sender {
       NSString *DES_CBC_DecodeStr=[GBEncodeTool DESDecrypt:_desEncryptTextView.text Key:DES_KEY IV:DES_IV];
      _desEncodeTextView.text = DES_CBC_DecodeStr;
}




@end
