//
//  main.m
//  第一个OC类-方法2
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
// 注意: OC中的方法, 如果没有形参不需要写(), 而是直接写一个;
// 为什么OC中没有形参不需要写()呢? 因为OC方法中的()有特殊的用途, OC方法中的()是用来扩住数据类型的
- (void)about;
/*
 C语言的函数:
 没有返回值没有参数的
 有返回值没有参数的
 有返回值有参数的
 没有返回值有参数的 
 */
// 有返回值没有参数的, 读取短信
- (char *)loadMessage;

// 有返回值有参数的, 打电话
// int signal(int number);
// 注意: OC中的方法如果有参数, 那么每个参数的数据类型前面必须加上一个:
// 注意: 当前这个有参数的方法它的方法名称是  signal:
//       冒号也是方法名称的一部分
- (int)signal:(int)number;

// 有返回值并且有多个参数的, 发短信
// int sendMessage(int number, char *content);
// 下面这个方法的方法名称是 sendMessage::
//- (int)sendMessage:(int)number :(char *)content;

// 为了提高我们的阅读性, OC方法允许我们给每个参数添加一个标签来说明当前参数的含义
// 注意: 标签也是方法名的一部分
// 方法名是 sendMessageWithNumber:andContent:
- (int)sendMessageWithNumber:(int)number andContent:(char *)content;

@end

// 2.编写类的实现
@implementation Iphone

// 行为的实现
- (void)about
{
    // 如果在对象方法中想访问该对象的属性, 可以直接协商_属性名称即可
//    NSLog(@"打印本机信息");
    NSLog(@"型号 = %f, cpu = %i, 尺寸= %f, 颜色 = %i", _model, _cpu, _size, _color);
}
- (char *)loadMessage
{
//    char *content = "老婆我们家我做主";
//    return content;
    return "wife is god";
}

- (int)signal:(int)number
{
    NSLog(@"打电话给%i", number);
    return 1;
}

//- (int)sendMessage:(int)number :(char *)content
- (int)sendMessageWithNumber:(int)number andContent:(char *)content
{
    NSLog(@"发短信给%i, 内容是%s", number, content);
    return 1;
}
@end

int main(int argc, const char * argv[]) {
    
    // 1.通过类创建对象
    Iphone *p = [Iphone new];
    // 2.修改对象的属性
    p->_size = 3.5;
    p->_color = 0;
    p->_model = 4;
    p->_cpu = 1;
    
    // 3.获取对象的属性
//    NSLog(@"size = %f, color = %i, model = %f, cpu = %i", p->_size, p->_color, p->_model, p->_cpu);
    
    // 4.如果给对象发消息(如果调用对象的方法)
    [p  about];
    
//    [对象 消息名称(方法名称)]
    // 注意: OC中的NSLog对C语言的字符串支持不是很好, 如果返回的是中文的C语言字符串可能输出的是乱码, 也有可能什么都不输出
    char *content = [p loadMessage];
    NSLog(@"content = %s", content);
    
    [p signal:13838338];
//    [p sendMessage:1383838333 :"luck"];
    [p sendMessageWithNumber:123456789 andContent:"hi"];
    
    
    return 0;
}