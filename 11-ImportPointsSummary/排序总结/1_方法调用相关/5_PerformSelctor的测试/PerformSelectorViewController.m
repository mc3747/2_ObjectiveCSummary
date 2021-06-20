//
//  PerformSelectorViewController.m
//  DSMessageDemo
//
//  Created by 童玉龙 on 16/8/19.
//  Copyright © 2016年 齐滇大圣. All rights reserved.
//

#import "PerformSelectorViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>


typedef struct ParameterStruct{
    int a;
    int b;
}MyStruct;


@interface PerformSelectorViewController ()

@end

@implementation PerformSelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *firstBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 150, 60)];
    [firstBtn setBackgroundColor:[UIColor redColor]];
    [firstBtn setTitle:@"NoParameter" forState:UIControlStateNormal];
    firstBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [firstBtn addTarget:self action:@selector(NoParameterClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firstBtn];
    
    UIButton *secondBtn = [[UIButton alloc] initWithFrame:CGRectMake(220, 100, 150, 60)];
    [secondBtn setBackgroundColor:[UIColor redColor]];
    [secondBtn setTitle:@"OneParameter" forState:UIControlStateNormal];
    secondBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [secondBtn addTarget:self action:@selector(OneParameterClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secondBtn];
    
    UIButton *thirdBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 200, 150, 60)];
    [thirdBtn setBackgroundColor:[UIColor redColor]];
    [thirdBtn setTitle:@"TwoParameter" forState:UIControlStateNormal];
    thirdBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [thirdBtn addTarget:self action:@selector(TwoParameterClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:thirdBtn];
    
    UIButton *forthBtn = [[UIButton alloc] initWithFrame:CGRectMake(220, 200, 150, 60)];
    [forthBtn setBackgroundColor:[UIColor redColor]];
    [forthBtn setTitle:@"Dynamic Method" forState:UIControlStateNormal];
    forthBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [forthBtn addTarget:self action:@selector(DynamicClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forthBtn];
    
    
    UIButton *fifthBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 300, 150, 60)];
    [fifthBtn setBackgroundColor:[UIColor redColor]];
    [fifthBtn setTitle:@"NSInvocation" forState:UIControlStateNormal];
    fifthBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [fifthBtn addTarget:self action:@selector(NSInvocationClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fifthBtn];
    
    
    UIButton *sixthBtn = [[UIButton alloc] initWithFrame:CGRectMake(220, 300, 150, 60)];
    [sixthBtn setBackgroundColor:[UIColor redColor]];
    [sixthBtn setTitle:@"objc_msgSend" forState:UIControlStateNormal];
    sixthBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [sixthBtn addTarget:self action:@selector(ObjcMsgSendClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sixthBtn];
    
    
    UIButton *seventhBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 400, 150, 60)];
    [seventhBtn setBackgroundColor:[UIColor redColor]];
    [seventhBtn setTitle:@"StructParameter" forState:UIControlStateNormal];
    seventhBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [seventhBtn addTarget:self action:@selector(StruckClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:seventhBtn];

    
    UIButton *eighth = [[UIButton alloc] initWithFrame:CGRectMake(220, 400, 150, 60)];
    [eighth setBackgroundColor:[UIColor redColor]];
    [eighth setTitle:@"StructParameter_Two" forState:UIControlStateNormal];
    eighth.titleLabel.font = [UIFont systemFontOfSize:13];
    [eighth addTarget:self action:@selector(StruckTwoClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:eighth];

}

#pragma 下面两种方法都可以用做传递多个参数用

- (id)performSelector:(SEL)selector withObjects:(NSArray *)objects
{
    // 方法签名(方法的描述)
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:selector];
    if (signature == nil) {
        
        //可以抛出异常也可以不操作。
    }
    
    // NSInvocation : 利用一个NSInvocation对象包装一次方法调用（方法调用者、方法名、方法参数、方法返回值）
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = selector;
    
    // 设置参数
    NSInteger paramsCount = signature.numberOfArguments - 2; // 除self、_cmd以外的参数个数
    paramsCount = MIN(paramsCount, objects.count);
    for (NSInteger i = 0; i < paramsCount; i++) {
        id object = objects[i];
        if ([object isKindOfClass:[NSNull class]]) continue;
        [invocation setArgument:&object atIndex:i + 2];
    }
    
    // 调用方法
    [invocation invoke];
    
    // 获取返回值
    id returnValue = nil;
    if (signature.methodReturnLength) { // 有返回值类型，才去获得返回值
        [invocation getReturnValue:&returnValue];
    }
    
    return returnValue;
}

//在主线程上调用
- (void) performSelectorOnMainThread:(SEL)selector withObjects:(NSArray *)objects waitUntilDone:(BOOL)wait{
    
    NSMethodSignature *signature = [self methodSignatureForSelector:selector];
    if (!signature)
        return;
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:selector];
    
    // 设置参数
    NSInteger paramsCount = signature.numberOfArguments - 2; // 除self、_cmd以外的参数个数
    paramsCount = MIN(paramsCount, objects.count);
    for (NSInteger i = 0; i < paramsCount; i++) {
        id object = objects[i];
        if ([object isKindOfClass:[NSNull class]]) continue;
        [invocation setArgument:&object atIndex:i + 2];
    }
    [invocation retainArguments];
    
    [invocation performSelectorOnMainThread:@selector(invoke) withObject:nil waitUntilDone:wait];
}

