//
//  main.m
//  24_runtime1-位域
//
//  Created by kk on 2021/5/26.
//

#import <Foundation/Foundation.h>
#import "MJPerson1.h"
#import "MJPerson2.h"
#import "MJPerson3.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        
        MJPerson1 *person = [[MJPerson1 alloc] init];
        person.tall = NO;
        person.rich = YES;
        person.handsome = NO;
        
        NSLog(@"tall:%d rich:%d hansome:%d", person.isTall, person.isRich, person.isHandsome);
        
        MJPerson2 *person2 = [[MJPerson2 alloc] init];
        person2.tall = NO;
        person2.rich = YES;
        person2.handsome = NO;
        
        NSLog(@"tall:%d rich:%d hansome:%d", person2.isTall, person2.isRich, person2.isHandsome);
        
//        isa指针使用的
        MJPerson3 *person3 = [[MJPerson3 alloc] init];
        person3.tall = NO;
        person3.rich = YES;
        person3.handsome = NO;
        
        NSLog(@"tall:%d rich:%d hansome:%d", person3.isTall, person3.isRich, person3.isHandsome);
    }
    return 0;
}
