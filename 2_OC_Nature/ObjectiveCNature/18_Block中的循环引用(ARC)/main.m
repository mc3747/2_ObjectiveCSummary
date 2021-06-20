//
//  main.m
//  18_Block中的循环引用
//
//  Created by kk on 2021/5/19.
//

#import <Foundation/Foundation.h>
typedef void (^MJBlock) (void);

@interface MJPerson : NSObject
@property (copy, nonatomic) MJBlock block;
@property (assign, nonatomic) int age;
-(void)test;
@end
@implementation MJPerson
- (void)dealloc
{
    NSLog(@"%s", __func__);
}
- (void)test
{
//1，产生循环引用，内存泄露
//    self.block = ^{
//                NSLog(@"age is %d", self->_age);
//            };
    
//2,使用__weak
//    __weak typeof(self) weakSelf = self;
//    self.block = ^{
//        NSLog(@"age is %d", weakSelf.age);
//    };
    
//3,使用__unsafe_unretained
//    __unsafe_unretained typeof(self) weakSelf = self;
//    self.block = ^{
//        NSLog(@"age is %d", weakSelf.age);
//    };

//4,使用__block,不能置空self，此处暂不可用
//    __block typeof(self) blockSelf = self;
//    self.block = ^{
//        NSLog(@"age is %d", blockSelf.age);
//        blockSelf = nil;
//    };
    
//5,使用weakSelf和strongSelf
//在block中，又有block的情况，需要使用strong
__weak typeof(self) weakSelf = self;
self.block = ^{
    __strong typeof(weakSelf) strongSelf = weakSelf;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [strongSelf printAge];
   });
};

    self.block();
}
- (void)printAge{
    NSLog(@"age is %d", self.age);
}
@end
//内容的例子
void test0(void){
    MJPerson *person = [[MJPerson alloc] init];
    person.age = 10;
    [person test];
}

//循环引用，产生内存泄露
void test1(void){
    MJPerson *person = [[MJPerson alloc] init];
    person.age = 10;
    person.block = ^{
        NSLog(@"age1 is %d", person.age);
    };
    person.block();
}
//解决内存泄露方法1：使用__weak修饰
void test2(void){
    MJPerson *person = [[MJPerson alloc] init];
    person.age = 10;
    __weak typeof(person) weakPerson  = person;
    person.block = ^{
        NSLog(@"age2 is %d", weakPerson.age);
    };
    person.block();
}
//解决内存泄露方法2：使用__unsafe_unretained修饰
void test3(void){
    MJPerson *person = [[MJPerson alloc] init];
    person.age = 10;
    __unsafe_unretained typeof(person) unsafePerson  = person;
    person.block = ^{
        NSLog(@"age3 is %d", unsafePerson.age);
    };
    person.block();
}
//解决内存泄露方法3：使用__block，并且执行完毕要置空
void test4(void){
    MJPerson *person = [[MJPerson alloc] init];
    person.age = 10;
    __block typeof(person) blockPerson  = person;
    person.block = ^{
        NSLog(@"age4 is %d", blockPerson.age);
        blockPerson = nil;
    };
    person.block();
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        test0();
//        test1();
//        test2();
//        test3();
//        test4();
    }
    return 0;
}
