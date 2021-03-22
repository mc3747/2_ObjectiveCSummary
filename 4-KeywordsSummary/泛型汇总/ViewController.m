//
//  ViewController.m
//  泛型汇总
//
//  Created by gjfax on 2018/6/5.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "ViewController.h"
#import "Language.h"
#import "Person.h"
#import "Animal.h"
#import "Zoo.h"
#import "Goods.h"
#import "Color.h"
#import "NullFamily.h"
#import "DescriptionManager.h"

@interface ViewController ()
//正常的数组
@property (nonatomic, strong) NSMutableArray *dataArray1;

//泛型的数组
@property (nonatomic, strong) NSMutableArray<NSString *> *dataArray2;

//正常的字典
@property (nonatomic, strong) NSMutableDictionary *dataDic1;

//泛型的字典
@property (nonatomic, strong) NSMutableDictionary<NSString *,NSString *> *dataDic2;

@property (weak, nonatomic) IBOutlet UIButton *testBtn1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_testBtn1 addTarget:self action:@selector(test1) forControlEvents:UIControlEventTouchUpInside];
}

- (void)test1 {
    [DescriptionManager test];
}

#pragma mark -  数组的泛型
- (void)arrayGenericity {
    [self.dataArray1 addObject:@3];//id类型
    [self.dataArray2 addObject:@"3"];
}

#pragma mark -  字典的泛型
- (void)dicGenericity {
    [self.dataDic1 setObject:@22 forKey:@3];
    [self.dataDic2 setObject:@"22" forKey:@"name"];
    [self.dataDic1 objectForKey:@3];
    [self.dataDic2 objectForKey:@"name"];
}

#pragma mark -  对象自定义泛型(通配符)
- (void)instanceGenericity {
    
    // iOS
    Person<IOS *> *iOSP = [[Person alloc] init];
    [iOSP setLanguage:[[IOS alloc] init]];
    
    // Java
    Person<JAVA *> *javaP = [[Person alloc] init];
    [javaP setLanguage:[[JAVA alloc] init]];
    
    // person1
    Person<NSNumber *>*person1 = [[Person alloc] init];
    [person1 setLanguage:@2];
    
    // person2
    Person<NSString *>*person2 = [[Person alloc] init];
    [person2 setLanguage:@"2"];
    
}

#pragma mark -  泛型的协变和逆变性
//__covariant - 协变性，子类型可以强转到父类型（里氏替换原则）
- (void)covariantGenericity {
    
    Zoo1<Animal *> *animal = [Zoo1 new];
    
    Zoo1<Dog *> *dog = [Zoo1 new];
    
     animal = dog;
    
}

//__contravariant - 逆变性，父类型可以强转到子类型
- (void)contravariantGenericity {
    
    Zoo2<Animal *> *animal = [Zoo2 new];
    
    Zoo2<Dog *> *dog = [Zoo2 new];
    
    dog = animal;
}


#pragma mark -  kind of
//1，常用在方法的参数和返回值
//2，加__kindof修饰后，本类及其子类返回都不会报警
//@property(nonnull,strong,nonatomic)NSMutableArray<__kindof UIView *> * viewArray;
- (void)testKindOf {
    Color *color = [Color new];
    Red *red = [Red new];
    
   color = [Goods getColor2];
   red = [Goods getColor2];
    
}

#pragma mark -  nullable，nonnull，null_resettable，null_unspecified
- (void)testNullFamily {
    NullFamily *nullFamily = [NullFamily new];
    nullFamily.number = nil;
    NSLog(@"%@",nullFamily.number);
}


@end
