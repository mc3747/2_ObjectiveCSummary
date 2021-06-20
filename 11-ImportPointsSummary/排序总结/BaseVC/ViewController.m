//
//  ViewController.m
//  排序总结
//
//  Created by gjfax on 2018/5/9.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "ViewController.h"
#import "ParameterManager.h"
#import "ParameterClass.h"
#import "ReturnValueManager.h"
#import "PassValueVC.h"
#import "CallMethodViewController.h"
#import <objc/runtime.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *logDisplayButton;
@property (weak, nonatomic) IBOutlet UIButton *logHiddenButton;
@property (weak, nonatomic) IBOutlet UIButton *logClearButton;

@property (nonatomic, strong) NSArray *cellDisplayNameArray;
@property (nonatomic, strong) NSArray *cellControllerNameArray;
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"重要知识";
    [self initArrays];
    [self initTableView];
    [self.logDisplayButton addTarget:self action:@selector(logDisplay) forControlEvents:UIControlEventTouchUpInside];
    [self.logHiddenButton addTarget:self action:@selector(logHidden) forControlEvents:UIControlEventTouchUpInside];
    [self.logClearButton addTarget:self action:@selector(logClear) forControlEvents:UIControlEventTouchUpInside];

}
- (void)logDisplay {
    
    [[HAMLogOutputWindow sharedInstance] setHidden:NO];
}

- (void)logHidden {
     [[HAMLogOutputWindow sharedInstance] setHidden:YES];
}

- (void)logClear {
    MCLogClear;
}

#pragma mark -  初始化
- (void)initArrays {
    
    
    self.cellDisplayNameArray = @[@"1，方法的调用相关",@"2，button传递多个参数",@"3，控制器传值",
                                  @"4, 预编译&枚举总结" ,@"5，定时器汇总",@"6，单元测试",@"7.1，单例模式",@"7.2.1，简单代理",@"7.2.2，协议代理",@"7.2.3，多代理",@"7.3，KVO总结",@"7.4，通知模式",@"7.5，block总结",@"7.6，KVC总结",@"7.7，24种设计模式汇总",@"8.1，匹配的三种方式",@"8.2，正则表达式的使用场景",@"9，app架构",@"10，app组件化",@"11，RunTime总结",@"12，对象的初始化方法",@"13，字典转模型",@"14，RunLoop汇总",@"15，性能优化",@"16，加密汇总",@"17，音频汇总",@"18，文件大小及图片相关汇总",@"19，代替if-else的条件方法",@"20，内存泄露",@"21，原生和js交互",@"22，事件的封装",@"23，控件的简单写法（懒加载）",@"24，协议&继承&多态&分类&扩展",@"25，app安全",@"26，app瘦身",@"27，日志打印",@"28, oc,c和c++混编",@"29,静态库和sdk制作"];
    
    self.cellControllerNameArray = @[@"MethodCallVC",@"ButtonTransferParameterVC",@"PassValueVC",@"PrecompliedViewController",
 @"TimerViewController",@"",@"SingltonVC",@"SimpleDelegateTestVC",@"ProtocolDelegateVC",@"MutiDelegatVC",@"KVOSummaryVC",@"NotificationVC",@"BlockSummaryVC",@"KVCSummaryVC",@"DesignModeSummaryVC",@"MatchingMethodVC",@"RegularExpressionVC",@"ArchitectureVC",@"",@"RunTimeVC",@"InitMethodVC",@"DicToModelVC",@"RunLoopVC",@"",@"EncryptVC",@"AudioSummaryVC",@"CacalateStorageVC",@"ReplaceIfElseVC",@"MemoryLeakVC",@"NativeAndWebTableVC",@"",@"ElementMakerVC",@"ObjectOrientedViewController",@"",@"",@"PrintLogVC",@"MixedProgramVC",@""];
}

#pragma mark -  初始化tableview

- (void)initTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 150, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 150 - 49) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:tableView];
    _tableView = tableView;
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellDisplayNameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //由于此方法调用十分频繁，cell的标示声明成静态变量有利于性能优化
    static NSString *cellIdentifier=@"UITableViewCellIdentifierKey";
    
    //首先根据标识去缓存池取
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
   
    //如果缓存池没有到则重新创建并放到缓存池中
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.cellDisplayNameArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = [self getController:self.cellControllerNameArray[indexPath.row]];
    vc.title = self.cellDisplayNameArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}



#pragma mark - 根据字符串名称动态获取控制器对象
- (id)getController:(NSString *)controllerName {
    // 类名
    NSString *class =[NSString stringWithFormat:@"%@", controllerName];
    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    
    // 从一个字串返回一个类
    Class newClass = objc_getClass(className);
    if (!newClass)
    {
        // 创建一个类
        Class superClass = [NSObject class];
        newClass = objc_allocateClassPair(superClass, className, 0);
        // 注册你创建的这个类
        objc_registerClassPair(newClass);
    }
    // 创建对象
    id instance = [[newClass alloc] init];
    return instance;
}





@end
