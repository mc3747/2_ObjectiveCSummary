//
//  main.m
//  22_Block实现链式调用
//
//  Created by kk on 2021/5/20.
//

#import <Foundation/Foundation.h>
/*
 核心思想就是传递实例，让下一个链可以继续调用下一个方法
 */
// =====================================================
/*
简单案例
 */
// =====================================================
@interface Person:NSObject
- (Person * (^)(NSString *foodName))eat;
- (Person * (^)(NSInteger hour))sleep;
@end
@implementation Person
- (Person *(^)(NSString *))eat
{
    Person* (^eatBlock)(NSString *) = ^(NSString *foodName) {
        NSLog(@"吃: %@",foodName);
        return self;
    };
    return eatBlock;
}

- (Person *(^)(NSInteger))sleep
{
    return ^(NSInteger hour) {
        NSLog(@"睡了%ld小时",(long)hour);
        return self;
    };
}

@end
// =====================================================
/*
复杂案例
 */
// =====================================================
//
@interface CalculateManager : NSObject

@property (nonatomic, assign) NSInteger result;

- (CalculateManager *(^)(NSInteger))add;

@end

@implementation CalculateManager

- (CalculateManager *(^)(NSInteger))add {
    
    return  ^(NSInteger value) {
        self->_result += value;
        return self;
    };
}

@end

//计算
@interface NSObject (Calculate)

+ (NSInteger)why_makeCalculate: (void(^)(CalculateManager *))block;

@end
@implementation NSObject (Calculate)

+ (NSInteger)why_makeCalculate:(void(^)(CalculateManager *))block {
    
    CalculateManager *manager = [[CalculateManager alloc] init];
    block(manager);
    return manager.result;
}

@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *person = [Person new];
        person.eat(@"🍔").sleep(5);
        
        NSInteger value = [NSObject why_makeCalculate:^(CalculateManager *manager) {
            manager.add(5).add(5).add(5);
        }];
        
        NSLog(@"%zd", value);
    }
    return 0;
}
