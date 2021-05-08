//
//  main.m
//  2_OC普通对象本质
//
//  Created by kk on 2021/5/8.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>

//普通对象底层的结构体
struct Student_IMPL {
    Class isa;
    int _no;
    int _age;
};

//普通对象
@interface Student : NSObject
{
    @public
    int _no;
    int _age;
}
@end
@implementation Student

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
//使用类
        Student *stu = [[Student alloc] init];
        stu->_no = 4;
        stu->_age = 5;
        NSLog(@"Student对象大小1：%zd", sizeof([Student class]));
        NSLog(@"Student对象大小2：%zd", class_getInstanceSize([Student class]));
        NSLog(@"Student对象大小3：%zd", malloc_size((__bridge const void *)stu));
        
//使用结构体的指针接收
        struct Student_IMPL *stuImpl = (__bridge struct Student_IMPL *)stu;
        NSLog(@"no is %d, age is %d", stuImpl->_no, stuImpl->_age);
    }
    return 0;
}
