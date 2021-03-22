//
//  FmdbVC_2.m
//  NetworkSummary
//
//  Created by gjfax on 2018/12/3.
//  Copyright © 2018 macheng. All rights reserved.
//


/*
1.FMDB简介

什么是FMDB
FMDB是iOS平台的SQLite数据库框架
FMDB以OC的方式封装了SQLite的C语言API

2,为什么使用FMDB
使用起来更加面向对象，省去了很多麻烦、冗余的C语言代码
对比苹果自带的Core Data框架，更加轻量级和灵活
提供了多线程安全的数据库操作方法，有效地防止数据混乱

3,使用步骤
1，导入库文件
2，导入头文件

4，FMDB的三个主要类
1，FMDatabase – 一个FMDatabase对象就表示一个单独的SQLite数据库，用来执行SQLite的命令
2，FMResultSet – 表示FMDatabase执行查询后结果集
3，FMDatabaseQueue – 如果你想在多线程中执行多个查询或更新，你应该使用该类，这样能保证线程安全
*/

#import "FmdbVC_2.h"
#import "FMDB.h"

//创建一个FMDatabaseQueue队列对象，这样做的目的是为了避免发生并发访问数据库的操作，项目开发过程中可以创建一个单例来共享这个FMDatabaseQueue 对象。
static FMDatabaseQueue *queue;
@interface FmdbVC_2 ()

{
    FMDatabase *database;
    NSString *filePath;
}
@end


@implementation FmdbVC_2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fmdbBase];
    
    //    [self fmdbMutiThreading];
}

#pragma mark - 基本使用
- (void)fmdbBase {
    
    //获取沙盒路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSLog(@"%@",path);
    //设置数据库路径
    filePath = [path stringByAppendingPathComponent:@"student.sqlite"];
    //创建数据库
    /*数据库文件路径可以是以下三种之一：
     1.具体文件路径。该文件路径如果不存在会自动创建。
     2.空字符串(@””)。表示会在临时目录创建一个空的数据库，当FMDatabase 链接关闭时，文件也会被删除。
     3.NULL。 将创建一个内存中的临时数据库。同样的，当FMDatabase连接关闭时，数据文件会被销毁。
     */
    database = [FMDatabase databaseWithPath:filePath];
    //打开数据库
    if ([database open]) {
        //这里写执行操作代码
        NSLog(@"数据库打开成功");
    } else {
        //数据库打开失败
        NSLog(@"数据库打开失败");
        return;
    }
    //创建数据表person(id, name, sex, telephone),执行sqlite语句
    NSString *createSql = [NSString stringWithFormat:@"create table if not exists person (id integer primary key, name text, sex text, telephone text)"];
    //执行更新操作（创建表）
    if (![database executeUpdate:createSql]) {
        NSLog(@"create table failed!");
    }else {
        NSLog(@"create table successful!");
    }
}

#pragma mark - 基本操作
// 增
- (IBAction)fmdbOperationAdd:(id)sender {
    // 在executeUpdate方法后直接加sql语句时要注意数据类型的使用，必须使用OC的对象类型
    //插入一条记录，(1,jack,male,12345678)
    NSString *insertSql = [NSString stringWithFormat:@"insert into person (id, name, sex, telephone) values (%d, '%@', '%@', '%@')", 1, @"jack", @"male", @"12345678"];
    //执行更新操作（插入记录）
    if (![database executeUpdate:insertSql]) {
        NSLog(@"insert failed!");
    }
    //在executeUpdate后面直接加sql语法时，使用?来表示OC中的对象，integer对应NSNumber，text对应NSString，blob对应NSData，数据内部转换FMDB已经完成，只要sql语法正确就没有问题
    if (![database executeUpdate:@"insert into person (id, name, sex, telephone) values (?, ?, ?, ?)", @4, @"gary", @"male", @"99996666"]) {
        NSLog(@"insert failed!");
    }
}

// 删
- (IBAction)fmdbOperationDelete:(id)sender {
    //删除一条记录，从person表中将id= 2的记录删除
    NSString *deleteSql = [NSString stringWithFormat:@"delete from person where id = 2"];
    //执行删除操作
    if (![database executeUpdate:deleteSql]) {
        NSLog(@"delete failed!");
    }
}


// 改
- (IBAction)fmdbOperationModify:(id)sender {
    //更新（修改）一条记录，将id = 1的记录姓名修改为mike
    NSString *updateSql = [NSString stringWithFormat:@"update person set name = '%@' where id = 1", @"mike"];
    //执行更新操作
    if (![database executeUpdate:updateSql]) {
        NSLog(@"update failed!");
    }
}

// 查
- (IBAction)fmdbOperationQuery:(id)sender {
    //查询数据库中记录
    NSString *selectSql = [NSString stringWithFormat:@"select * from person"];
    //使用executeQuery方法来执行查询语句，使用FMResultSet *来接收查询到的数据
    FMResultSet *rs = [database executeQuery:selectSql];
    //[rs next]相当于sqlite3_step语句，用来逐行检索数据表中记录
    while ([rs next]) {
        //使用字段位置查询
        NSLog(@"id = %d", [rs intForColumnIndex:0]);
        //使用字段名称查询[rs stringForColumn:@"name"]
        NSLog(@"name = %@", [rs stringForColumn:@"name"]);
        NSLog(@"sex = %@", [rs stringForColumnIndex:2]);
        NSLog(@"telephone = %@", [rs stringForColumnIndex:3]);
    }
}
#pragma mark - 多线程下使用FMDB
/**
 *  使用FMDatabaseQueue可以比较有效的解决多线程下对数据库的访问。FMDatabaseQueue解决多线程问题的思路大致是：创建一个队列，然后将需要执行的数据库操作放入block中，队列中的block按照添加进队列的顺序依次执行，实际上还是同步的操作，避免了多个线程同时对数据库的访问。
 
 
 */
- (void)fmdbMutiThreading {
    
    //初始化队列
    queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
    //调用inDatabase方法来将需要执行的操作添加到队列queue中去
    [queue inDatabase:^(FMDatabase *db) {
        //添加需要执行的操作
        [db executeUpdate:@"insert into person (id, name, sex, telephone) values (?, ?, ?, ?)", @100, @"test1", @"male", @"11114321"];
        [db executeUpdate:@"insert into person (id, name, sex, telephone) values (?, ?, ?, ?)", @101, @"test2", @"male", @"22224321"];
        //继续添加想要执行的操作...
    }];
    
    
    // 使用相似的方法，我们就可以在FMDB中把一些任务包装进事务（在FMDatabaseQueue使用过程中尽量避免嵌套使用，以免造成死锁）：
    //调用inTransaction方法将需要执行的操作添加到队列中去
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        //在事务中添加需要执行的操作，出现异常时及时回滚
        if (![db executeUpdate:@"insert into person (id, name, sex, telephone) values (?, ?, ?, ?)", @104, @"test3", @"male", @"11114321"]) {
            *rollback = YES;
            return ;
        }
        if (![db executeUpdate:@"insert into person (id, name, sex, telephone) values (?, ?, ?, ?)", @105, @"test4", @"male", @"11114321"]) {
            *rollback = YES;
            return ;
        }
    }];
}


@end
