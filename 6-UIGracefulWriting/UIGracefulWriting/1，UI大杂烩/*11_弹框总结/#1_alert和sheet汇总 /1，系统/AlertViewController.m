//
//  AlertViewController.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/9/5.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "AlertViewController.h"

@interface AlertViewController ()

@end

@implementation AlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn1 = [self makeNormalButton:CGRectMake(20, 100, 200, 40) title:@"1,系统sheet"];
    UIButton *btn2 = [self makeNormalButton:CGRectMake(20, 160, 200, 40) title:@"2,系统有输入框alert"];
    UIButton *btn3 = [self makeNormalButton:CGRectMake(20, 220, 200, 40) title:@"3,系统无输入框alert"];
    GJWeakSelf;
    [btn1 GJSHandleCallBack:^(UIButton *button) {
        [weakSelf creatAlertController_sheet];
    }];
    [btn2 GJSHandleCallBack:^(UIButton *button) {
        [weakSelf creatAlertController_alert1];
    }];
    [btn3 GJSHandleCallBack:^(UIButton *button) {
        [weakSelf creatAlertController_alert2];
    }];
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
    [self.view addSubview:btn3];
}

#pragma mark -  系统sheet
-(void)creatAlertController_sheet {
    
    /*
     先创建UIAlertController，preferredStyle：选择UIAlertControllerStyleActionSheet，这个就是相当于创建8.0版本之前的UIActionSheet；
     
     typedef NS_ENUM(NSInteger, UIAlertControllerStyle) {
     UIAlertControllerStyleActionSheet = 0,
     UIAlertControllerStyleAlert
     } NS_ENUM_AVAILABLE_IOS(8_0);
     
     */
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"标题" message:@"注释信息,没有就写nil" preferredStyle:UIAlertControllerStyleActionSheet];
    
    /*
     typedef NS_ENUM(NSInteger, UIAlertActionStyle) {
     UIAlertActionStyleDefault = 0,
     UIAlertActionStyleCancel,         取消按钮
     UIAlertActionStyleDestructive     破坏性按钮，比如：“删除”，字体颜色是红色的
     } NS_ENUM_AVAILABLE_IOS(8_0);
     
     */
    // 创建action，这里action1只是方便编写，以后再编程的过程中还是以命名规范为主
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"标题1" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了按钮1，进入按钮1的事件");
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        //跳到创建alertview的方法，一般在点击删除这里按钮之后，都需要一个提示框，提醒用户是否真的删除
         NSLog(@"点击了删除");
    }];
    
    //把action添加到actionSheet里
    [actionSheet addAction:action1];
    [actionSheet addAction:action2];
    [actionSheet addAction:action3];
    
    //相当于之前的[actionSheet show];
    [self presentViewController:actionSheet animated:YES completion:nil];
}

#pragma mark -  系统alert，有输入框
-(void)creatAlertController_alert1 {
    //跟上面的流程差不多，记得要把preferredStyle换成UIAlertControllerStyleAlert
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"标题" message:@"注释信息,没有就写nil" preferredStyle:UIAlertControllerStyleAlert];
    
    //可以给alertview中添加一个输入框
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"alert中的文本";
    }];

    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"标题1" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了按钮1，进入按钮1的事件");
        //textFields是一个数组，获取所输入的字符串
        NSLog(@"%@",alert.textFields.lastObject.text);
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    
    [alert addAction:action1];
    [alert addAction:action2];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark -  系统alert，无输入框
-(void)creatAlertController_alert2 {
    //跟上面的流程差不多，记得要把preferredStyle换成UIAlertControllerStyleAlert
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"标题" message:@"注释信息,没有就写nil" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"标题1" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了按钮1，进入按钮1的事件");
        //textFields是一个数组，获取所输入的字符串
        NSLog(@"%@",alert.textFields.lastObject.text);
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    
    [alert addAction:action1];
    [alert addAction:action2];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark -  创建按钮
- (UIButton *)makeNormalButton:(CGRect)frame title:(NSString *)title{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [btn setBackgroundColor:LBRandomColor forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    return btn;
}



@end
