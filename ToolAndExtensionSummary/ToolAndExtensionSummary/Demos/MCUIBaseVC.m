//
//  MCUIBaseVC.m
//  IOS_KnowledgePoints
//
//  Created by gjfax on 2017/12/27.
//  Copyright © 2017年 macheng. All rights reserved.
//

 /*tabBar底部标签1 */

#import "MCUIBaseVC.h"

@interface MCUIBaseVC ()

@end

@implementation MCUIBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleNames = @[].mutableCopy;
    self.titleImageNames = @[].mutableCopy;
    self.classNames =  @[].mutableCopy;
    [self addTitle:@"1_Masonry框架使用" titleImage:@"basicBase_foundation_23x23" class:@"RootVC"];
 
}

- (void)addTitle:(NSString *)title titleImage:(NSString *)titleImage class:(NSString *)className {
    
    [self.titleNames addObject:title];
    [self.titleImageNames addObject:titleImage];
    [self.classNames addObject:className];
}



@end
