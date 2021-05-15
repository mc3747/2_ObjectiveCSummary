//
//  main.m
//  6_打印类的所有方法
//
//  Created by kk on 2021/5/14.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
@interface MJPerson : NSObject
- (void)test1;
+ (void)test2;
@end
@implementation MJPerson
- (void)test1{
    NSLog(@"test1");
}
+ (void)test2{
    NSLog(@"test2");
}
@end
//打印类的所有实例方法
void printMethodNamesOfClass(Class cls)
{
    unsigned int count;
    // 获得方法数组
    Method *methodList = class_copyMethodList(cls, &count);
    
    // 存储方法名
    NSMutableString *methodNames = [NSMutableString string];
    
    // 遍历所有的方法
    for (int i = 0; i < count; i++) {
        // 获得方法
        Method method = methodList[i];
        // 获得方法名
        NSString *methodName = NSStringFromSelector(method_getName(method));
        // 拼接方法名
        [methodNames appendString:methodName];
        [methodNames appendString:@", "];
    }
    
    // 释放
    free(methodList);
    
    // 打印方法名
    NSLog(@"%@ %@", cls, methodNames);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//打印所有实例方法
        printMethodNamesOfClass([MJPerson class]);
//打印所有类方法
        printMethodNamesOfClass(object_getClass([MJPerson class]));
        
    }
    return 0;
}
