//
//  ViewController.m
//  定时器绘制
//
//  Created by gjfax on 2017/7/14.
//  Copyright © 2017年 macheng. All rights reserved.
//

#import "TimerViewController.h"
#import <objc/runtime.h>

@interface TimerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *cellLogoNameArray;
@property (nonatomic, strong) NSArray *cellDisplayNameArray;
@property (nonatomic, strong) NSArray *cellControllerNameArray;
@property (nonatomic, weak) UITableView *tableView;
@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"定时器汇总";
    
    [self initArrays];
    [self initTableView];
    
}
- (void)initArrays {
    
    self.cellLogoNameArray = @[@"lucky-1",@"lucky-2",@"lucky-3",
                               @"lucky-4",@"lucky-5",@"lucky-6"];
    
    self.cellDisplayNameArray = @[@"performSelector延时",@"NSTimer定时器",@"封装的NSTimer的block回调定时器",@"未封装的GCD定时器",
                                  @"封装好的GCD定时器",@"CADisplayLink定时器"];
    
    self.cellControllerNameArray = @[@"PerformSelectorVC",@"NSTimerVC",@"BlockTimerVC",@"GCDTimerVC",
                                     @"CustomTimerVC",@"CADisplayLinkVC"];
}

- (void)initTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 66, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 66) style:UITableViewStylePlain];
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
    cell.imageView.image = [UIImage imageNamed:self.cellLogoNameArray[indexPath.row]];
    cell.textLabel.text = self.cellDisplayNameArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

     [tableView deselectRowAtIndexPath:indexPath animated:YES];
     [self.navigationController pushViewController:[self getController:self.cellControllerNameArray[indexPath.row]] animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
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
