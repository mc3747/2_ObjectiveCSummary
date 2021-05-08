//
//  main.m
//  第一个OC类-类方法2
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

typedef enum
{
    kIColorBlack, // 黑色
    kIColorWhite, // 白色
    kIColorTuHaoJin // 土豪金
} IColor;

// 1.编写类的声明
@interface Iphone : NSObject
{
    
@public
    float _model; // 型号  0
    int _cpu; // cup   0
    double _size; // 尺寸  0
//    int _color; // 颜色  0代表黑色 1代表白色 2土豪金
//    enum IColor _color;
    IColor _color;
}
- (void)about;
- (char *)loadMessage;
- (int)signal:(int)number;
- (int)sendMessageWithNumber:(int)number andContent:(char *)content;
+ (int)sumWithValue1:(int)value1 andValue2:(int)value2;

//- (NSString *)colorWithNumber:(IColor)number;
+ (NSString *)colorWithNumber:(IColor)number;
@end

// 2.编写类的实现
@implementation Iphone

// 行为的实现
- (void)about
{
    /*
//    char *name;
    NSString *name;
    switch (_color) {
        case 0:
            name = @"黑色";
            break;
        case 1:
            name = @"白色";
            break;
        case 2:
            name = @"土豪金";
            break;
        default:
            name = @"华强北";
            break;
    }
//    NSLog(@"型号 = %f, cpu = %i, 尺寸= %f, 颜色 = %i", _model, _cpu, _size, _color);
     */
//    Iphone *p = [Iphone new];
//    NSString *name = [p colorWithNumber:_color];
    NSString *name = [Iphone colorWithNumber:_color];
    NSLog(@"型号 = %f, cpu = %i, 尺寸= %f, 颜色 = %@", _model, _cpu, _size, name);
}

// 工具方法, 根据传入的整数返回对应的字符串
//- (NSString *)colorWithNumber:(IColor)number
+ (NSString *)colorWithNumber:(IColor)number;
{
    NSString *name;
    switch (number) {
        case 0:
            name = @"黑色";
            break;
        case 1:
            name = @"白色";
            break;
        case 2:
            name = @"土豪金";
            break;
        default:
            name = @"华强北";
            break;
    }
    return name;
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

+ (int)sumWithValue1:(int)value1 andValue2:(int)value2
{
    return value1 + value2;
}

@end

int main(int argc, const char * argv[]) {

    // 1.创建对象
    // 每次给Iphone类发送一个new消息都会开辟一块新的存储空间
    // 也就意味着每次发送new消息创建出来的对象都是一个新的对象
    Iphone *p = [Iphone new];
    p->_color = kIColorWhite;
    p->_cpu = 1;
    p->_model = 4;
    p->_size = 3.5;
    
    // 2.给对象发送消息
    [p about];
    
    return 0;
}
