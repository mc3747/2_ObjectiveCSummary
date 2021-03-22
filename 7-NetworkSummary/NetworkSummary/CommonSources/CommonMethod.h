//
//  CommonMethod.h
//  NetworkSummary
//
//  Created by gjfax on 2019/4/29.
//  Copyright © 2019 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonMethod : NSObject

+ (void)showTextViewAlert:(NSString *)msg;

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
