//
//  TestRelaceIfElseVC.m
//  排序总结
//
//  Created by gjfax on 2019/1/18.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "TestReplaceIfElseVC.h"

@interface TestReplaceIfElseVC ()
@property (nonatomic, strong) NSArray *colorArray;
@property (nonatomic, assign) BOOL isEvenClick;
@end

@implementation TestReplaceIfElseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contentArray = @[@"红",@"橙",@"黄",@"绿"];
    self.colorArray = @[@"TestRed",@"TestOrange",@"TestYellow",@"TestGreen"];
    self.vcTitleArray = self.contentArray;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = _isEvenClick?[UIColor whiteColor]:[UIColor colorNamed:self.colorArray[indexPath.row]];
    _isEvenClick = !_isEvenClick;
    
//    [self useSelAction:indexPath];
    [self useStrategyAction:indexPath];
    
}
#pragma mark -  1,if else
#pragma mark -  2,if return
#pragma mark -  3,switch case
#pragma mark -  4,三目运算符
#pragma mark -  5,共性的字符串数组

#pragma mark -  6，sel的事件数组
- (void)useSelAction:(NSIndexPath *)indexPath{
    SEL methods[][4] = {
        {   @selector(getFirstCell:),
            @selector(getSecondCell:),
            @selector(getThirdCell:),
            @selector(getFourthCell:) },
        { },
        { },
        { },
    };
    
    SEL sel = methods[indexPath.section][indexPath.row];
    [self performSelector:sel withObject:(NSString *)self.contentArray[indexPath.row]];
}
- (void)getFirstCell:(NSString *)colorName {
    [self showAlert:colorName];
}
- (void)getSecondCell:(NSString *)colorName {
    [self showAlert:colorName];
}
- (void)getThirdCell:(NSString *)colorName {
    [self showAlert:colorName];
}
- (void)getFourthCell:(NSString *)colorName {
    [self showAlert:colorName];
}

#pragma mark -  7，策略模式
// 1.将复杂的业务逻辑包装成invocation,
- (NSInvocation *)invocationWithMethod:(SEL)selector :(NSIndexPath *)indexPath{
    //NSInvocation;用来包装方法和对应的对象，它可以存储方法的名称，对应的对象，对应的参数,
    /*
     NSMethodSignature：签名：再创建NSMethodSignature的时候，必须传递一个签名对象，签名对象的作用：用于获取参数的个数和方法的返回值
     */
    //创建签名对象的时候不是使用NSMethodSignature这个类创建，而是方法属于谁就用谁来创建
    
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = selector;
    NSString *colorName = (NSString *)self.contentArray[indexPath.row];
    [invocation setArgument:&colorName atIndex:2];
    return invocation;
}

// 2.将每天做的事进行整合
- (NSDictionary *)Strategies:(NSIndexPath *)indexPath{
    NSDictionary *Strategies = @{
                                 @"红" : [self invocationWithMethod:@selector(getFirstCell:):indexPath],
                                 @"橙" : [self invocationWithMethod:@selector(getSecondCell:):indexPath],
                                 @"黄" : [self invocationWithMethod:@selector(getThirdCell:):indexPath],
                                 @"绿" : [self invocationWithMethod:@selector(getFourthCell:):indexPath],
                                 };

    return Strategies;
}

- (void)useStrategyAction:(NSIndexPath *)indexPath {
    NSInvocation *doWhat = [self Strategies:indexPath][self.contentArray[indexPath.row]];
    [doWhat invoke];
}

#pragma mark -  通用方法
- (void)showAlert:(NSString *)colorName {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:colorName message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      
    }];
    
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

@end
