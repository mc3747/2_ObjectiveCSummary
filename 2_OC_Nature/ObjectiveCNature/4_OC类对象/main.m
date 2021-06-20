//
//  main.m
//  4_OC类对象
//
//  Created by kk on 2021/5/11.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSObject *object1 = [[NSObject alloc] init];
        NSObject *object2 = [[NSObject alloc] init];
//方法1：通过实例对象的class方法
        Class objectClass1 = [object1 class];
        Class objectClass2 = [object2 class];
//方法2：通过类的class方法
        Class objectClass3 = [NSObject class];
//方法3：通过runtime获取
        Class objectClass4 = object_getClass(object1);
        Class objectClass5 = object_getClass(object2);
        
        
        NSLog(@"%p %p",
              object1,
              object2);
        
        NSLog(@"%p %p %p %p %p",
              objectClass1,
              objectClass2,
              objectClass3,
              objectClass4,
              objectClass5);
        
    }
    return 0;
}
