//
//  LNChangeAttributesVC.m
//  排序总结
//
//  Created by gjfax on 2019/5/7.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "LNChangeAttributesVC.h"
#import "MCPerson.h"
#import <objc/runtime.h>

@interface LNChangeAttributesVC ()
@property (nonatomic, strong) MCPerson *person;
@end

@implementation LNChangeAttributesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.person = [[MCPerson alloc] init];
    _person.age = 17;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    unsigned int count = 0;
    Ivar *ivar = class_copyIvarList([self.person class], &count);
    for (int i = 0; i<count; i++) {
        Ivar var = ivar[i];
        const char *varName = ivar_getName(var);
        NSString *proname = [NSString stringWithUTF8String:varName];
        
        if ([proname isEqualToString:@"_age"]) {   //这里别忘了给属性加下划线
            object_setIvar(self.person, var, @100);
            break;
        }
    }
    NSLog(@"XiaoMing change name  is %i",self.person.age);
}

@end
