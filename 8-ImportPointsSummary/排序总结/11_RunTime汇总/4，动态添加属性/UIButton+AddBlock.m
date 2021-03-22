//
//  UIButton+AddBlock.m
//  排序总结
//
//  Created by gjfax on 2020/3/16.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "UIButton+AddBlock.h"

#import <objc/runtime.h>
static const char btnKey;

@implementation UIButton (AddBlock)

- (void)handelWithBlock:(btnBlock)block {

    if (block) {

//        方法(1)静态变量&btnKey
        objc_setAssociatedObject(self,&btnKey , block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//        方法(2)@selector(methodName)
//        objc_setAssociatedObject(self,@selector(btnAction:) , block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//        方法(3)_cmd
//         objc_setAssociatedObject(self,_cmd , block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    [self addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)btnAction:(id)sender
{
//        方法(1)静态变量&btnKey
    btnBlock block = objc_getAssociatedObject(self,&btnKey);
    
//        方法(2)@selector(methodName)
//    btnBlock block = objc_getAssociatedObject(self,@selector(btnAction:));
    
//        方法(3)_cmd
//    btnBlock block = objc_getAssociatedObject(self,_cmd);
    
    if (block) {
        block(sender);
    }
}

@end
