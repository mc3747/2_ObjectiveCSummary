//
//  main.m
//  17_Block中__block的作用分析
//
//  Created by kk on 2021/5/19.
//

#import <Foundation/Foundation.h>
typedef void (^MJBlock) (void);

struct __Block_byref_age_0 {
    void *__isa;
    struct __Block_byref_age_0 *__forwarding;
    int __flags;
    int __size;
    int age;
};

struct __main_block_desc_0 {
    size_t reserved;
    size_t Block_size;
    void (*copy)(void);
    void (*dispose)(void);
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
    struct __Block_byref_age_0 *age;
};

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        int no = 20;
        
        __block int age = 10;
        NSLog(@"%p",&age);
        
//        NSObject *object = [[NSObject alloc] init];
//        __weak NSObject *weakObject = object;
        
        MJBlock block = ^{
            NSLog(@"%p",&age);
            age = 20;
            NSLog(@"%p",&age);
//            NSLog(@"%d", no);
            NSLog(@"%d", age);
//            NSLog(@"%p", weakObject);
        };
        
        struct __main_block_impl_0* blockImpl = (__bridge struct __main_block_impl_0*)block;
        
        block();
    }
    return 0;
}
