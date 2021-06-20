//
//  DissymmetryEncryptVC.m
//  排序总结
//
//  Created by gjfax on 2019/1/22.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "DissymmetryEncryptVC.h"
#import "GBEncodeTool.h"

@interface DissymmetryEncryptVC ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView1;
@property (weak, nonatomic) IBOutlet UITextView *textView2;

@end

@implementation DissymmetryEncryptVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)encryptActjion:(id)sender {
    NSString *rsaEncode=[GBEncodeTool rsaEncryptString:_textField.text publicKey:PUBLICK_KEY];
    _textView1.text = rsaEncode;
}

- (IBAction)decryptAction:(id)sender {
     NSString *rsaDecode=[GBEncodeTool rsaDecryptString:_textView1.text privateKey:PRIVATE_KEY];
    
    _textView2.text = rsaDecode;
}
#pragma mark -  生成证书的方法

@end
