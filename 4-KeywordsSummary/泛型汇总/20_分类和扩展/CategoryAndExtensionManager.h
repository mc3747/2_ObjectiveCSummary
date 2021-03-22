//
//  CategoryAndExtensionManager.h
//  泛型汇总
//
//  Created by gjfax on 2018/6/12.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryAndExtensionManager : NSObject
/*
 分类（Category）：
 1，为某个类，扩展方法；
 2，不能添加成员变量；
 3，如果分类中的@property, 只会生成setter/getter方法的声明, 不会生成实现以及私有的成员变量；
 4，可以在分类中访问原有类中.h中的属性；
 5，如果分类中有和原有类同名的方法, 会调用分类中的方法，忽略原有类，方法的调用顺序:
     1.分类
     2.本类
     3.父类；
 6，如果多个分类中都有和原有类中同名的方法, 那么调用该方法的时候执行谁由编译器决定：最后一个参与编译的分类中的方法
 
 扩展（Extension，匿名分类）：
 1，能够扩充私有成员变量；
 2，一般写在.m文件，类的实现中
 */
@end
