//
//  main.m
//  8_+initialize方法
//
//  Created by kk on 2021/5/14.
//

#import <Foundation/Foundation.h>
#pragma mark - 父类
@interface Father:NSObject
+(void)initialize;
@end
@implementation Father
+(void)initialize{
    NSLog(@"father ---initialize");
}
@end
#pragma mark - 子类
@interface Son:Father
+(void)initialize;
@end
@implementation Son
//+(void)initialize{
//    NSLog(@"son ---initialize");
//}
@end
#pragma mark - 分类
@interface Son (category)
+(void)initialize;
@end
@implementation Son (category)
+(void)initialize{
    NSLog(@"category ---initialize");
}
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        [Son alloc];
        [Son alloc];
//        [Son initialize];
        
    }
    return 0;
}
