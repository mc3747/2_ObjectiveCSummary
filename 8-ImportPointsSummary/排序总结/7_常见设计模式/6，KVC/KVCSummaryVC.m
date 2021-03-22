//
//  KVCSummaryVC.m
//  排序总结
//
//  Created by gjfax on 2020/1/9.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "KVCSummaryVC.h"
#import "KVC_Book.h"
#import "KVC_Person.h"
#import <objc/runtime.h>
#import "Product.h"
#import "CategoryList.h"

// =====================================================
/*
 1，KVC简介：Key-Value Coding，即键值编码。它是一种不通过存取方法，而通过属性名称字符串间接访问属性的机制。
 
 2，KVC原理：允许开发者通过Key名直接访问对象的属性，或者给对象的属性赋值。而不需要调用明确的存取方法。这样就可以在运行时动态地访问和修改对象的属性
 
 3，KVC设值
    设置setValue:forKey时的顺序：
        1，查找setKey:、_setKey: (按顺序查找)
        2，如果没有，查看accessInstanceVariablesDirectly方法
        3，如果2返回yes，会按照 _key、_isKey、key、iskey的顺序查找成员变量
    4，步骤2，3未搜索到对应的key，抛出一个NSUndefinedKeyException的异常，重写- (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key;
 
 4，KVC取值kvc
    valueForKey:
        1，按照 getKey、key、iskey、_key 顺序查找方法
        2，如果没有，查看accessInstanceVariablesDirectly方法
        3，如果2返回yes，会按照_key、_isKey、key、iskey的顺序查找成员变量
        4，步骤2，3未找到报错NSUnkonwKeyException错误
    
 设置私有属性
 设置的属性不存在
 
 */
// =====================================================
@interface KVCSummaryVC ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic)  UIPageControl *pageControl;

@end

@implementation KVCSummaryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTextField];
    [self createScrollView];
    
}
//1，基本属性:基本类型，对象类型，集合类型（NSArray，NSDictionary， NSSet）
- (IBAction)demo1:(id)sender {
    KVC_Person *person = [[KVC_Person alloc] init];
    [person setValue:@100 forKey:@"age"];
    NSLog(@"%@",person);
}

//2,设置私有属性,只读属性
- (IBAction)demo2:(id)sender {
    KVC_Person *person = [[KVC_Person alloc] init];
    NSLog(@"设置前❎%@",person);
//声明私有属性
    [person setValue:@18 forKey:@"heightInt"];
//只读属性
    [person setValue:@"北大" forKey:@"school"];
//类扩展私有属性
    [person setValue:@62.5 forKey:@"weight"];
    NSLog(@"设置后✅%@",person);
}
//3，keypath
/*
 而KVC对于keyPath是搜索机制第一步就是分离
 key，用小数点.来分割key，然后再像普通key一样按照先前介绍的顺序搜索下去。如果没有小数点，就直接向普通key来搜索
 */

- (IBAction)demo3:(id)sender {
    KVC_Book *book = [[KVC_Book alloc] init];
    [book setValue:@"活着" forKey:@"bookName"];
    NSLog(@"%@",book);
    KVC_Person *person = [[KVC_Person alloc] init];
    [person setValue:book forKey:@"book"];
    [person setValue:@"变形金刚" forKeyPath:@"book.bookName"];
    NSLog(@"%@",book);
}

