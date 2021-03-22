//
//  PackageRuntimeVC.m
//  排序总结
//
//  Created by gjfax on 2019/4/28.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "PackageRuntimeVC.h"
#import "RuntimeKit.h"
#import "TestClass.h"
#import "TestClass+Category.h"
#import "TestClass+SwapMethod.h"
#import "TestClass+AssociatedObject.h"

@interface PackageRuntimeVC ()

@end

@implementation PackageRuntimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *className = [RuntimeKit fetchClassName:[TestClass class]];
    NSLog(@"测试类的类名为：%@\n", className);
    
    NSArray *ivarList = [RuntimeKit fetchIvarList:[TestClass class]];
    NSLog(@"\n获取TestClass的成员变量列表:%@", ivarList);
    
    NSArray *propertyList = [RuntimeKit fetchPropertyList:[TestClass class]];
    NSLog(@"\n获取TestClass的属性列表:%@", propertyList);
    
    NSArray *methodList = [RuntimeKit fetchMethodList:[TestClass class]];
    NSLog(@"\n获取TestClass的方法列表：%@", methodList);
    
    NSArray *protocolList = [RuntimeKit fetchProtocolList:[TestClass class]];
    NSLog(@"\n获取TestClass的协议列表：%@", protocolList);
    TestClass *instance = [TestClass new];
    [instance publicTestMethod2];
    [instance performSelector:@selector(noThisMethod:) withObject:@"实例方法参数"];
    
    instance.dynamicAddProperty = @"我是动态添加的属性";
    NSLog(@"%@", instance.dynamicAddProperty);
    
    
    [instance swapMethod];
    [instance method1];
}



@end
