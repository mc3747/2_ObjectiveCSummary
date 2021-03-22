//
//  ToolManager.m
//  排序总结
//
//  Created by gjfax on 2018/6/5.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "ParameterManager.h"
@implementation ParameterManager

- (void)getParaWithType:(MethodType)method {
    Parameter1 *parameter = (Parameter1 *)self.parameter;
    NSLog(@"%i",parameter.number);
}


/*iOS实现传递不定长的多个参数的方法是使用va_list。va_list是C语言提供的处理变长参数的一种方法。在调用的时候要在参 数结尾的时候加nil
 va_list的使用需要注意:
 1.首先在函数里定义va_list型的变量，这个变量是指向参数的指针；
 2.然后用va_start初始化刚定义的va_list变量；
 3.然后用va_arg返回可变的参数，va_arg的第二个参数是你要返回的参数的类型.如果函数有多个可变参数的，依次调用va_arg获取各个参数；
 4.最后用va_end宏结束可变参数的获取
 NS_REQUIRES_NIL_TERMINATION，是一个宏，用于编译时非nil结尾的检查。 调用时要以nil结尾，否则会崩溃。
 
 */
+ (void)getType:(MethodType)mathod params:(NSString *)string, ...NS_REQUIRES_NIL_TERMINATION {
    
// 1，取出第一个参数
    NSLog(@"传的第1个参数%@", string);
    
// 2.定义一个指向个数可变的参数列表指针；
    va_list args;
    
// 3.va_start(args, str);string为第一个参数，也就是最右边的已知参数,这里就是获取第一个可选参数的地址.使参数列表指针指向函数参数列表中的第一个可选参数，函数参数列表中参数在内存中的顺序与函数声明时的顺序是一致的。
    va_start(args, string);
    
    if (string)
    {
        //依次取得除第一个参数以外的参数
// 4.va_arg(args,NSString)：返回参数列表中指针所指的参数，返回类型为NSString，并使参数指针指向参数列表中下一个参数。
        // 用于存放取出的参数
        NSString *arg;
        while ((arg = va_arg(args, NSString *)))
        {
            NSLog(@"传的剩余参数有：%@",arg);
        };
    }
    //5.清空参数列表，并置参数指针args无效。
    va_end(args);
}
@end
