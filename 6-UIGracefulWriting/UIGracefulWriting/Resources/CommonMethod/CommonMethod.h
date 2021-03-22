//
//  CommonMethod.h
//  UIGracefulWriting
//
//  Created by gjfax on 2018/9/21.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonMethod : NSObject
#pragma mark -- 返回特定页面处理
//返回当前导航控制器的倒数几个VC：当前的count传0，前一个VC传1
+ (void)backToSpecificVC:(UINavigationController *)navi SpecificCount:(NSInteger)count fail:(void (^)(void))fail;

//返回当前导航控制器的顺数几个VC，根控制器count传0，第一个传1
+ (void)backToSpecificVCWithOrder:(UINavigationController *)navi SpecificCount:(NSInteger)count fail:(void (^)(void))fail;

//返回当前导航控制器中的特定名称的VC
+ (void)backToSpecificVCWithOrder:(UINavigationController *)navi SpecificName:(NSString*)name fail:(void(^)(void))fail;

// 如果栈上有指定的控制器 返回root， 否则返回上一层（很特殊）
+ (void)backToRootVCWithStack:(UINavigationController *)navi SpecificName:(NSString*)name dismissVC:(BOOL)dissmiss;

//当前导航控制器是否有指定控制器
+ (BOOL)haveSpecialVCWithStack:(UINavigationController *)navi SpecificName:(NSString *)vc;

//可以任意地方调用这个push，不需要跑回基类VC调用self.navigationController这么麻烦
    //  使用控制器vc
void GJSPushViewController (UIViewController *vc,BOOL animated);
    //  使用控制器vc的标题
void GJSPushViewControllerWithName (NSString *vcName,BOOL animated);

//present，同上
void GJSPresentViewController (UIViewController *vc,BOOL animated);

//从底部push
void GJSBottomPushViewController (UIViewController *vc);

//获取最外层的window，不一定是keywindow
UIWindow *GJSMainWindow(void);

//当前最高一级VC
UIViewController *GJSTopMostViewController(void);


@end

NS_ASSUME_NONNULL_END
