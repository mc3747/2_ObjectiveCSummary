//
//  PolymorphismVC.m
//  排序总结
//
//  Created by gjfax on 2020/3/12.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "PolymorphismVC.h"
//父类-----phone
@interface Phone : NSObject
@property (nonatomic,strong) NSString *name;
- (void)call;
@end

@implementation Phone
- (void)call{
    NSLog(@"%s",__func__);
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", _name];
}
@end

//子类-----IPhone
@interface IPhone : Phone
@end

@implementation IPhone
- (void)call{
    NSLog(@"%s",__func__);
}
@end

//子类-----Android
@interface Android : Phone
@end

@implementation Android
- (void)call{
    NSLog(@"%s",__func__);
}
@end

// =====================================================
/*
 1,多态条件
    有继承关系,子类重写父类方法
    父类指针指向子类对象
    调用父类方法
2,本质
    动态绑定
    动态类型能使程序直到执行时才确定对象的真实类型
    动态类型绑定能使程序直到执行时才确定要对那个对象调用的方法
3,好处
    1,简化了编程接口,不用为每一个新加的函数命名一个新名字
    2,扩展性好,同一个函数可以实现不同的功能
 */
// =====================================================
@interface PolymorphismVC ()

@end

@implementation PolymorphismVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    Phone *p = [[IPhone alloc]init];
    p.name = @"iPhone";
    [p call];
    NSLog(@"%@",p);

    Phone *a = [[Android alloc]init];
    a.name = @"Android";
    [a call];
    NSLog(@"%@",a);
}



@end
