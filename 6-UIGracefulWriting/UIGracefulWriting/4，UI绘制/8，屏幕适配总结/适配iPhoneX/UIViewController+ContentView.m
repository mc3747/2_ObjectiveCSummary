//
//  UIViewController+ContentView.m
//  WHLatticeDemo
//
//  Created by gjfax on 2019/5/11.
//  Copyright © 2019 remember17. All rights reserved.
//

#import "UIViewController+ContentView.h"
#import <objc/runtime.h>


static const void *ContentView = &ContentView;

@implementation UIViewController (ContentView)
//用runtime重写setter，getter方法，来给分类添加属性
- (void)setContentView:(UIView *)contentView {
    /*
     OBJC_ASSOCIATION_ASSIGN;            //assign策略
     OBJC_ASSOCIATION_COPY_NONATOMIC;    //copy策略
     OBJC_ASSOCIATION_RETAIN_NONATOMIC;  // retain策略
     
     OBJC_ASSOCIATION_RETAIN;
     OBJC_ASSOCIATION_COPY;
     */
    /*
     * id object 给哪个对象的属性赋值
     const void *key 属性对应的key
     id value  设置属性值为value
     objc_AssociationPolicy policy  使用的策略，是一个枚举值，和copy，retain，assign是一样的，手机开发一般都选择NONATOMIC
     objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy);
     */
    objc_setAssociatedObject(self, ContentView, contentView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**
 contentView用来作为根视图代替self.view
 注意：本项目是用的系统的导航栏，假如用的自定义的导航栏，
 请在宏定义里改掉相应的导航栏高度和tabbar高度。
 有一个缺点：当你由于需要，隐藏了导航栏，这儿检测不到，因为初始化Vc的时候先走这个方法
 这个时候建议在相应vc中做坐标处理
 */
- (UIView *)contentView {
    //利用runtime实现动态添加属性
    UIView *view = objc_getAssociatedObject(self, ContentView);
    //因为当界面上只有tableview控件时，在iOS7以上，iOS11以下系统，坐标零点都是从导航栏开始
    //设置这个属性能够避免系统bug
    self.automaticallyAdjustsScrollViewInsets = NO;
    //判断vc是否为栈内第一个页面，来设置contenview的高度
    //这儿默认每个页面都有导航栏，如果是自定义导航栏，只需要在self.view上添加即可，不会与contentView冲突
    if (!view) {
        if (self.navigationController.viewControllers.count > 1 ||self.navigationController.viewControllers.count == 0) {
            view = [[UIView alloc]initWithFrame:CGRectMake(0, NavH, kwidth, kheight-NavH)];
        }else{
            view = [[UIView alloc]initWithFrame:CGRectMake(0, NavH, kwidth, kheight-NavH-TabBarH)];
        }
        view.backgroundColor = [UIColor clearColor];
        self.contentView = view;
        //让应用在ipad以滚动视图的方式正常显示，显示内容宽高和iphone5一样，这是为了苹果审核，要求iPad正常显示
        if (kheight == 480) {
            UIScrollView *scorollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
            scorollView.contentSize = CGSizeMake(kwidth, 568);
            view.frame = CGRectMake(0, 0, kwidth, 568);
            [self.view addSubview:scorollView];
            [scorollView addSubview:view];
        }else{
            [self.view addSubview:view];
        }
    }
    return view;
}
@end
