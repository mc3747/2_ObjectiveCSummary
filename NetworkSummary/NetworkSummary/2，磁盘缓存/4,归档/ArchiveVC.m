//
//  ArchiveVC.m
//  NetworkSummary
//
//  Created by gjfax on 2018/11/15.
//  Copyright © 2018 macheng. All rights reserved.
//

#import "ArchiveVC.h"
#import "Person.h"
#import "YYPerson.h"
#import "Foo.h"
#import "NSObject+WZXArchiver.h"

@interface ArchiveVC ()

@end

@implementation ArchiveVC
// =====================================================
/*
  归档（序列化），把对象转为字节码，以文件的形式存储到磁盘上；程序运行过程中或者当再次打开程序的时候，可以通过解归档（反序列化）还原这些对象。只要遵循了NSCoding协议的对象都可以通过它实现序列化，由于绝大多数支持存储数据的Foundation和Cocoa Touch类都遵循了NSCoding协议，因此，对于大多数类来说，归档相对而言还是比较容易实现的。
 */
// =====================================================
- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self singleData];
    //    [self moreData];
    [self selfDefinedData];
    //    [self bigData];
    
    [self inheritPackage];
    
    [self categoryPackage];
}

#pragma mark -  一般写法
// 1，单个数据的归档和解档
- (void)singleData {
    
    // document文件夹路径
    NSString *documentPath =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    // 拼接路径为归档文件目录
    NSString *filePath = [documentPath stringByAppendingString:@"/File.archiver"];
    // 创建一个字典
    NSDictionary *archiveDic = @{@"name":@"jack"};
    // 归档
    //调用NSKeyedArchiver的类方法archiveRootObject:toFile:将对象归档（返回一个布尔值）
    if([NSKeyedArchiver archiveRootObject:archiveDic toFile:filePath]){
        NSLog(@"归档成功!");
    }
    
    // 解档
    //调用NSKeyedUnarchiver的类方法unarchiveObjectWithFile:将文件解档
    NSDictionary *unarchiveDic = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"%@", unarchiveDic);
}

// 2，多个数据的归档和解档
- (void)moreData {
    // document文件夹路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //拼接路径为归档文件目录
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"/MoreFile.archiver"];
    // 归档
    //创建一个MutableData对象用于存放需要归档的数据
    NSMutableData *archiveData = [NSMutableData data];
    //创建一个NSKeyedArchiver类的对象archiver，用来对归档对象进行编码，编码完成才能进行归档
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:archiveData];
    [archiver encodeObject:@"jack" forKey:@"name"];
    [archiver encodeInt:20 forKey:@"age"];
    [archiver encodeFloat:72.5 forKey:@"weight"];
    //完成编码
    [archiver finishEncoding];
    //将archiveData对象写入文件，完成归档
    if ([archiveData writeToFile:filePath atomically:YES]) {
        NSLog(@"archive success!");
    }
    
    // 解档
    //创建NSData对象来接收解档文件
    NSData *unarchiveData = [NSData dataWithContentsOfFile:filePath];
    //创建一个NSKeyedUnarchiver对象unarchiver，用来对需要解档的对象进行解码，解码后就能还原原对象的数据类型
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:unarchiveData];
    NSString *name = [unarchiver decodeObjectForKey:@"name"];
    int age = [unarchiver decodeIntForKey:@"age"];
    float weight = [unarchiver decodeFloatForKey:@"weight"];
    NSLog(@"name = %@, age = %d, weight = %.2f", name, age, weight);
    NSLog(@"%@",unarchiveData);
}

// 3，自定义对象的归档和解档
- (void)selfDefinedData {
    // 获取沙盒路径
    NSString *sandboxPath = NSHomeDirectory();
    NSLog(@"沙盒路径：%@",sandboxPath);
    //获得沙盒document路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //获取文件路径，由于归档后文件会加密，所以文件后缀可以任意取
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"/SelfDefinedFile.archiver"];
    //自定义对象
    Person *person = [[Person alloc] init];
    person.name = @"jack";
    person.gender = @"male";
    person.age = 20;
    //归档
    if ([NSKeyedArchiver archiveRootObject:person toFile:filePath]) {
        NSLog(@"archive success!");
    }
    //解档，person2实例接收解档后的对象
    Person *person2 = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"%@",person2);
    NSLog(@"name = %@, gender = %@, age = %d", person2.name, person2.gender, person2.age);
}

//4,大文件
- (void)bigData {
    //获得沙盒路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //获取文件路径，由于归档后文件会加密，所以文件后缀可以任意取
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"/UserBehavior.data"];
    NSLog(@"%@",[NSKeyedUnarchiver unarchiveObjectWithFile:filePath]);
}

#pragma mark -  继承封装
-(void)inheritPackage{
    YYPerson *person = [[YYPerson alloc] init];
    person.name = @"lishi";
    person.age = @"20";
    [YYPerson setPerosnM:person];
    
    YYPerson *getPerson = [YYPerson getPersonM];
    NSLog(@"personAge == %@, name = %@",getPerson.name,getPerson.age);
}
#pragma mark -  分类封装
-(void)categoryPackage{
    Foo *foo = [Foo new];
    
    foo.str = @"str";
    
    NSMutableString *muStr = [NSMutableString stringWithString:foo.str];
    foo.muStr = muStr;
    
    foo.dic = @{@"key":@"value"};
    
    NSMutableDictionary *muDic = [NSMutableDictionary dictionaryWithDictionary:foo.dic];
    foo.muDic = muDic;
    
    foo.arr = @[@"arr1",@"arr2"];
    
    NSMutableArray *muArr = [NSMutableArray arrayWithArray:foo.arr];
    foo.muArr = muArr;
    
    foo.data = [foo.str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableData *muData = [NSMutableData dataWithData:foo.data];
    foo.muData = muData;
    
    foo.set = [NSSet setWithObjects:@"1",@"2",@"3",nil];
    
    NSMutableSet *muSet = [NSMutableSet setWithSet:foo.set];
    foo.muSet = muSet;
    
    foo.w_float = 1.1;
    foo.w_doule = 2.2;
    foo.w_cgfloat = 3.3;
    foo.w_int = 4;
    foo.w_integer = 5;
    foo.w_uinteger = 6;
    foo.w_bool = YES;
    
    Bar *bar = [Bar new];
    bar.name = @"wzx";
    bar.age = 23;
    
    foo.bar = bar;
    
    BOOL isHave = [foo wzx_archiveToName:@"foo"];
    NSAssert(isHave = YES, @"归档失败");
    
    Foo *foo2 = [Foo wzx_unArchiveToName:@"foo"];
}
@end
