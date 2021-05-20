//
//  main.m
//  21_Block回调和函数指针
//
//  Created by kk on 2021/5/19.
//

#import <Foundation/Foundation.h>
/*
 C语言的回调函数，函数指针
 OC的block回调
 C++的lamda
 */
//🌈：单纯的传递参数:直接使用block定义
@interface Person1 : NSObject
@property(copy,nonatomic) void(^passValueBlock)(int a,int b);
- (void)startTest;
@end
@implementation Person1
- (void)startTest{
    if (self.passValueBlock) {
        self.passValueBlock(3,4);
    };
};
@end

//🌈：单纯的传递参数:使用typedef定义
@interface Person2 : NSObject
typedef void(^PassValueBlock)(int a,int b);
@property(copy,nonatomic) PassValueBlock passValueBlock;
- (void)startTest;
@end
@implementation Person2

- (void)startTest{
    if (self.passValueBlock) {
        self.passValueBlock(7,4);
    };
};
@end

//🌈：同时传入block和其他额外参数的情况
@interface Person3 : NSObject
@property(copy,nonatomic) void(^passValueBlock)(int a,int b);
-(void)useSumBlock:(void(^)(int a,int b))passValueBlock increase:(int)increase;
- (void)startTest;
@property(assign,nonatomic)int increase;
@end
@implementation Person3

-(void)useSumBlock:(void(^)(int a,int b))passValueBlock increase:(int)increase{
    self.passValueBlock = passValueBlock;
    self.increase = increase;
}
- (void)startTest{
    if (self.passValueBlock) {
        self.passValueBlock(3 + self.increase,4 + self.increase);
    };
};
@end


@interface Person4 : NSObject
@property(copy,nonatomic) int (^caculateBlock)(int a,int b);
- (int)startTestWithA:(int)a B:(int)b;
@end
@implementation Person4
- (int)startTestWithA:(int)a B:(int)b{
    if (self.caculateBlock) {
       return self.caculateBlock(a,b);
    }else{
        return 0;
    };
};
@end

//函数指针
int max(int x, int y)
{
    return x > y ? x : y;
}
void test1(void){
    int (* p)(int, int) = & max;
    printf("最大值：%d\n",p(9,6));
}

//回调函数
/*
 函数指针作为某个函数的参数
 这个函数叫做回调函数
 */
int Callback_1(int x,int y)
{
    return  x + y;
};
int Callback_2(int x,int y)
{
    return  x - y;
};
int HandleAction(int x,int y,int (*Callback)(int,int))
{
    return Callback(x,y);
};

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//1-C语言的函数指针
//        test1();
//2-C语言的回调函数
//        printf("求和：%d\n",HandleAction(3, 4, Callback_1));
//        printf("求差：%d\n",HandleAction(3, 4, Callback_2));
//3-OC的回调
//3.1 使用纯block回调传参
//        Person1 *person1 = [Person1 new];
//        person1.passValueBlock = ^(int a, int b) {
//            NSLog(@"传递的参数是：%d和%d",a,b);
//        };
//        [person1 startTest];
        
//3.2 使用typedef的block回调传参
//        Person2 *person2 = [Person2 new];
//        [person2 setPassValueBlock:^(int a, int b) {
//            NSLog(@"传递的参数是：%d和%d",a,b);
//        }];
//        [person2 startTest];
        
//3.3 同时传入block和其他额外参数的情况
//        Person3 *person3 = [Person3 new];
//        [person3 useSumBlock:^(int a, int b) {
//            NSLog(@"传递的参数是：%d和%d",a,b);
//        } increase:8];
//        [person3 startTest];

//3.4 block返回值
        Person4 *person4 = [Person4 new];
        person4.caculateBlock = ^int(int a, int b) {
            return a + b;
        };
        [person4 startTestWithA:100 B:200];
        

    };
    return 0;
}
