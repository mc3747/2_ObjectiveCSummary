//
//  RunTimeBaseVC.m
//  排序总结
//
//  Created by gjfax on 2019/5/6.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "RunTimeBaseVC.h"
#import "MCPerson.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "NSObject+Json.h"

@interface RunTimeBaseVC ()

@end

@implementation RunTimeBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self test1];
//    [self test2];
//    [self test3];
//    [self test4];
    [self test5];
}
// =====================================================
/*
 理解runtime的消息机制
 */
// =====================================================
#pragma mark -  理解1,消息发送
/*
 OC 的消息机制
 OC中的方法调用其实都是转成了objc_msgSend函数的调用，给receiver（方法调用者）发送了一条消息（selector方法名）
 objc_msgSend底层有3大阶段
 消息发送（当前类、父类中查找）、动态方法解析、消息转发
 
 */
- (void)test1{
//1，直接调用方法
    MCPerson *person = [[MCPerson alloc] init];
    [person testSendMessage];
    
//2，指针调用
    id person2 = [MCPerson class];
    void *p2 = &person2;
    [(__bridge id)p2 testSendMessage];
    
//3，objc_msgSend调用：需要导入<objc/message.h>
    objc_msgSend(person, @selector(testSendMessage));
}

#pragma mark -  理解2,动态方法解析
/*开发者可以实现以下方法，来动态添加方法实现
 +resolveInstanceMethod:
 +resolveClassMethod:
*/
- (void)test2{
//    MCPerson *person = [[MCPerson alloc] init];
//    [person test1];
}
#pragma mark -  理解3,动态添加方法

- (void)test3{
    MCPerson *person = [[MCPerson alloc] init];
    [person test2];
}
#pragma mark -  理解3,消息转发
/*
 forwardingTargetForSelector:
 methodSignatureForSelector:
 */
- (void)test4{
    MCPerson *person = [[MCPerson alloc] init];
    [person test3];
}
// =====================================================
/*
 应用runtime，下列是runtime的API
 1️⃣类：
 动态创建一个类（参数：父类，类名，额外的内存空间）
 Class objc_allocateClassPair(Class superclass, const char *name, size_t extraBytes)
 
 注册一个类（要在类注册之前添加成员变量）
 void objc_registerClassPair(Class cls)
 
 销毁一个类
 void objc_disposeClassPair(Class cls)
 
 获取isa指向的Class
 Class object_getClass(id obj)
 
 设置isa指向的Class
 Class object_setClass(id obj, Class cls)
 
 判断一个OC对象是否为Class
 BOOL object_isClass(id obj)
 
 判断一个Class是否为元类
 BOOL class_isMetaClass(Class cls)
 
 获取父类
 Class class_getSuperclass(Class cls)
 
 2️⃣成员变量：
 获取一个实例变量
 Ivar class_getInstanceVariable(Class cls, const char *name)
 
 拷贝实例变量列表（最后需要调用free释放）
 Ivar *class_copyIvarList(Class cls, unsigned int *outCount)
 
 设置和获取成员变量的值
 void object_setIvar(id obj, Ivar ivar, id value)
 id object_getIvar(id obj, Ivar ivar)
 
 动态添加成员变量（已经注册的类是不能动态添加成员变量的）
 BOOL class_addIvar(Class cls, const char * name, size_t size, uint8_t alignment, const char * types)
 
 获取成员变量的相关信息
 const char *ivar_getName(Ivar v)
 const char *ivar_getTypeEncoding(Ivar v)
 
 3️⃣，属性
 获取一个属性
 objc_property_t class_getProperty(Class cls, const char *name)
 
 拷贝属性列表（最后需要调用free释放）
 objc_property_t *class_copyPropertyList(Class cls, unsigned int *outCount)
 
 动态添加属性
 BOOL class_addProperty(Class cls, const char *name, const objc_property_attribute_t *attributes,
 unsigned int attributeCount)
 
 动态替换属性
 void class_replaceProperty(Class cls, const char *name, const objc_property_attribute_t *attributes,
 unsigned int attributeCount)
 
 获取属性的一些信息
 const char *property_getName(objc_property_t property)
 const char *property_getAttributes(objc_property_t property)
 
 4️⃣，方法
 获得一个实例方法、类方法
 Method class_getInstanceMethod(Class cls, SEL name)
 Method class_getClassMethod(Class cls, SEL name)
 
 方法实现相关操作
 IMP class_getMethodImplementation(Class cls, SEL name)
 IMP method_setImplementation(Method m, IMP imp)
 void method_exchangeImplementations(Method m1, Method m2)
 
 拷贝方法列表（最后需要调用free释放）
 Method *class_copyMethodList(Class cls, unsigned int *outCount)
 
 动态添加方法
 BOOL class_addMethod(Class cls, SEL name, IMP imp, const char *types)
 
 动态替换方法
 IMP class_replaceMethod(Class cls, SEL name, IMP imp, const char *types)
 
 获取方法的相关信息（带有copy的需要调用free去释放）
 SEL method_getName(Method m)
 IMP method_getImplementation(Method m)
 const char *method_getTypeEncoding(Method m)
 unsigned int method_getNumberOfArguments(Method m)
 char *method_copyReturnType(Method m)
 char *method_copyArgumentType(Method m, unsigned int index)
 
 选择器相关
 const char *sel_getName(SEL sel)
 SEL sel_registerName(const char *str)
 
 用block作为方法实现
 IMP imp_implementationWithBlock(id block)
 id imp_getBlock(IMP anImp)
 BOOL imp_removeBlock(IMP anImp)
 
 
 */
// =====================================================
#pragma mark -  应用1，查看私有变量
- (void)test5{
    // 获取成员变量信息
//            Ivar ageIvar = class_getInstanceVariable([MCPerson class], "_age");
//            NSLog(@"✅成员变量信息：%s %s", ivar_getName(ageIvar), ivar_getTypeEncoding(ageIvar));
    
    // 设置和获取成员变量的值
//            Ivar nameIvar = class_getInstanceVariable([MCPerson class], "_name");
//
//            MCPerson *person = [[MCPerson alloc] init];
//            object_setIvar(person, nameIvar, @"123");
//            object_setIvar(person, ageIvar, (__bridge id)(void *)10);
//            NSLog(@"✅成员变量值：%@ %d", person.name, person.age);
    
    // 遍历成员变量的值
    unsigned int count;
    Ivar *ivars = class_copyIvarList([MCPerson class], &count);
    for (int i = 0; i < count; i++) {
        // 取出i位置的成员变量
        Ivar ivar = ivars[i];
        NSLog(@"✅成员变量数量：%s %s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
    }
    free(ivars);
}

#pragma mark -  应用2，字典转模型
- (void)test6{
    NSDictionary *json = @{
                           @"id" : @20,
                           @"age" : @20,
                           @"weight" : @60,
                           @"name" : @"Jack"
                           };
    
    MCPerson *person = [MCPerson mj_objectWithJson:json];
}
#pragma mark -  应用3，方法替换

@end
