//
//  ViewController.m
//  12-掌握-多图下载综合案例
//
//  Created by 赵文娟 on 17/2/23.
//  Copyright © 2017年 ZWJ. All rights reserved.
//

#import "MemoryAndDiskCacheVC.h"
#import "ZWJModel.h"

@interface MemoryAndDiskCacheVC ()
@property (nonatomic,strong) NSArray *arrs;
//内存缓存--必须用可变字典
@property (nonatomic,strong) NSMutableDictionary *imageDics;
@property (nonatomic,strong) NSOperationQueue *queue;
@property (nonatomic,strong)  NSMutableDictionary *operationDics;

@end

@implementation MemoryAndDiskCacheVC
- (void)viewDidLoad {
    self.tableView.frame = CGRectMake(0,64,SCREEN_WIDTH,SCREEN_HEIGHT - 64 - 49);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.arrs count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *cellID= @"cellID";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    
    ZWJModel *model = [self.arrs objectAtIndex:indexPath.row];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.download;
    UIImage *image = [self._imageDics objectForKey:model.icon];
    
    
    //-1-检查内存缓存是否有图片？
        // -1.1 -如果有，直接展示
    if (image) {
        cell.imageView.image = image;
        NSLog(@"%zd 处的图片使用了内存中的图片",indexPath.row);
        
        // -1.2-如果没有，查找磁盘缓存
    }else{
        
        //保存到沙河缓存
        NSString *caches= [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];//文件夹路径
        //获得图片名称,不能包含/   "http://p19.qhimg.com/dr/48_48_/t0164ad383c622aabef.png"
        NSString *fileName = [model.icon lastPathComponent];
        //拼接图片的全路径
        NSString *fullPath = [caches  stringByAppendingPathComponent:fileName];

        
    //-2-检查磁盘/沙盒缓存
       
        NSData *imageDataa =[NSData dataWithContentsOfFile:fullPath];
         //2.1 磁盘/沙盒缓存-如果有，直接展示，并存到内存缓存
        if (imageDataa) {
            UIImage *image = [UIImage imageWithData:imageDataa ];
            cell.imageView.image = image;
            //-2-1-1保存到内存缓存
            [self.imageDics setObject:image forKey:model.icon];
            NSLog(@"沙盒缓存 ---%zd",indexPath.row);

        //2.2磁盘/沙盒缓存-没有，下载图片，展示图片，存入沙盒，存入内存缓存
        }else{
        
            //download下载图片-存入内存缓存model-存入沙盒缓存Caches
            
            
            //卡：开子线程下载图片
           // NSOperationQueue *queue = [[NSOperationQueue alloc] init];//这样每次cell建立一次，所以用懒加载
            
            //演示网速慢情况：造成重复下载
            
            
            //检查该图片正在下载？如果是什么都不做，否则再添加下载任务
            
            NSBlockOperation *op = [self.operationDics objectForKey:model.icon];
            if (op) {
                //
            }else
            {
                //问题：植物大战僵尸的图片显示到其他地方？错乱
                
                cell.imageView.image = [UIImage imageNamed:@"1"];//这样不好，用站位图片
                
                NSBlockOperation *downloadOP = [NSBlockOperation blockOperationWithBlock:^{
                    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.icon]];
                    UIImage *image = [UIImage imageWithData:imageData ];
                    
                    NSLog(@"download -----%@",[NSThread currentThread]);
                    //线程间通信，放到主线程。
                    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                        //手动刷新-主动
                        //整个tableview的刷新
                        //     [self.tableView reloadData];
                        //刷新某一行
                        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
                        
                        cell.imageView.image = image;
                    }];
                    
                    //问题：UI和不良流畅---->开启子线程
                    //图片重复下载：-----》先把之前已经下载的图片保存起来（dic）
                    
                    
                    //容错处理：服务器给的图片网址错误;网速很慢
                    if (image == nil) {
                        //操作缓存移除
                        [self.operationDics removeObjectForKey:model.icon];
                        
                        return ;
                    }
                    [self.imageDics setObject:image forKey:model.icon];
                    
                    [imageData writeToFile:fullPath atomically:YES];
                    
                    NSLog(@"%zd ---下载= ",indexPath.row);
                    //下载完毕移除下载操作
                    [self.operationDics removeObjectForKey:model.icon];
                    
                }];
                
                //为了防止重复下载图片-重复操作
                [self.operationDics setObject:downloadOP forKey:model.icon];
                [self.queue addOperation:downloadOP];
            }
            
          //添加操作到队列中
        }
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 80;
}

