//
//  main.m
//  第一个OC类-类方法
//
//  Created by xiaomage on 15/6/16.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 事物名称: iPhone
 属性: 颜色, 型号, cpu, 尺寸   == 成员变量
 行为:打电话, 发短信, 上网, 获取本机信息    == 成员方法
 */

// 1.编写类的声明
@interface Iphone : NSObject
{
    
@public
    float _model; // 型号  0
    int _cpu; // cup   0
    double _size; // 尺寸  0
    int _color; // 颜色  0
}
- (void)about;
- (char *)loadMessage;
- (int)signal:(int)number;
- (int)sendMessageWithNumber:(int)number andContent:(char *)content;

// 计算器
// 如果你不想每次使用方法都需要创建对象开辟存储空间
// 并且如果该方法中没有使用到属性(成员变量), 那么你可以把这个方法定义为类方法
// 对象方法用对象调用  类方法用类调用
//- (int)sumWithValue1:(int)value1 andValue2:(int)value2;

// 如果定义类方法, 类方法的写法和对象方法一模一样, 除了前面的-号不同以外 \
只需要将对象方法的-号换成+, 那么就定义了一个类方法
+ (int)sumWithValue1:(int)value1 andValue2:(int)value2;

+ (void)demo;

@end

// 2.编写类的实现
@implementation Iphone

// 行为的实现
- (void)about
{
//    NSLog(@"sum = %i", [Iphone sumWithValue1:50 andValue2:50]);
    NSLog(@"型号 = %f, cpu = %i, 尺寸= %f, 颜色 = %i", _model, _cpu, _size, _color);
//    Iphone *p = [Iphone new];
//    NSLog(@"%s", [p loadMessage]);
    
//    NSLog(@"%s", [self loadMessage]);
}
- (char *)loadMessage
{
    return "wife is god";
}

- (int)signal:(int)number
{
    NSLog(@"打电话给%i", number);
    return 1;
}

- (int)sendMessageWithNumber:(int)number andContent:(char *)content
{
    NSLog(@"发短信给%i, 内容是%s", number, content);
    return 1;
}

// 注意: 如果声明的是对象方法那么就必须实现对象方法
//      如果声明的是类方法那么就必须实现类方法

/*
 类方法和对象方法的区别
 0. 对象方法以-开头
    类方法以+开头
 
 1. 对象方法必须用对象调用
    类方法必须用类来调用
 
 2. 对象方法中可以直接访问属性(成员变量)
    类方法中不可以直接访问属性(成员变量)
 
 3. 类方法和对象方法可以进行相互调用
    4.1对象方法中可以直接调用类方法
    4.2类方法中间接调用对象方法  (注意: 不建议这样使用)
    4.3类方法中可以直接调用其它类方法
    4.4对象方法中可以直接调用对象方法
 
 类方法的应用场景
 如果方法中没有使用到属性(成员变量), 那么能用类方法就用类方法
 类方法的执行效率比对象方法高
 
 类方法一般用于定义工具方法
    字符串查找
    文件操作
    数据库操作
 */
+ (int)sumWithValue1:(int)value1 andValue2:(int)value2
{
//     NSLog(@"型号 = %f, cpu = %i, 尺寸= %f, 颜色 = %i", _model, _cpu, _size, _color);
//    Iphone *p = [Iphone new];
//    [p signal:123456789]; // 注意: 在企业开发中, 不建议这样使用
    return value1 + value2;
}

+ (void)demo
{
//    NSLog(@"%i", [Iphone sumWithValue1:90 andValue2:90]);
    NSLog(@"demo");
}
@end

int main(int argc, const char * argv[]) {
    
    /*
    // 1.通过类创建对象
    Iphone *p = [Iphone new];
    // 2.修改对象的属性
    p->_size = 3.5;
    p->_color = 0;
    p->_model = 4;
    p->_cpu = 1;
    

    // 3.如果给对象发消息(如果调用对象的方法)
    [p  about];
    char *content = [p loadMessage];
    NSLog(@"content = %s", content);
    [p signal:13838338];
    [p sendMessageWithNumber:123456789 andContent:"hi"];
    
//    int res = [p sumWithValue1:10 andValue2:20];
    int res = [Iphone sumWithValue1:10 andValue2:20];
    NSLog(@"res = %i", res);
     */
    
//    [Iphone signal:13838338];
    
    Iphone *p = [Iphone new];
//    int res = [p sumWithValue1:10 andValue2:20];
//    [p about];
    
//    [Iphone sumWithValue1:10 andValue2:20];
//    [Iphone demo];
    
    [p about];
    
    return 0;
}

void test()
{
    // 1.创建一个对象
    /*
     开辟一块存储空间
     */
//    Iphone *p1 = [Iphone new];
    // 2.利用对象调用加法运算方法
//    int res = [p1 sumWithValue1:50 andValue2:50];
    int res = [Iphone sumWithValue1:50 andValue2:50];
    NSLog(@"res = %i", res);
    
}
