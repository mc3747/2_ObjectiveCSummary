//
//  Base64EncryptVC.m
//  排序总结
//
//  Created by gjfax on 2019/1/22.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "Base64EncryptVC.h"
#import "GBEncodeTool.h"

@interface Base64EncryptVC ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView1;
@property (weak, nonatomic) IBOutlet UITextView *textView2;

@end

@implementation Base64EncryptVC

- (IBAction)encryptAction:(id)sender {
      NSString *encodeBase64=[GBEncodeTool encodeBase64String:_textField.text];
    _textView1.text = encodeBase64;
}
- (IBAction)decryptAction:(id)sender {
     NSString*decodeBase64=[GBEncodeTool decodeBase64String:_textView1.text];
    _textView2.text = decodeBase64;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}



@end
