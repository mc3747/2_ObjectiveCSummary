//
//  main.m
//  常见错误
//
//  Created by xiaomage on 15/6/16.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    int _age;
}

- (void)test;
@end


@implementation Person

- (void)test
{
    NSLog(@"test");
}
@end



int main(int argc, const char * argv[]) {
    
    Person *p = [Person new];
    [p test];
    /*
     //    1.只有类的声明，没有类的实现
     //    2.漏了@end
     //    3. @interface和@implementation嵌套
     //    4.成员变量没有写在括号里面
     //    5.方法的声明写在了大括号里面
     //    6.成员变量不能在{}中进行初始化、不能被直接拿出去访问
     //    7.方法不能当做函数一样调用
     //    8.OC方法只能声明在@interface和@end之间，只能实现在@implementation和@end之间。也就是说OC方法不能独立于类存在
     //    9.C函数不属于类，跟类没有联系，C函数只归定义函数的文件所有
     //    10.C函数不能访问OC对象的成员
     //    11.低级错误：方法有声明，但是实现的时候写成了函数
     //    12.OC可以没有@interface同样可以定义一个类
     */
    
    return 0;
}
