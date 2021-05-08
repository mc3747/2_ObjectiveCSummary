//
//  main.m
//  3_OC复杂对象本质
//
//  Created by kk on 2021/5/8.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>
//普通对象
@interface Person : NSObject
{
    @public
    int _age;
}
@end
@implementation Person
@end
//普通对象
@interface Student : Person
{
    @public
    int _no;
}
@end
@implementation Student
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *per = [[Person alloc] init];
        per->_age = 5;
        NSLog(@"Person对象大小1：%zd", sizeof(per));
        NSLog(@"Person对象大小2：%zd", class_getInstanceSize([Person class]));
        NSLog(@"Person对象大小3：%zd", malloc_size((__bridge const void *)per));
        
        Student *stu = [[Student alloc] init];
        stu->_no = 4;
        stu->_age = 5;
        NSLog(@"Student对象大小1：%zd", sizeof(stu));
        NSLog(@"Student对象大小2：%zd", class_getInstanceSize([Student class]));
        NSLog(@"Student对象大小3：%zd", malloc_size((__bridge const void *)stu));
        
//内存对齐：结构体的内存大小，返回的是最大成员的整数倍
        
    }
    return 0;
}
