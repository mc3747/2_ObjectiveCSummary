//
//  main.m
//  15_Block访问对象类型的auto变量
//
//  Created by kk on 2021/5/18.
//

#import <Foundation/Foundation.h>
@interface MJPerson : NSObject
@property (assign, nonatomic) int age;
@end
@implementation MJPerson

- (void)dealloc
{
//    [super dealloc];
    NSLog(@"MJPerson - dealloc");
}
@end

//🌈1，当block内部访问了对象类型的auto变量时；如果block是在栈上，将不会对auto变量产生强引用
void (^block)(void);
void test1(){
    MJPerson *person = [[MJPerson alloc] init];
    person.age = 10;
    block = ^{
        NSLog(@"block---------%d", person.age);
    };
    NSLog(@"%@",[block class]);
}

//🌈2，如果block被拷贝到堆上
/*会调用block内部的copy函数
copy函数内部会调用_Block_object_assign函数
_Block_object_assign函数会根据auto变量的修饰符（__strong、__weak、__unsafe_unretained）做出相应的操作，形成强引用（retain）或者弱引用
 */
//强引用，结束后不释放
void test2(){
    MJPerson *person = [[MJPerson alloc] init];
    person.age = 10;
    block = ^{
        NSLog(@"block---------%d", person.age);
    };
}
//弱引用，结束后释放
void test3(){
    MJPerson *person = [[MJPerson alloc] init];
    person.age = 10;
    
    __weak MJPerson *weakPerson = person;
    block = ^{
        NSLog(@"block---------%d", weakPerson.age);
    };
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        test1();
//        test2();
        test3();
    }
    return 0;
}
