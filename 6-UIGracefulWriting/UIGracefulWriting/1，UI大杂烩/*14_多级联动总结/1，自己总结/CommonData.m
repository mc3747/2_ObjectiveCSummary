//
//  CommonData.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/4/11.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "CommonData.h"
#import "FMDatabase.h"

@implementation CommonData
#pragma mark -  单例
+ (instancetype)sharedInstance {
    // 1.定义一个静态变量来保存你类的实例确保在你的类里面保持全局
    static CommonData *_sharedInstance = nil;
    
    // 2.定义一个静态的dispatch_once_t变量来确保这个初始化存在一次
    static dispatch_once_t oncePredicate;
    
    // 3.用GCD来执行block初始化实例
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[CommonData alloc] init];
        _sharedInstance->_threeLevelData = [self getThreeDataArray];
        _sharedInstance->_twoLevelData = [self getTwoDataArray];
        _sharedInstance->_oneLevelData = [self getOneDataArray];
    });
    
    return _sharedInstance;
}

+(NSMutableArray *)getThreeDataArray{
    NSMutableArray *threeLevelplaceArr = [[NSMutableArray alloc] init];
    Province * defaultProvince = [[Province alloc] init];
    
    [threeLevelplaceArr addObject:defaultProvince];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"medical" ofType:@"db"];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    [db open];
    //省
    NSString *sql = @"select * from area where s_level=0";
    FMResultSet *firstResult = [db executeQuery:sql];
    
    while ([firstResult next]) {
        NSString *provinceName = [firstResult stringForColumn:@"name"];
        int proviceId = [firstResult intForColumn:@"id"];
        
        Province *province = [[Province alloc] init];
        province.province = provinceName;
        //市
        NSString *sql2 = FMT_STR(@"select * from area where s_level=1 and parent_id = %i",proviceId);
        FMResultSet *secondResult = [db executeQuery:sql2];
        
        while ([secondResult next]) {
            NSString *cityName = [secondResult stringForColumn:@"name"];
            int cityId = [secondResult intForColumn:@"id"];
            City *city = [[City alloc] init];
            city.city = cityName;
            //区
            NSString *sql3 = FMT_STR(@"select * from area where s_level=2 and parent_id = %i",cityId);
            FMResultSet *thirdResult = [db executeQuery:sql3];
            while ([thirdResult next]) {
                NSString *districtName = [thirdResult stringForColumn:@"name"];
                District *district = [[District alloc] init];
                
                district.district = districtName;
                [city.districtArr addObject:district];
            }
            
            [province.cityArr addObject:city];
        }
        [threeLevelplaceArr addObject:province];
    }
    return threeLevelplaceArr;
}

+(NSMutableArray *)getTwoDataArray{
    NSMutableArray *twoLevelplaceArr = [[NSMutableArray alloc] init];
    Province * defaultProvince = [[Province alloc] init];
    [twoLevelplaceArr addObject:defaultProvince];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"medical" ofType:@"db"];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    [db open];
    
    NSString *sql = @"select * from indu where s_level=0";
    FMResultSet *firstResult = [db executeQuery:sql];
    while ([firstResult next]) {
        int id = [firstResult intForColumnIndex:0];
        NSString *name = [firstResult stringForColumnIndex:2];
        NSDictionary *firstDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:id], @"id", name, @"name", nil];
        Province *province = [[Province alloc] init];
        province.province = firstDic[@"name"];
        
        NSNumber *idNumber =  firstDic[@"id"];
        NSString *sql = FMT_STR( @"select * from indu where s_level=1 and parent_id = %i",[idNumber intValue]);
        FMResultSet *secondResult = [db executeQuery:sql];
        while ([secondResult next]) {
            int id = [secondResult intForColumnIndex:0];
            NSString *name = [secondResult stringForColumnIndex:2];
            NSDictionary *secondDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:id], @"id", name, @"name", nil];
            City *city = [[City alloc] init];
            city.city = secondDic[@"name"];
            [province.cityArr addObject:city];
        };
        
        [twoLevelplaceArr addObject:province];
    }
    return twoLevelplaceArr;
}

+(NSMutableArray *)getOneDataArray{
    NSMutableArray *oneLevelplaceArr1 = [[NSMutableArray alloc] init];
    Province * defaultProvince = [[Province alloc] init];
    [oneLevelplaceArr1 addObject:defaultProvince];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"medical" ofType:@"db"];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    [db open];
    
    NSString *sql = @"select * from rank where s_level=0";
    FMResultSet *firstResult = [db executeQuery:sql];
    while ([firstResult next]) {
        int nameId = [firstResult intForColumnIndex:0];
        NSString *name = [firstResult stringForColumnIndex:2];
        NSDictionary *firstDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:nameId], @"id", name, @"name", nil];
        Province *province = [[Province alloc] init];
        province.province = firstDic[@"name"];
        [oneLevelplaceArr1 addObject:province];
    }
    return oneLevelplaceArr1;
}
@end
