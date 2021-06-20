//
//  InputFilterVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/11/21.
//  Copyright © 2018 macheng. All rights reserved.
//

#import "InputFilterVC.h"

@interface InputFilterVC ()

@end

@implementation InputFilterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.vcNameArray = @[@[@"TextFieldNonPackageVC",@"TextViewNonPackageVC",@"TextFieldAndTextViewPackageVC"]];
    self.subtitleArray = @[@[@"textField未封装",@"textView未封装",@"textField和textView封装"]];
}



@end
