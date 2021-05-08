//
//  main.m
//  id类型
//
//  Created by xiaomage on 15/6/23.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Student.h"

int main(int argc, const char * argv[]) {

    /*
     id是一个数据类型, 并且是一个动态数据类型
     既然是数据类型, 所以就快要用来
     1.定义变量
     2.作为函数的参数
     3.作为函数的返回值
     
     默认情况下所有的数据类型都是静态数据类型
     静态数据类型的特点: 
     在编译时就知道变量的类型, 
     知道变量中有哪些属性和方法
     在编译的时候就可以访问这些属性和方法, 
     并且如果是通过静态数据类型定义变量, 如果访问了不属于静态数据类型的属性和方法, 那么编译器就会报错
     
     动态数据类型的特点:
     在编译的时候编译器并不知道变量的真实类型, 只有在运行的时候才知道它的真实类型
     并且如果通过动态数据类型定义变量, 如果访问了不属于动态数据类型的属性和方法, 编译器不会报错
     
     id == NSObject * 万能指针
     id和NSObject *的区别: 
     NSObject *是一个静态数据类型
     id  是一个动态数据类型
     */
    /*
    Person *p = [Person new];
    p.age = 30;
    [p sleep];
     */
    /*
    Person *p = [Student new];
    p.age = 30;
    [p sleep];
//    [p eat];
    Student *stu = (Student *)p;
    [stu eat];
     */

   /*
    NSObject *obj = [Person new];
    [obj test];
    NSObject *obj2 = [Student new];
 */
    
  
    /*
    // 通过静态数据类型定义变量, 不能调用子类特有的方法
    // 通过动态数据类型定义变量, 可以调用子类特有的方法
    // 通过动态数据类型定义的变量, 可以调用私有方法
    
    // 弊端: 由于动态数据类型可以调用任意方法, 所以有可能调用到不属于自己的方法, 而编译时又不会报错, 所以可能导致运行时的错误
    // 应用场景: 多态, 可以减少代码量, 避免调用子类特有的方法需要强制类型转换
    id obj = [Person new];
    [obj sleep];
    [obj test];
    [obj eat];
    
    id obj2 = [Student new];
    [obj2 eat];
    [obj2 test];
     */
    
    // 为了避免动态数据类型引发的运行时的错误, 一般情况下如果使用动态数据类型定义一个变量, 在调用这个变量的方法之前会进行一次判断, 判断当前变量是否能够调用这个方法
//    id obj = [Person new];
    id obj = [Student new];
    /*
    if ([obj isKindOfClass:[Student class]]) {
        // isKindOfClass , 判断指定的对象是否是某一个类, 或者是某一个类的子类
        [obj eat];
    }
     */
   
    if ([obj isMemberOfClass:[Student class]]) {
        // isMemberOfClass : 判断指定的对象是否是当前指定的类的实例
        [obj eat];
    }
    

    NSLog(@"------");
    
    
    return 0;
}