//【内存缓存images】，此方法用于上下拖动程序，数据cell的缓存。
//先去【内存缓存images】查看内存缓存是否存在？存在，直接用。如果不存在，存入
//问题：如果kill了程序，退出程序缓存怎么处理？
//  除了做【内存缓存mode->dic】，还要做【沙盒缓存】即磁盘缓存

//2.4 设置图标
//先去查看内存中该图是否存在，如果存在那么直接拿来用，否则检查磁盘缓存，如果有磁盘缓存那么保存到内存并设置图片，否则直接下载

//如果内存缓存没有，有2中情况
// 1> 没有下载过
// 2> 下载过了，但是 重新打开程序


//1 UI不流畅---开子线程下载图片
// 2 图片重复下载---把之前已经下载的图片保存起来（下载前没看缓存，或者没看之前下载过没）
//   2.1 内存缓存 先（dic）上下拖动cell，数据保证下载一次。  2，2 沙盒缓存（磁盘缓存）程序退出或者kill杀掉程序 可以有上次数据缓存显示
// 3 图片不会刷新？      刷新某行
// 4 图片重复下载：dic
         //方法：缓存操作 ；
         //原因：添加opration操作添加了多次。所以缓存操作；
         // 演示网速慢情况：造成重复下载（手上下拖动太快，也会造成重复下载）；（图片下载需要时间，图片还未完全下载之前，又要重新显示该图片。）
// 5 图片错乱位置：占位图片
// 6 容错处理：后台给的图片URL是错误的怎么办？
/*
 document :备份itunes（苹果不允许缓存，上线拒绝）
 library：    caches（专门缓存）  preferences(偏好设置：账号信息)
 tmp：临时路径，随时会被删除
  */

-(void)didReceiveMemoryWarning
{

    //删除  :会不会影响界面显示，会不会把所有删除？不会的，因为强引用所以不会。
    [self.imageDics removeAllObjects];
    
    // 取消队列中所有操作
    [self.queue cancelAllOperations];
    
}

#pragma mark -  下载队列
-(NSOperationQueue *)queue
{
    
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc] init];
        //设置最大并发数
        _queue.maxConcurrentOperationCount = 5 ;
    }
    return _queue;
}
#pragma mark -  图片数组
-(NSMutableDictionary *)_imageDics
{
    
    if (_imageDics == nil) {
        _imageDics = [[NSMutableDictionary alloc] init];
    }
    return _imageDics;
    
}
#pragma mark -  模型数组
-(NSArray *)arrs
{
    
    if (_arrs == nil) {
        //arr  本地plist拿到
        NSArray *arr= [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"apps.plist" ofType:nil]];
        //dic
        NSMutableArray *arrM = [[NSMutableArray alloc] init];
        for (NSDictionary * dic in arr) {
            [arrM addObject:[ZWJModel arrMWithDic:dic]];;
        }
        // 转model
        //model-arr
        
        _arrs = arrM;
        
    }
    
    return _arrs;
}
#pragma mark -  操作字典
-(NSMutableDictionary *)operationDics
{
    
    if (_operationDics == nil) {
        _operationDics= [[NSMutableDictionary alloc] init];
        
    }
    return _operationDics;
}


@end
