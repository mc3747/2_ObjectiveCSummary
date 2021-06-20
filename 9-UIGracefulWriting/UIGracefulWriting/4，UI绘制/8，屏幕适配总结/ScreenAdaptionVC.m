//
//  ScreenAdaptionVC.m
//  WHLatticeDemo
//
//  Created by gjfax on 2019/5/11.
//  Copyright © 2019 remember17. All rights reserved.
//

#import "ScreenAdaptionVC.h"
#import "UIViewController+ContentView.h"

@interface ScreenAdaptionVC ()

@end

@implementation ScreenAdaptionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *redView = [[UIView alloc]initWithFrame:AAdaptionRect(100, 100, 100, 100)];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    UIView *greenView = [[UIView alloc]initWithFrame:AAdaptionRect(300, 100, 100, 100)];
    greenView.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:greenView];
}

/*UI写法：
1，代码简单：复用简单常用的方法
2，代码清晰：懒加载
3，适配（最常用的适配：宽度适配，字体适配，机型适配，图片适配）
 方法1：全局宏，添加比例
 方法2：stack控件
 方法3：masonry或者autolayout，进行自动适配
 方法4：runtime
4，动态布局
    动态显示、隐藏控件
    改变控件，影响整个布局
    OC语言版本MyLayout
   Swift语言版本TangramKit
5，
 */
#pragma mark -


@end
