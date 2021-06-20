//
//  main.m
//  7_+load方法
//
//  Created by kk on 2021/5/14.
//

#import <Foundation/Foundation.h>
#pragma mark - 父类
@interface Father:NSObject
+(void)load;
@end
@implementation Father
+(void)load{
    NSLog(@"father ---load");
}
@end
#pragma mark - 子类
@interface Son:Father
+(void)load;
@end
@implementation Son
+(void)load{
    NSLog(@"son ---load");
}
@end
#pragma mark - 分类
@interface Son (category)
+(void)load;
@end
@implementation Son (category)
+(void)load{
    NSLog(@"category ---load");
}
@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        [Son alloc];
//        [Son load];
    }
    return 0;
}
