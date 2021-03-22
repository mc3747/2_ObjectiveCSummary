//
//  SortSummary.m
//  ArrayAndDictorySummary
//
//  Created by gjfax on 2018/6/6.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "SortSummary.h"
#import "SLPerson.h"

@implementation SortSummary
#pragma mark -  1，数字排序
+ (void)sortNumberDemo {
    
    NSArray *originalArray = @[@"8",@"41",@"32",@"11",@"-1"];
    //block比较方法，数组中可以是NSInteger，CGFloat等（需要转换）
    NSComparator finderSort = ^(id string1,id string2){
        if ([string1 integerValue] > [string2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }else if ([string1 integerValue] < [string2 integerValue]){
            return (NSComparisonResult)NSOrderedAscending;
        }else {
            return (NSComparisonResult)NSOrderedSame;
        };
    };
    NSArray *resultArray = [originalArray sortedArrayUsingComparator:finderSort];
    NSLog(@"数字排序结果：%@",resultArray);
}
#pragma mark -  2，字符串排序
+ (void)sortStringDemo {
    //  2. 非数字型字符串（注意用compare比较要剔除空数据（nil））
    
    NSArray *charArray =@[@"string 1",@"String 21",@"string 12",@"String 11",@"String 02"];
    NSStringCompareOptions comparisonOptions =NSCaseInsensitiveSearch|NSNumericSearch|
    NSWidthInsensitiveSearch|NSForcedOrderingSearch;
    NSComparator sort = ^(NSString *obj1,NSString *obj2){
        NSRange range = NSMakeRange(0,obj1.length);
        return [obj1 compare:obj2 options:comparisonOptions range:range];
    };
    NSArray *resultArray2 = [charArray sortedArrayUsingComparator:sort];
    NSLog(@"字符串排序结果%@",resultArray2);
}

#pragma mark -  3，字典排序
+ (void)sortDicDemo {
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:
                             @{@"obj0":@"0"},
                             @{@"obj3":@"3"},
                             @{@"obj1":@"1"},
                             @{@"obj2":@"2"},
                             @{@"obj4":@"4"},
                             nil];
    NSArray *resultArray = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1,id obj2) {
        NSNumber *number1 = [[obj1 allKeys] objectAtIndex:0];
        NSNumber *number2 = [[obj2 allKeys] objectAtIndex:0];
        NSComparisonResult result = [number1 compare:number2];
        //return result == NSOrderedAscending;  //降序
        return result == NSOrderedDescending;//升序
    }];
    
    NSLog(@"字典排序结果:%@", resultArray);
}
#pragma mark -  4，自定义对象排序
+ (void)sortModelDemo {
    SLPerson *person1 = [[SLPerson alloc]init];
    [person1 setName:@"ABCD"];
    [person1 setAge:24];
    
    
    SLPerson *person2 = [[SLPerson alloc]init];
    [person2 setName:@"ACBD"];
    [person2 setAge:22];
    
    SLPerson *person3 = [[SLPerson alloc]init];
    [person3 setName:@"ABDC"];
    [person3 setAge:33];
    
    SLPerson *person4 = [[SLPerson alloc]init];
    [person4 setName:@"ACDB"];
    [person4 setAge:22];
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:person1, person3, person4, person2,nil];
    NSSortDescriptor *sortDescriptor1 = [NSSortDescriptor sortDescriptorWithKey:@"age"ascending:YES];  //先按照age排序,
    NSSortDescriptor *sortDescriptor2 = [NSSortDescriptor sortDescriptorWithKey:@"name"ascending:YES];  //如果age相同,按照name排序,以此类推
    
    NSArray *tempArray = [array sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sortDescriptor1, sortDescriptor2, nil]];
    
    for(NSInteger i =0; i < [tempArray count]; i++){
        SLPerson *person = [tempArray objectAtIndex:i];
        NSLog(@"对象排序结果%@：%lu\n", person.name, (unsigned long)person.age);
    }
}
@end
