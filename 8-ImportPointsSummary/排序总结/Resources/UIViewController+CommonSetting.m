//
//  UIViiewController+CommonSetting.m
//  排序总结
//
//  Created by gjfax on 2020/3/9.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "UIViewController+CommonSetting.h"

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
typedef void (* _VIMP)(id, SEL, ...);

@implementation UIViewController (CommonSetting)

+ (void)showAlertWithTitle: (NSString *)title message: (NSString *)message actionTitles: (NSArray<NSString *> *)actions cancelTitle: (NSString *)cancelTitle style: (UIAlertControllerStyle)style completion: (void(^)(NSInteger index))completion {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    for (NSInteger index = 0; index < actions.count; index++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:actions[index] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            !completion ?  : completion(index);
        }];
        [alert addAction:action];
    }
    if (cancelTitle.length) {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancel];
    }
    UIViewController *vc = [[UIApplication sharedApplication] keyWindow].rootViewController;
    [vc presentViewController:alert animated:YES completion:nil];
}

//利用runtime对UIController做一些全局设置
+ (void)load {
    [self changeBackgroundColor];
    
    [self printClassName];
}
//统一改变背景颜色
+(void)changeBackgroundColor{
     static dispatch_once_t onceToken;
       dispatch_once(&onceToken, ^{
           Method originalMethod = class_getInstanceMethod(self, @selector(viewDidLoad));
           Method swizzledMethod = class_getInstanceMethod(self, @selector(ghh_viewDidLoad));
           method_exchangeImplementations(originalMethod, swizzledMethod);
       });
       
}

- (void) ghh_viewDidLoad {
  // 全局样式
       [self ghh_viewDidLoad];
   
        //  UIInputWindowController 会覆盖每一个控制器，避免为其设置颜色
        Class class1 = NSClassFromString(@"UIInputWindowController");
        Class class2 = NSClassFromString(@"UIEditingOverlayViewController");
        if ((self.class != class1) && (self.class != class2)) {
                   self.view.backgroundColor = RGBColor(255, 238, 248);
               }

}

//统一打印类名
+(void)printClassName{
    static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{

            // get system viewDidLoad method
            Method viewDidLoad = class_getInstanceMethod(self, @selector(viewDidLoad));

            // get the system implementation of viewDidLoad
            _VIMP viewDidLoad_VIMP = (_VIMP)method_getImplementation(viewDidLoad);

            // resetter the  system implementation of viewDidLoad
            method_setImplementation(viewDidLoad, imp_implementationWithBlock(^ (id target , SEL action){

                // the system viewDidLoad method
                viewDidLoad_VIMP(target , @selector(viewDidLoad));


                // the new add NSLog method
                NSLog(@"自定义log打印控制器名称 :%@ did load",target);
            }));


        });

}

@end
