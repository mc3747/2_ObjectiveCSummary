//
//  main.m
//  结构体作为对象的属性
//
//  Created by xiaomage on 15/6/18.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 合理的设计一个”学生“类
 学生有* 姓名* 生日两个属性和说出自己姓名生日方法
 要求利用设计的学生类创建学生对象，并说出自己的姓名和年龄
 
 
 描述学生类
 
 事物名称: 学生(Student)
 属性:姓名(name), 生日(birthday)
 行为:说出字节姓名和生日(say)
 */
typedef struct {
    int year;
    int month;
    int day;
} Date;


@interface Student : NSObject
{
    @public
    NSString *_name;
//    struct Date birthday;
    Date _birthday;
}

- (void)say;

@end

@implementation Student

- (void)say
{
    NSLog(@"name = %@; year = %i, month = %i, day = %i", _name, _birthday.year, _birthday.month, _birthday.day);
}

@end

int main(int argc, const char * argv[]) {
    // 1.创建学生对象
    // 1.开辟存储空间
    // 2.初始化属性
    // 3.返回地址
    Student *stu = [Student new];

    // 2.设置学生对象的属性
    stu->_name = @"lnj";
    // 1.结构体只能在定义的时候初始化
    // 2.系统并不清楚它是数组还是结构体
//    stu->_birthday = (Date){1986, 1, 15};
    
    Date d = {1986, 1, 15};
    stu->_birthday = d;
    
//    stu->_birthday.year = 1986;
//    stu->_birthday.month = 1;
//    stu->_birthday.day = 15;
    
    // 3.让学生说出自己的姓名和生日
    [stu say];
    
    
    /*
    Date d1  = {1999, 1, 5};
    Date d2;
    d2 = d1; // 本质是将d1所有的属性的值都拷贝了一份赋值给d;
    
    d2.year = 2000;
    printf("d1 = year = %i\n", d1.year);
    printf("d2 = year = %i\n", d2.year);
     */
    
    return 0;
}
