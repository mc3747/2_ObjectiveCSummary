//
//  ViewController.m
//  KVO演示
//
//  Created by zuoA on 16/4/27.
//  Copyright © 2016年 Azuo. All rights reserved.
//

#import "BaseKVOViewController.h"
#import "myKVO.h"

@interface BaseKVOViewController ()

@property (nonatomic, weak)UILabel *label;
@property (nonatomic, weak) UIButton *button;
@property (nonatomic,strong)myKVO *myKVO;

@end

@implementation BaseKVOViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    RandomBackgroundColor;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20,100, 300, 30)];
    label.backgroundColor = RandColor;
    [self.view addSubview:label];
    _label = label;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 150, 100, 30)];
    [button setTitle:@"点击增加" forState:UIControlStateNormal];
    [button setBackgroundColor:RandColor];
    [button addTarget:self action:@selector(changeNum:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    _button = button;
    
    self.myKVO = [[myKVO alloc]init];
    
    /**
       *  1.注册对象myKVO为被观察者:
       *
       *  @param observer 观察者
       *  @param keyPath  被观察的属性名称
       *  @param options  观察属性的新值、旧值等的一些配置（枚举值，可以根据需要设置，例如这里可以使用两项）
       *  @param context  上下文，可以为nil。
      */
    /**
     *
          提供属性的新值
         NSKeyValueObservingOptionNew = 0x01,
          提供属性的旧值
         NSKeyValueObservingOptionOld = 0x02,
     
          如果指定，则在添加观察者的时候立即发送一个通知给观察者，
          并且是在注册观察者方法返回之前
         NSKeyValueObservingOptionInitial = 0x04,
     
          如果指定，则在每次修改属性时，会在修改通知被发送之前预先发送一条通知给观察者，
          这与-willChangeValueForKey:被触发的时间是相对应的。
          这样，在每次修改属性时，实际上是会发送两条通知。
         NSKeyValueObservingOptionPrior = 0x08
     *
     */
    [self.myKVO addObserver:self forKeyPath:@"num" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    
}

/* 2.只要object的keyPath属性发生变化，就会调用此回调方法，进行相应的处理：UI更新：*/
/**
*  KVO回调方法
*
*  @param keyPath 被修改的属性
*  @param object  被修改的属性所属对象
*  @param change  属性改变情况（新旧值）
*  @param context context传过来的值
*/
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if([keyPath isEqualToString:@"num"] && object == self.myKVO)
    {
        // 响应变化处理：UI更新（label文本改变）
        self.label.text = [NSString stringWithFormat:@"当前的num值为：%@",[change valueForKey:@"new"]];
        
        //上文注册时，枚举为2个，因此可以提取change字典中的新、旧值的这两个方法
        NSLog(@"\noldnum:%@ newnum:%@",[change valueForKey:@"old"],[change valueForKey:@"new"]);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    /* 3.移除KVO */ 
    [self removeObserver:self forKeyPath:@"num" context:nil];
}

//按钮事件
- (void)changeNum:(UIButton *)sender {
    //按一次，使num的值+1
    self.myKVO.num = self.myKVO.num + 1;
}

@end