#pragma  Click Method

- (void)NoParameterClick{
    
    [self performSelector:@selector(SelectorNoParameter)];
}

- (void)OneParameterClick{
    
    [self performSelector:@selector(SelectorOneParameter:) withObject:@"firstParameter"];
}

- (void)TwoParameterClick{
    
    [self performSelector:@selector(SelectorFirstParameter:SecondParameter:) withObject:@"firstParameter" withObject:@"secondParameter"];
}

- (void)DynamicClick{
    
    NSArray *objectArray = @[@{@"methodName":@"DynamicParameterString:",@"value":@"String"},@{@"methodName":@"DynamicParameterNumber:",@"value":@2}];
    for (NSDictionary *dic in objectArray) {
        
        [self performSelector:NSSelectorFromString([dic objectForKey:@"methodName"]) withObject:[dic objectForKey:@"value"]];
    }
}

- (void)NSInvocationClick{
    
    NSString *str = @"字符串";
    NSNumber *num = @20;
    NSArray *arr = @[@"数组值1", @"数组值2"];
    SEL sel = NSSelectorFromString(@"NSInvocationWithString:withNum:withArray:");
    NSArray *objs = [NSArray arrayWithObjects:str, num, arr, nil];
    
    //[self performSelector:sel withObjects:objs];
    
    //在主线程上执行方法，阻塞主线程，直到主线程将代码块执行完毕
    [self performSelectorOnMainThread:sel withObjects:objs waitUntilDone:YES];
}

- (void)ObjcMsgSendClick{
    
    NSString *str = @"字符串objc_msgSend";
    NSNumber *num = @20;
    NSArray *arr = @[@"数组值1", @"数组值2"];
    
    SEL sel = NSSelectorFromString(@"ObjcMsgSendWithString:withNum:withArray:");
    
    ((void (*) (id, SEL, NSString *, NSNumber *, NSArray *)) objc_msgSend) (self, sel, str, num, arr);
}

//传递多个参数，参数里面有结构体
- (void)StruckClick{
    
    NSString *str = @"字符串 结构体";
    NSNumber *num = @20;
    NSArray *arr = @[@"数组值1", @"数组值2"];
    MyStruct mystruct = {10,20};
    
    SEL sel = NSSelectorFromString(@"ObjcMsgSendWithString:withNum:withArray:withStruck:");
    
    ((void (*) (id, SEL, NSString *, NSNumber *, NSArray *, MyStruct)) objc_msgSend) (self, sel, str, num, arr, mystruct);
}

- (void)StruckTwoClick{
    
    NSString *str = @"字符串 把结构体转换为对象";
    NSNumber *num = @20;
    NSArray *arr = @[@"数组值1", @"数组值2"];
    
    MyStruct mystruct = {10,20};
    NSValue *value = [NSValue valueWithBytes:&mystruct objCType:@encode(MyStruct)];
    
    SEL sel = NSSelectorFromString(@"NSInvocationWithString:withNum:withArray:withValue:");
    NSArray *objs = [NSArray arrayWithObjects:str, num, arr, value,nil];
    
    [self performSelector:sel withObjects:objs];
}

#pragma  PerformSelector

- (void)SelectorNoParameter{
    
    NSLog(@"SelectorNoParameter");
}

- (void)SelectorOneParameter:(NSString *)first{
    
    NSLog(@"Logs: %@", first);
}

- (void)SelectorFirstParameter:(NSString *)first SecondParameter:(NSString *)second{
    
    NSLog(@"Logs %@ %@", first, second);
}

//动态添加函数
- (void)DynamicParameterString:(NSString *)string{
    
    NSLog(@"DynamicParameterString: %@",string);
}

- (void)DynamicParameterNumber:(NSNumber *)number{
    
    NSLog(@"DynamicParameterNumber: %@",number);
}

//多参数
- (void)NSInvocationWithString:(NSString *)string withNum:(NSNumber *)number withArray:(NSArray *)array {
    NSLog(@"%@, %@, %@", string, number, array[0]);
}

- (void)ObjcMsgSendWithString:(NSString *)string withNum:(NSNumber *)number withArray:(NSArray *)array {
    NSLog(@"%@, %@, %@", string, number, array[0]);
}

//多参数有struck
- (void)NSInvocationWithString:(NSString *)string withNum:(NSNumber *)number withArray:(NSArray *)array withValue:(NSValue *)value{
    
    MyStruct struceBack;
    [value getValue:&struceBack];
    
    NSLog(@"%@, %@, %@, %d", string, number, array[0],struceBack.a);
}

- (void)ObjcMsgSendWithString:(NSString *)string withNum:(NSNumber *)number withArray:(NSArray *)array withStruck:(MyStruct)mystruct{
    
    NSLog(@"%@, %@, %@, %d", string, number, array[0],mystruct.a);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
