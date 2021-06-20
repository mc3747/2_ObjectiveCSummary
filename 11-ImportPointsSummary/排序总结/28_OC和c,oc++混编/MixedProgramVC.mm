//
//  MixedProgramVC.m
//  排序总结
//
//  Created by gjfax on 2020/3/11.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "MixedProgramVC.h"
#include "CPPPrinter.h"
#include "cprinter.h"
#include "CPPLogHelper.h"

@interface MixedProgramVC ()
@property (assign, nonatomic) CPPPrinter::CPPPrinter *cppPrinter;
@end

@implementation MixedProgramVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
//oc
- (IBAction)demo1:(id)sender {
    
}

//c
- (IBAction)demo2:(id)sender {
//     Function in c code.
       say_hello();
}

//c++
- (IBAction)demo3:(id)sender {
    // 1:函数Function in cpp code.
//    CPPPrinter::sayHello();
    CGRect rect = CGRectMake(1, 1, 1, 1);
    CPPPrinter::printType( @"3");

//    // 2:实例方法:Instance method in cpp code.
//    self.cppPrinter = new CPPPrinter::CPPPrinter();
//    self.cppPrinter->sayHello();
//
//    // 3:库函数:Function in library.
//    CPPLogHelper::log();
}


@end
