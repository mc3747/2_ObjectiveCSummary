//
//  PrecompliedViewController.m
//  排序总结
//
//  Created by gjfax on 2020/3/9.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "PrecompliedViewController.h"

@interface PrecompliedViewController ()

@end

@implementation PrecompliedViewController
// =====================================================
/*
 预编译:
 1,宏:#define
    无参数宏
    有参数宏
    可变参数宏
    iOS内置宏
 2,条件编译:#if、#elif、#else、#ifdef、#ifndef、#endif
 3,文件包含:#include,@class,#import
 4,其他预编译指令
    #error
        当程序检查到这里时会停止编译，这个命令的作用是在错误的地方禁止编译。
    #warning
    这个命令并不会影响程序的编译和运行，但是会认为的在这里显示一条警告信息，提醒我们自己。
    #pragma mark - 信息
        为代码加上标注
    #pragma message("信息")
        编译时提示信息
   #pragma clang各种命令

 C语言中的__LINE__用以指示本行语句在源文件中的位置信息。而#line就是可以改变当前行的行号在编译器中的表示，并且之后的行号也会相应的改变
 
    预编译的pch文件
    Clang的预编译分析(LLVM):http://clang.llvm.org/get_started.html
 */
// =====================================================
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib
}
- (IBAction)demo1:(id)sender {
    GJSPushViewControllerWithName(@"MacroViewController", Sender_title, YES);
}

- (IBAction)demo5:(id)sender {
    GJSPushViewControllerWithName(@"MacroApplicationVC", Sender_title, YES);
}
- (IBAction)demo6:(id)sender {
    GJSPushViewControllerWithName(@"MacroCommonUseVC", Sender_title, YES);
}

@end
