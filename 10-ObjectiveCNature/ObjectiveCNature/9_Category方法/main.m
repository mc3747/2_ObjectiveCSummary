//
//  main.m
//  9_Category方法
//
//  Created by kk on 2021/5/15.
//

#import <Foundation/Foundation.h>
#pragma mark - 父类
@interface Father:NSObject
+(void)test;
@end
@implementation Father
+(void)test{
    NSLog(@"father ---test");
}
@end
#pragma mark - 子类
@interface Son:Father
+(void)test;
@end
@implementation Son
+(void)test{
    NSLog(@"son ---test");
}
@end
#pragma mark - 分类
@interface Son (category)
+(void)test;
@end
@implementation Son (category)
+(void)test{
    NSLog(@"category ---test");
}
@end



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        [Son test];
    }
    return 0;
}
