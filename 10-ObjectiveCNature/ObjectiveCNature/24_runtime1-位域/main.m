//
//  main.m
//  24_runtime1-位域
//
//  Created by kk on 2021/5/26.
//

#import <Foundation/Foundation.h>
#import "MJPerson.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        MJPerson *person = [[MJPerson alloc] init];
        person.tall = NO;
        person.rich = YES;
        person.handsome = NO;
        
        NSLog(@"tall:%d rich:%d hansome:%d", person.isTall, person.isRich, person.isHandsome);
    }
    return 0;
}
