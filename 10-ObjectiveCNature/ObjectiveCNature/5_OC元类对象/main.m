//
//  main.m
//  5_OC元类对象
//
//  Created by kk on 2021/5/11.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
/*
 1.Class objc_getClass(const char *aClassName)
 1> 传入字符串类名
 2> 返回对应的类对象
 
 2.Class object_getClass(id obj)
 1> 传入的obj可能是instance对象、class对象、meta-class对象
 2> 返回值
 a) 如果是instance对象，返回class对象
 b) 如果是class对象，返回meta-class对象
 c) 如果是meta-class对象，返回NSObject（基类）的meta-class对象
 
 3.- (Class)class、+ (Class)class
 1> 返回的就是类对象
 
 - (Class) {
     return self->isa;
 }
 
 + (Class) {
     return self;
 }
 */
int main(int argc, const char * argv[]) {
    @autoreleasepool {
//元类对象，只能通过runtime的方法来获取
        NSObject *object1 = [[NSObject alloc] init];
        Class objectClass1 = object_getClass(object1);
        // 将类对象当做参数传入，获得元类对象
        Class objectMetaClass = object_getClass(objectClass1);
        NSLog(@"%p",objectMetaClass);
//元类对象，也可以通过runtime的方法来判断class_isMetaClass
        BOOL isMetaClass = class_isMetaClass(objectMetaClass);
        NSLog(@"%d",isMetaClass);
    }
    return 0;
}
