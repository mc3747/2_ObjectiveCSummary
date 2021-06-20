//
//  main.m
//  25_runtime2-位运算
//
//  Created by kk on 2021/5/26.
//

#import <Foundation/Foundation.h>
#import "MJPerson.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        MJPerson *person = [MJPerson new];
        person.options = MJOptionsOne | MJOptionsThree;
        
    }
    return 0;
}

