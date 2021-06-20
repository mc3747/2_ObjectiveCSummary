//
//  VariableArgumentsVC.m
//  排序总结
//
//  Created by gjfax on 2018/11/9.
//  Copyright © 2018 macheng. All rights reserved.
//

#import "VariableArgumentsVC.h"
#import "ParameterManager.h"
#import "ParameterClass.h"
#import <objc/runtime.h>
#import <objc/message.h>

typedef struct TTTestStrout{
    int aaa;
    NSString *bbb;
} testStruct;
@interface VariableArgumentsVC ()

@end

@implementation VariableArgumentsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contentArray = @[@"方法传参",@"performSelector传参",@"传字典",@"传结构体",@"传含有结构体的字典",@"传模型",@"传可变个数的同一类型参数",@"NSInvocation传值",@"runTime传值",@"NSTimer传值",@"UIButton传值"];
    self.vcTitleArray = self.contentArray;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *methodString = [NSString stringWithFormat:@"test%ld",indexPath.row + 1];
//动态加载方法
    SEL sel = NSSelectorFromString(methodString);
    IMP imp = [self methodForSelector:sel];
    void (*func)(id, SEL) = (void *)imp;
    if([self respondsToSelector:sel]){
         func(self,sel);
    };
    
    
}
#pragma mark -  1,方法中写参数
- (void)test1 {
    [self testFunctionWithParams1:6 :@"234131#"];
}
- (void)testFunctionWithParams1:(int )number :(NSString *)string {
    NSLog(@"方法多个参数:%i%@",number, string);
}

#pragma mark -  2,performSelector传参数：最多两个参数
- (void)test2 {
    [self performSelector:@selector(testFunctionWithParams1::) withObject:@5 withObject:@"67"];
    
//    动态加载方法：需要对指针做处理，最多两个参数
//    SEL selector = NSSelectorFromString(@"testFunctionWithParams2::");
//    IMP imp = [self methodForSelector:selector];
//    void (*func)(id, SEL) = (void *)imp;
//    if([self respondsToSelector:selector]){
//        func(self,selector);
//    };
    
//    也可以采用延时，但只能传一个参数
//    SEL selector = NSSelectorFromString(@"testFunctionWithParams2:");
//    [self performSelector:selector withObject:@"tom" afterDelay:0.1f];
}
- (void)testFunctionWithParams:(NSString *)string {
     NSLog(@"performSelector传参数:%@", string);
}

- (void)testFunctionWithParams2:(int )number :(NSString *)string {
     NSLog(@"performSelector传参数:%i%@",number, string);
}
#pragma mark -  3，传字典
- (void)test3 {
    //封装参数
    NSDictionary *dic = @{@"param1":@"this is a string",@"param2":@[@2,@3,@3],@"param3":@123};
    //调用方法
    [self testFunctionWithParams3:dic];
    
}
- (void)testFunctionWithParams3:(NSDictionary *)paramDic {
    NSLog(@"传字典:%@", paramDic);
}

#pragma mark - 4，传结构体
- (void)test4 {
    //传结构体
    testStruct testS = {10000, @"1234"};
    [self testFunctionWithParams4:testS];
    
}
- (void)testFunctionWithParams4:(testStruct )paramStruct {
   
    NSLog(@"结构体元素aaa = %d",paramStruct.aaa);
    NSLog(@"结构体元素bbb = %@",paramStruct.bbb);
}

#pragma mark -  5,传结构体字典
- (void)test5 {
    //传结构体
    testStruct testS = {10000, @"1234"};
    NSValue *value = [NSValue valueWithBytes:&testS objCType:@encode(testStruct)];
    //dic
    NSDictionary *dataDic = @{@"param1":@"ssfs",@"param2":@[@333,@32343],@"param3":value};
    [self testFunctionWithParams5:dataDic];
    
    
}
- (void)testFunctionWithParams5:(NSDictionary *)paramDic {
    NSLog(@"结构体字典:%@", paramDic);
    NSValue *paramValue = paramDic[@"param3"];
    testStruct paramStrout;
    [paramValue getValue:&paramStrout];
    NSLog(@"结构体字典的元素aaa：%d",paramStrout.aaa);
    
}


#pragma mark - 6，传模型
- (void)test6 {
    
    Parameter1 *parameter1 = [Parameter1 new];
    parameter1.number = 14;
    ParameterManager<Parameter1 *> *manager1 = [ParameterManager new];
    manager1.parameter = parameter1;
    [manager1 getParaWithType:MethodType1];
    
}

#pragma mark -  7，传指针列表，参数个数不定，但类型一致
- (void)test7 {
    
    /*2，传同一类型的参数，个数不定 */
    [ParameterManager getType:MethodType0 params:@"23",@"389",@"889",nil];
}

#pragma mark -  8，runTime的objc_msgSend传值
- (void)test8 {
    
//    ((void (*)(id, SEL))objc_msgSend)(self, @selector(test7)); //正确写法
    
    ((void (*)(id,SEL,NSString *, NSArray *, NSInteger)) objc_msgSend) (self, @selector(textFunctionWithParam8:param2:param3:),@"111",@[@2,@3],123);

}

//有三个参数的方法
-(void)textFunctionWithParam8:(NSString *)param1 param2:(NSArray *)param2 param3:(NSInteger)param3 {
    NSLog(@"param1:%@, param2:%@, param3:%ld",param1, param2, param3);
}

#pragma mark -  9，NSInvocation传值
- (void)test9 {
    NSArray *paramArray = @[@"112",@[@2,@13],@12];
    [self performNewSelector:@selector(textFunctionWithParam9:param2:param3:) withObjects:paramArray];
    
}
//可以传多个参数的方法
- (id)performNewSelector:(SEL)selector withObjects:(NSArray *)objects
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

//要调用的方法
-(void)textFunctionWithParam9:(NSString *)param1 param2:(NSArray *)param2 param3:(NSInteger)param3 {
    NSLog(@"param1:%@, param2:%@, param3:%ld",param1, param2, param3);
}

#pragma mark -  10,NSTimer 的@selected传值
- (void)test10 {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"testString" forKey:@"string"];
    [NSTimer scheduledTimerWithTimeInterval:0.0 target:self selector:@selector(onTimer:) userInfo:dict repeats:NO];
}

- (void)onTimer:(NSTimer *)timer {
    NSString *string = [[timer userInfo] objectForKey:@"string"];
    NSLog(@"NSTimer传值：%@",string);
}

#pragma mark -  11,UIButton 的@selected传值
/*
 思路：
 1，传递的参数，通过button的tag传递
 2，写一个分类，当前方法中，添加事件，不用另起一个方法
 3，直接添加属性
 4, 获取btn所属的控制器，再将控制器要传递的参数暴露出来
 5，自定义button
 */
- (void)test11 {
    UIButton * markButton=[[UIButton alloc] initWithFrame:CGRectMake(280, 0, 30, 30)];
    
    markButton.tag = 18;
    NSString *newProperty = @"newValue";
    objc_setAssociatedObject(markButton, @"newProperty", newProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [markButton addTarget:self action:@selector(addMark:)  forControlEvents:UIControlEventTouchUpInside];
    [markButton setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:markButton];
    

    
}

- (void)addMark:(UIButton *)btn {
    
    NSLog(@"button的tag%ld",(long)btn.tag);
    NSLog(@"button的runtime添加属性%@",objc_getAssociatedObject(btn,@"newProperty"));
    
}
          

@end
