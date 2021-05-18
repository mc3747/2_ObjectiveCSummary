//
//  main.m
//  11_Block的本质
//
//  Created by kk on 2021/5/17.
//

#import <Foundation/Foundation.h>
struct __main_block_desc_0 {
    size_t reserved;
    size_t Block_size;
};

struct __block_impl {
    void *isa;
    int Flags;
    int Reserved;
    void *FuncPtr;
};

struct __main_block_impl_0 {
    struct __block_impl impl;
    struct __main_block_desc_0* Desc;
    int age;
};

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        int age = 20;
        
        void (^block)(int, int) =  ^(int a , int b){
            NSLog(@"this is a block! -- %d", age);

        };
        block(10, 10);
        
        
        struct __main_block_impl_0 *blockStruct = (__bridge struct __main_block_impl_0 *)block;
        
        
    }
    return 0;
}
