//
//  Person1.h
//  泛型汇总
//
//  Created by gjfax on 2018/6/7.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person1 : NSObject
{
@public
    int _age;
    
@private
    double _height;
    
@protected
    double _weight;
    
@package
    NSString *_name;
    NSString *_tel;
    NSString *_email;
}
/*
 1,@public
 >可以在其它类中访问成员变量
 >也可以在本类中成员变量
 >可以在子类中访问父类中被public修饰的成员变量
 
 2,@private
 >不可以在其它类中访问成员变量
 >可以在本类中访问成员变量
 >不可以在子类中访问父类中被private修饰的成员变量
 
 3,@protected
 >不可以在其它类中访成员变量
 >可以在本类中访问成员变量
 >可以在子类中访问父类中被protected修饰成员变量
 
 4,@package
 >介于public和private之间的
 如果是在其它包中访问那么就是private的
 如果是在当前代码所在的包种访问就是public的
 
 5,注意: 默认情况下所有的实例变量都是protected
 
 6,实例变量修饰符作用域: 从出现的位置开始, 一直直到下一个修饰符出现
 如果没有遇到下一个实例变量修饰符, 那么就会修饰后面所有的实例变量
 */
@end
