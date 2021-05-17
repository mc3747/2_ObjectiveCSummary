//
//  main.m
//  10_Category属性
//
//  Created by kk on 2021/5/17.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#pragma mark - 源类
@interface MCPerson:NSObject
@property (assign,nonatomic) int age;
@end
@implementation MCPerson
@end
#pragma mark - 分类1
/*
方案：直接添加属性，
问题：只生成声明，编译成功，使用时直接报错
 */
//@interface MCPerson(test1)
//@property (assign,nonatomic) int weight;
//
//@end
//
//@implementation MCPerson(test1)
//
//@end

#pragma mark - 分类2
/*
 方案：添加成员变量和setter，getter方法，
 问题：编译器直接报错
 */
//@interface MCPerson(test2)
//{
//    int _weight;
//}
//- (void)setWeight:(int)weight;
//- (int)weight;
//@end
//@implementation MCPerson(test2)
//int weight_;
//
//- (void)setWeight:(int)weight
//{
//    weight_ = weight;
//}
//
//- (int)weight
//{
//    return weight_;
//}
//@end

#pragma mark - 分类3
/*
 方案：使用属性，重写setter和getter方法的实现，成员变量用全局变量来接收
 问题：不同的对象，都可以修改这个全局变量，改动后，先初始化的对象属性就会改动
 */
//@interface MCPerson(test3)
//@property (assign, nonatomic) int weight;
//@end
//@implementation MCPerson(test3)
//int weight_;
//
//- (void)setWeight:(int)weight
//{
//    weight_ = weight;
//}
//
//- (int)weight
//{
//    return weight_;
//}
//@end

#pragma mark - 分类4
/*
 方案：属性 ，全局字典存储值，key为每个对象的地址
 问题：内存泄露，多线程问题
 */
//@interface MCPerson(test4)
//@property (assign, nonatomic) int weight;
//
//@end
//@implementation MCPerson(test4)
//#define MJKey [NSString stringWithFormat:@"%p", self]
//NSMutableDictionary *weights_;
//+ (void)load
//{
//    weights_ = [NSMutableDictionary dictionary];
//}
//- (void)setWeight:(int)weight
//{
//    weights_[MJKey] = @(weight);
//}
//
//- (int)weight
//{
//    return [weights_[MJKey] intValue];
//}
//@end
#pragma mark - 分类5
/*
 方案：对象关联，static const char MJWeightKey ；作为key
 问题：
 */
//@interface MCPerson(test5)
//@property (assign, nonatomic) int weight;
//
//@end
//@implementation MCPerson(test5)
//
//static const char MJWeightKey;
//
//- (void)setWeight:(int)weight
//{
//    objc_setAssociatedObject(self, &MJWeightKey, @(weight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (int)weight
//{
//    return [objc_getAssociatedObject(self, &MJWeightKey) intValue];
//}
//@end
#pragma mark - 分类6
/*
 方案：对象关联：static const void *MJWeightKey = &MJWeightKey;作为key
 问题：
 */
//@interface MCPerson(test6)
//@property (assign, nonatomic) int weight;
//
//@end
//@implementation MCPerson(test6)
//
//static const void *MJWeightKey = &MJWeightKey;
//
//- (void)setWeight:(int)weight
//{
//    objc_setAssociatedObject(self, MJWeightKey, @(weight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (int)weight
//{
//    return [objc_getAssociatedObject(self, MJWeightKey) intValue];
//}
//@end

#pragma mark - 分类7
/*
 方案：对象关联，宏定义#define MJWeightKey @"weight"；作为key
 问题：
 */
//@interface MCPerson(test7)
//@property (assign, nonatomic) int weight;
//@end
//@implementation MCPerson(test7)
//
//#define MJWeightKey @"weight"
//
//- (void)setWeight:(int)weight
//{
//    objc_setAssociatedObject(self, MJWeightKey, @(weight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (int)weight
//{
//    return [objc_getAssociatedObject(self, MJWeightKey) intValue];
//}
//@end

#pragma mark - 分类8
/*
 方案：对象关联，@selector(weight)作为key
 问题：
 */
//@interface MCPerson(test8)
//@property (assign, nonatomic) int weight;
//@end
//@implementation MCPerson(test8)
//
//- (void)setWeight:(int)weight
//{
//    objc_setAssociatedObject(self, @selector(weight), @(weight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (int)weight
//{
//    return [objc_getAssociatedObject(self, @selector(weight)) intValue];
//}
//@end

#pragma mark - 分类9
/*
 方案：对象关联，_cmd作为key
 问题：
 */
@interface MCPerson(test9)
@property (assign, nonatomic) int weight;
@end
@implementation MCPerson(test9)
- (void)setWeight:(int)weight
{
    objc_setAssociatedObject(self, @selector(weight), @(weight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (int)weight
{
// _cmd == @selector(weight)
//  隐私参数：self，和_cmd
//  _cmd只能在getter方法中使用,
    return [objc_getAssociatedObject(self, _cmd) intValue];
}

@end
//🌈main入口
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        MCPerson *person =  [[MCPerson alloc]init];
        person.age = 5;
        person.weight = 100;
        NSLog(@"age：%i --- weight：%i",person.age ,person.weight);
        MCPerson *person1 =  [[MCPerson alloc]init];
        person1.age = 5;
        person1.weight = 200;
        
        NSLog(@"age：%i --- weight：%i",person.age ,person.weight);
        NSLog(@"age：%i --- weight：%i",person1.age ,person1.weight);
        
        ^{
            
        }();
    }
    return 0;
}
