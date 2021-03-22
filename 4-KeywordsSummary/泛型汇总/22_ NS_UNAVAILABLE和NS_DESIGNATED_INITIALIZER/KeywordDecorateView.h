//
//  KeywordDecorateView.h
//  泛型汇总
//
//  Created by gjfax on 2019/2/21.
//  Copyright © 2019 macheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeywordDecorateView : UIView
/*
 1,NS_DESIGNATED_INITIALIZER宏:
各种初始化方法，均要初始化变量，没有用默认值，一般可作为 designed initializer
父类的NS_DESIGNATED_INITIALIZER方法，子类也有NS_DESIGNATED_INITIALIZER方法，则子类中要调用父类的NS_DESIGNATED_INITIALIZER方法，或者直接将
 
 2，NS_UNAVAILABLE宏：以下四种关键字效果一样
 (instancetype)init NS_UNAVAILABLE; ///< 直接标记 init 方法不可用
 (instancetype) init __unavailable;
 (instancetype) init attribute((unavailable));
 (instancetype) init UNAVAILABLE_ATTRIBUTE;
 
 3，报警告
     UIViewController
     Method override for the designated initializer of the superclass '-initWithNibName:bundle:' not found
     Method override for the designated initializer of the superclass '-initWithCoder:' not found
 
     UIView
     Method override for the designated initializer of the superclass '-initWithFrame:' not found
     Method override for the designated initializer of the superclass '-initWithCoder:' not found

     NSObject
     Method override for the designated initializer of the superclass '-init' not found

 4，如果使用new来创建对象的话，即使init被声明为NS_UNAVAILABLE，也不会收到编译器的警告和错误提示
 
 5,初始化方法
     一、UIView初始化方法调用顺序
 
     1.纯代码创建
     //1.UIView通用初始化方法: 创建继承自UIView的类init时会调用该方法
     - (instancetype)initWithFrame:(CGRect)frame{ }
     //2.UIView通用初始化方法: 显性调用[[Class alloc]init];会来到此方法
     - (instancetype)init{ }
 
 
     2.代码(继承UIView类)+Xib创建
     //1.UIView通用初始化方法: 创建继承自UIView的类init时会调用该方法
     - (instancetype)initWithFrame:(CGRect)frame{}
     //2.UIView通用初始化方法: 显性调用[[Class alloc]init];会来到此方法
     - (instancetype)init{}
 
     //3.UIView特殊初始化方法: 仅用作从Xib加载UIView视图时调用该方法
     - (instancetype)initWithCoder:(NSCoder *)aDecoder{}
 
 
     二、UIViewController初始化方法调用顺序
 
     1.纯代码创建VC
     //1.VC通用的初始化方法: 纯代码创建或者从Xib加载VC时调用该方法
     - (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{}
     //2.VC通用初始化方法: 显性调用[[Class alloc]init];会来到此方法
     - (instancetype)init{}
 
 
     2.代码(继承UIViewController的自定义类)+Xib创建VC
     //1.VC通用的初始化方法: 纯代码创建或者从Xib加载VC时调用该方法
     - (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{}
     //2.VC通用初始化方法: 显性调用[[Class alloc]init];会来到此方法
     - (instancetype)init{}
 
 
     3.代码(继承UIViewController的自定义类)+Storyboard加载VC
     //VC特殊初始化方法: 仅当VC从Storyboard加载时调用该方法（不调用init）
     - (instancetype)initWithCoder:(NSCoder *)aDecoder{}
 
 6，NS_ASSUME_NONNULL_BEGIN宏和NS_ASSUME_NONNULL_END宏
 属性和参数默认为nonnull，加入要nullable，需要指定；
 特殊情况：
 typedef定义的类型的nullability特性通常依赖于上下文，即使是在Audited Regions中，也不能假定它为nonnull。
 复杂的指针类型(如id *)必须显示去指定是non null还是nullable。例如，指定一个指向nullable对象的nonnulla指针，可以使用”__nullable id * __nonnull”。
 我们经常使用的NSError **通常是被假定为一个指向nullable NSError对象的nullable指针。

 */

- (instancetype)init;
- (instancetype)initWithFrame:(CGRect )frame;
- (instancetype)initWithFrame:(CGRect )frame title:(NSString *)title ;
- (instancetype)initWithFrame:(CGRect )frame subTitle:(NSString *)subTitle;

//子类中新的NS_DESIGNATED_INITIALIZER方法
- (instancetype)initWithFrame:(CGRect )frame title:(NSString *)title subTitle:(NSString *)subTitle NS_DESIGNATED_INITIALIZER;

//禁止父类中的init方法
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder ;
@end

NS_ASSUME_NONNULL_END
