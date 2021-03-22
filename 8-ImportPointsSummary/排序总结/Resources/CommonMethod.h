//
//  CommonMethod.h
//  排序总结
//
//  Created by gjfax on 2020/3/9.
//  Copyright © 2020 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonMethod : NSObject
#pragma mark -  顶部window
UIWindow *GJSMainWindow(void);

#pragma mark - 顶部控制器
UIViewController *GJSTopMostViewController(void);

//push控制器
void GJSPushViewController (UIViewController *vc,NSString *vcTitle,BOOL animated);

//push控制器名称
void GJSPushViewControllerWithName (NSString *vcName,NSString *vcTitle,BOOL animated);

@end

NS_ASSUME_NONNULL_END