//4，打印私有属性
- (IBAction)demo4:(id)sender {
    unsigned int count = 0;
       Ivar *var = class_copyIvarList([UIPanGestureRecognizer class], &count);
       
       for (int i = 0; i < count; i++) {
           Ivar _var = *(var + i);
           // 打印私有属性名称和属性类型
           NSLog(@"%i:属性类型%s，属性名称%s",i,ivar_getTypeEncoding(_var),ivar_getName(_var));
           
       }
}
//5，打印私有方法
- (IBAction)demo5:(id)sender {
    unsigned int count = 0;
     Method *method = class_copyMethodList([UIPanGestureRecognizer class], &count);
     
     for (int i = 0; i < count; i++) {
         // 打印私有方法名称
         SEL a = method_getName(*(method+i));
         NSString *sn = NSStringFromSelector(a);
         NSLog(@"%i:%@",i,sn);
     }
}
//6，数字属性进行计算
- (IBAction)demo6:(id)sender {
    NSMutableArray *booksArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        KVC_Book *book = [[KVC_Book alloc] init];
        [book setValue:@"活着" forKey:@"bookName"];
        [book setValue:@(i) forKey:@"bookPage"];
        [booksArray addObject:book];
    }
    
    KVC_Person *person = [[KVC_Person alloc] init];
    [person setValue:booksArray forKey:@"books"];
    
    // 计算（确保操作的属性为数字类型，否则运行时刻错误。)  五种集合运算符(个数，最大，最小，平均，求和)
    NSLog(@"count of book price : %@",[person valueForKeyPath:@"books.@count.bookPage"]);
    NSLog(@"min of book price : %@",[person valueForKeyPath:@"books.@min.bookPage"]);
    NSLog(@"avg of book price : %@",[person valueForKeyPath:@"books.@max.bookPage"]);
    NSLog(@"sum of book price : %@",[person valueForKeyPath:@"books.@sum.bookPage"]);
    NSLog(@"avg of book price : %@",[person valueForKeyPath:@"books.@avg.bookPage"]);
    
}
//7，字典转模型
- (IBAction)demo7:(id)sender {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"product" ofType:@"json"];
      NSData *data = [NSData dataWithContentsOfFile:path];
      NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
      NSLog(@"%@",dict);
      NSDictionary *dataDict = dict[@"product"];
      Product *p = [[Product alloc] initWithDictionary:dataDict];
    
      NSLog(@"%@ == %@",p.name,p.categoryList);
      for (CategoryList *list in p.categoryList) {
          NSLog(@"%@ == %@ == %@ == %.2f", list.name, list.image, list.productId, list.price);
      }
}
//8，修改属性
- (IBAction)demo8:(id)sender {
    
}
- (IBAction)demo9:(id)sender {
}
- (IBAction)demo10:(id)sender {
}


- (void)createTextField
{
    // 在iOS6.0之前，可以通过KVC来设置_placeholderLabel的属性值
//    [_textField setValue:[UIColor redColor]
//              forKeyPath:@"_placeholderLabel.textColor"];
//    [_textField setValue:[UIFont systemFontOfSize:14]
//              forKeyPath:@"_placeholderLabel.font"];
    
    // iOS 6.0之后提供的attributedPlaceholder属性
        NSString *holderText = @"输入密码";
        NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
        [placeholder addAttribute:NSForegroundColorAttributeName
                            value:[UIColor redColor]
                            range:NSMakeRange(0, holderText.length)];
    
        [placeholder addAttribute:NSFontAttributeName
                            value:[UIFont boldSystemFontOfSize:16]
                            range:NSMakeRange(0, holderText.length)];
        _textField.attributedPlaceholder = placeholder;
    
}

- (void)createScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, 100)];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(3*self.view.bounds.size.width, 200);
    [self.view addSubview:scrollView];
    
    NSArray *colors = @[UIColor.blueColor, UIColor.blackColor,UIColor.brownColor];
    for (int i = 0; i < colors.count; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(i*self.view.bounds.size.width, 0, self.view.bounds.size.width, 200)];
        view.backgroundColor = colors[i];
        [scrollView addSubview:view];
    }
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-50, 100, 100, 10)];
    _pageControl.numberOfPages = colors.count;
    _pageControl.currentPage = 0;
    [self.view addSubview:_pageControl];
    
    [_pageControl setValue:[UIImage imageNamed:@"selected"]
                forKey:@"_currentPageImage"];
    [_pageControl setValue:[UIImage imageNamed:@"unselected"]
                forKey:@"_pageImage"];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int currentPage = scrollView.contentOffset.x / self.view.bounds.size.width;
    _pageControl.currentPage = currentPage;
}

@end
