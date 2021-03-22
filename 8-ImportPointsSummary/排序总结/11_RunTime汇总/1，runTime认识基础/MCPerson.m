//
//  MCPerson.m
//  排序总结
//
//  Created by gjfax on 2019/5/6.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "MCPerson.h"
#import <objc/runtime.h>
#import "MCCat.h"

@interface MCPerson()
{
    int _weight3;
    int _age3;
    NSString *_name3;
}
@property (assign, nonatomic) int weight2;
@property (assign, nonatomic) int age2;
@property (copy, nonatomic) NSString *name2;
@end
@implementation MCPerson

#pragma mark -  1，消息机制
-(void)testSendMessage{
    NSLog(@"✅消息机制%s", __func__);
}

#pragma mark -  2，动态方法解析
//struct method_t {
//    SEL sel;
//    char *types;
//    IMP imp;
//};
//void c_other(id self, SEL _cmd)
//{
//    NSLog(@"✅动态方法解析： %@ - %@", self, NSStringFromSelector(_cmd));
//}
//+ (BOOL)resolveClassMethod:(SEL)sel
//{
//    if (sel == @selector(test1)) {
//        // 第一个参数是object_getClass(self)
//        class_addMethod(object_getClass(self), sel, (IMP)c_other, "v16@0:8");
//        return YES;
//    }
//    return [super resolveClassMethod:sel];
//}
//
//+ (BOOL)resolveInstanceMethod:(SEL)sel
//{
//    if (sel == @selector(test1)) {
//        // 动态添加test方法的实现
//        class_addMethod(self, sel, (IMP)c_other, "v16@0:8");
//
//        // 返回YES代表有动态添加方法
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}

#pragma mark -  3，动态添加方法
- (void)other
{
    NSLog(@"✅动态添加方法%s", __func__);
}
//动态添加方法1
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(test2)) {
        // 获取其他方法
        Method method = class_getInstanceMethod(self, @selector(other));

        // 动态添加test方法的实现
        class_addMethod(self, sel,
                        method_getImplementation(method),
                        method_getTypeEncoding(method));

        // 返回YES代表有动态添加方法
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}
//动态添加方法2
//+ (BOOL)resolveInstanceMethod:(SEL)sel
//{
//    if (sel == @selector(test)) {
//        // 获取其他方法
//        struct method_t *method = (struct method_t *)class_getInstanceMethod(self, @selector(other));
//
//        // 动态添加test方法的实现
//        class_addMethod(self, sel, method->imp, method->types);
//
//        // 返回YES代表有动态添加方法
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}

#pragma mark -  4，消息转发
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if (aSelector == @selector(test3)) {
        //        return [NSMethodSignature signatureWithObjCTypes:"v20@0:8i16"];
        return [NSMethodSignature signatureWithObjCTypes:"i@:i"];
        //        return [[[MJCat alloc] init] methodSignatureForSelector:aSelector];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    // 参数顺序：receiver、selector、other arguments
    //    int age;
    //    [anInvocation getArgument:&age atIndex:2];
    //    NSLog(@"%d", age + 10);
    
    
    // anInvocation.target == [[MJCat alloc] init]
    // anInvocation.selector == test:
    // anInvocation的参数：15
    // [[[MJCat alloc] init] test:15]
    
    [anInvocation invokeWithTarget:[[MCCat alloc] init]];
    
    int ret;
    [anInvocation getReturnValue:&ret];
    
    NSLog(@"%d", ret);
}

@end
