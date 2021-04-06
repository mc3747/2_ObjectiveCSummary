//
//  DynamicChangeIconVCViewController.m
//  UIGracefulWriting
//
//  Created by kk on 2021/4/6.
//  Copyright © 2021 macheng. All rights reserved.
//

#import "DynamicChangeIconVC.h"
#import "FSAppIconManager/FSAppIconManager.h"
/*
 参考文章：
 OC版本：https://blog.zhangpeng.site/ios/dynamic-icon.html#%E5%87%86%E5%A4%87%E4%BD%A0%E8%A6%81%E6%9B%B4%E6%8D%A2%E7%9A%84%E5%9B%BE%E6%A0%87
 swift版本：https://juejin.cn/post/6844903901674782728#heading-0
        swift版的仓库：https://github.com/CoderTitan/ChangeIcon
 配置info.plist,直接将Icon files(iOS 5)的key和value添加进去
 
 
 */
@interface DynamicChangeIconVC ()
@property(assign,nonatomic)BOOL isChange;
@end

@implementation DynamicChangeIconVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *name = [FSAppIconManager getCurrentAppIconName];
    NSLog(@"name: %@", name);
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 300, 200)];
    [button setTitle:@"更换app图标" forState: UIControlStateNormal];
    [button setTitleColor:UIColor.redColor forState:normal];
    [button addTarget:self action:@selector(changeAppIcon:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
//需要提示用户更换appiCon
-(void)changeAppIcon:(id)sender {
    _isChange = !_isChange;
    NSString *icon = _isChange ?@"male":@"female";
    BOOL canChangeAppIcon = [FSAppIconManager canChangeAppIcon];
    NSLog(@"canChangeAppIcon value: %@", canChangeAppIcon?@"YES":@"NO");
    if (!canChangeAppIcon) {
        return;
    }
    [FSAppIconManager changeAppIconWithIconName:icon completionHandler:^(NSError * _Nullable error) {
        NSLog(@"error: %@", error);
    }];
}
//使用runtime去掉弹框,给UIViewController添加了一个分类

@end
