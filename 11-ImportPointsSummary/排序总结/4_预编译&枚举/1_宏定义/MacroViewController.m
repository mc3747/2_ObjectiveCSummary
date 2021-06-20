//
//  MacroViewController.m
//  排序总结
//
//  Created by gjfax on 2020/3/9.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "MacroViewController.h"


//对象宏
#define M_PI        3.14159265358979323846264338327950288

//函数宏
#define PLUS(x,y) ((x) + (y))

//字符串化:#
#define STR(s) #s

//字符串连接:##
#define STR_COMBINE(a,b) a##b

//可变参数宏
    /*
     1,##就是个粘合剂，将前后两部分粘合起来，也就是有“字符化”的意思。
     2,而__VA_ARGS__在预编译中会被实参列表取代， ...表示可变参列表。
     3,,##__VA_ARGS__ 宏前面加上##的作用在于，当可变参数的个数为0时，这里的##起到把前面多余的,去掉的作用,否则会编译出错
     */

#define MCLog(str, ...)  NSLog(@"%s(%d): " str, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

@interface MacroViewController ()

@end
// =====================================================
/*
 1,对象宏
 2,函数宏
 3,宏的注意点
    
    可变参数
    ({...})
    #:将宏参数转成字符串
    ##:用##运算符来实现标识符连接
    换行\
 3,Clang系统宏:MIN,MAX等
 4,打印
    利用宏来改造NSLog
    宏定义自定义log
    __FILE__返回当前文件的绝对路径，
    __LINE__返回展开该宏时在文件中的行数，
    __func__是改宏所在scope的函数名称。
    __DATE__：进行预处理的日期（”Mmm dd yyyy”形式的字符串）
    __TIME__：源文件编译时间（格式“hh:mm:ss”）
    打印数组,字典,对象,中文
 5,测试相关的宏:XCTAssertTrue
 6,pragma宏
    #pragma：说明编译器信息

    _Pragma：同#pragma，但功能更强大；

    #warning：显示编译警告信息

    #error：显示编译错误信息

    #line：标志该语言的行号
 6,#define和const区别
 */
// =====================================================
@implementation MacroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s",STR(body-k));
    
    NSLog(@"%d",STR_COMBINE(3,8));
    
    MCLog(@"%d和%@",4,@"55");
}

-(void)printIdType:(id)input{
    
//    1,空类型:
   
//    2,基本类型
//    number
//    枚举
//    char
//    bool
    
//    3,构造类型:数组,结构体,共用体,枚举
    
//    4,指针类型:String,字典,class对象(所有的系统类, 自定义类都是指针)

    
//    5,其他类型:sel,block,json
    
}

- (void) originTypeFromNumber: (id) data {
  // 判断空值
  if ([data isKindOfClass:[NSNull class]]) {
    
  //  数值
  }if([data isKindOfClass:[NSNumber class]]){
      
    if (strcmp([data objCType], @encode(short)) == 0){
        NSLog(@"短整型:%hd",(short)data);
        
    }else if (strcmp([data objCType], @encode(int)) == 0){
        NSLog(@"整型:%d",(int)data);
        
    }else if (strcmp([data objCType], @encode(long)) == 0){
         NSLog(@"长整型:%ld",(long)data);
        
    }else if (strcmp([data objCType], @encode(float)) == 0){
        NSLog(@"单精度浮点型:%f",data);
        
    }else if (strcmp([data objCType], @encode(double)) == 0){
      NSLog(@"双精度浮点型:%.4f",data);
        
    }else if (strcmp([data objCType], @encode(BOOL)) == 0){
      NSLog(@"布尔类型:%d",(bool)data);
        
    }else if (strcmp([data objCType], @encode(char)) == 0){
      NSLog(@"字符类型:%c",(char)data);
        
    }else{
      
    };
      
// 数组
  }else if([data isKindOfClass:[NSArray class]]){
          NSLog(@"数组类型:%@",[(NSArray *)data description]);
   
// 结构体
 }else if([NSValue valueWithRange:[data rangeValue]]){
     NSLog(@"数组类型:%@",(NSArray *)data);
    
// 共用体
 }else if([data isKindOfClass:[NSArray class]]){
     NSLog(@"数组类型:%@",(NSArray *)data);
     
 }
  // 字符串
  else if([data isKindOfClass:[NSString class]]){
      NSLog(@"字符串类型:%@",(NSString *)data);

  // 字典
  }else if([data isKindOfClass:[NSDictionary class]]){
      NSLog(@"字符串类型:%@",[(NSDictionary *)data description]);
  }
  
}




@end
