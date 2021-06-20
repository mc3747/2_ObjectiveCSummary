//
//  main.m
//  1_OC对象本质
//
//  Created by kk on 2021/5/8.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>

/*
 🌈NSObject利用oc头文件显示：
 @interface NSObject <NSObject> {
     Class isa  ;
 //Class是一个指针
 }
 */

/*
 🌈NSObject利用编译成的c++：
 struct NSObject_IMPL {
    Class isa;
};
 */

int main(int argc, const char * argv[]) {
    @autoreleasepool {
/*
 alloc init的执行步骤：
 分配空间
 初始化对象
 指向对象
 */
        NSObject *obj = [[NSObject alloc] init];
        
//方案1：运算符，编译后转成常数，传入类型（传对象，相当于指针）：8个字节
        NSLog(@"NSObject1 - %zd", sizeof([NSObject class]));
        
//方案2：类对象的实例对象的成员变量所占用的内存大小：8个字节
        NSLog(@"NSObject2 - %zd", class_getInstanceSize([NSObject class]));
        
//方案3：指针obj区域的内存实际分配的大小：16个字节
        NSLog(@"NSObject3 -%zd", malloc_size((__bridge const void *)obj));
    
//分析思路一：查看转换后的c++文件
        
//分析思路二：读取苹果源码，分析
 
//分析思路三：打断点，得到对象地址
        //图形查看
        //lldb命令
        
    }
    return 0;
}
