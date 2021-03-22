//
//  FmdbVC.m
//  NetworkSummary
//
//  Created by gjfax on 2018/12/3.
//  Copyright © 2018 macheng. All rights reserved.
//

#import "FmdbVC_1.h"
#import <FMDB.h>

#define KDBName @"DemoDB.sqlite"//数据库(也可以是.db)
#define KFMDBName @"TESTFMDB.sqlite"//数据库(也可以是.db)
#define KTBUserInfo @"userInfo"//用户信息表
#define KTBDog @"dogInfo"//dog信息表
#define documents [NSHomeDirectory() stringByAppendingString:@"/Documents"]
@interface FmdbVC_1 ()
{
     FMDatabase *fmdb;
}
@end

@implementation FmdbVC_1

- (void)viewDidLoad {
    [super viewDidLoad];
     [self fmdbTest];//FMDB
}

#pragma mark ---------FMDB-----------
- (void)fmdbTest{
    [self fmdbCreate];
    [self fmdbTableCreate];
    [self fmdbInsertData];
    [self fmdbUpdateData];
    [self fmdbDeleteData];
    [self fmdbSelectData];
    [self fmdbQueue];
}

#pragma amrk - fmdb创建数据库
- (void)fmdbCreate{
    NSString *database_path = [documents stringByAppendingPathComponent:KFMDBName];
    //数据库打开、创建
    fmdb = [FMDatabase databaseWithPath:database_path];
}
#pragma amrk - fmdb创建表
- (void)fmdbTableCreate{
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR, age INTEGER, sex INTEGER, phoneNum VARCHAR);",KTBUserInfo];
    [self fmdbExecSql:sql];
}
#pragma mark - fmdbUpdate
- (void)fmdbExecSql:(NSString *)sql{
    if ([fmdb open]) {
        
        /*
         * 只要sql不是SELECT命令的都视为更新操作(使用executeUpdate方法)。就包括 CREAT,UPDATE,INSERT,ALTER,BEGIN,COMMIT,DETACH,DELETE,DROP,END,EXPLAIN,VACUUM,REPLACE等等。SELECT命令的话，使用executeQuery方法。
         * 执行更新返回一个BOOL值。YES表示 执行成功，否则表示有错误。你可以调用 -lastErrorMessage 和 -lastErrorCode方法来得到更多信息。
         */
        if ([fmdb executeUpdate:sql]) {
            NSLog(@"%@%@%@",@"fmdb操作表",KTBUserInfo,@"成功！");
        }else{
            NSLog(@"%@%@%@ lastErrorMessage：%@，lastErrorCode：%d",@"fmdb创建",KTBUserInfo,@"失败！",fmdb.lastErrorMessage,fmdb.lastErrorCode);
        }
    }else{
        NSLog(@"%@",@"fmdb数据库打开失败！");
    }
}
#pragma mark - fmdb插入数据
- (void)fmdbInsertData{
    NSString *sql = [NSString stringWithFormat:
                     @"INSERT INTO '%@' ('name', 'age', 'sex', 'phoneNum') VALUES ('%@', '%@', '%@','%@');",KTBUserInfo, @"张三", @"23", @"1",@"18875022022"];
    [self fmdbExecSql:sql];
    
    sql = [NSString stringWithFormat:
           @"INSERT INTO '%@' ('name', 'age', 'sex', 'phoneNum') VALUES ('%@', '%@', '%@','%@');",KTBUserInfo, @"李四", @"24", @"0",@"18875022023"];
    [self fmdbExecSql:sql];
    
    sql = [NSString stringWithFormat:
           @"INSERT INTO '%@' ('name', 'age', 'sex', 'phoneNum') VALUES ('%@', '%@', '%@','%@');",KTBUserInfo, @"王五", @"25", @"1",@"18875022024"];
    [self fmdbExecSql:sql];
}
#pragma mark - fmdb修改数据
- (void)fmdbUpdateData{
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ set age='%@' WHERE name='张三';",KTBUserInfo,@"2333"];
    [self fmdbExecSql:sql];
}
#pragma mark - fmdb删除数据
- (void)fmdbDeleteData{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE name='张三';",KTBUserInfo];
    [self fmdbExecSql:sql];
}
#pragma mark - fmdbSelectData
- (void)fmdbSelectData{
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM %@;",KTBUserInfo];
    
    //根据条件查询
    FMResultSet *resultSet = [fmdb executeQuery:sqlQuery];
    
    //遍历结果集合
    while ([resultSet  next]){
        NSString *name = [resultSet
                          objectForColumnName:@"name"];
        int age = [resultSet intForColumn:@"age"];
        int sex = [resultSet intForColumn:@"sex"];
        NSString *phone = [resultSet objectForColumnName:@"phoneNum"];
        
        NSLog(@"%@: name:%@ age:%d sex:%d phoneNum:%@",KTBUserInfo,name,age,sex,phone);
    }
    /*
     * fmdb封装过后的读取数据是要比原生的sqlite3方便了很多哈
     */
}
#pragma mark - fmdb多线程
- (void)fmdbQueue{
    //创建队列
    FMDatabaseQueue *queue = [FMDatabaseQueue
                              databaseQueueWithPath:[documents stringByAppendingPathComponent:KFMDBName]];
    __block BOOL tag = true;
    
    //把任务放到到队列里
    [queue inTransaction:^(FMDatabase *dbe, BOOL *rollback)
     {
         tag &= [dbe executeUpdate:@"INSERT INTO userInfo ('age') VALUES (?)",[NSNumber numberWithInt:11]];
         tag &= [dbe executeUpdate:@"INSERT INTO userInfo ('age') VALUES (?)",[NSNumber numberWithInt:22]];
         tag &= [dbe executeUpdate:@"INSERT INTO userInfo ('age') VALUES (?)",[NSNumber numberWithInt:33]];
         //如果有错误 返回
         if (!tag)
         {
             *rollback = YES;
             return;
         }
     }];
}
@end
