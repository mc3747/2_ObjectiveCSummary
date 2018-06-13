//
//  NSArrayTest.m
//  ToolAndExtensionSummaryTests
//
//  Created by gjfax on 2018/6/13.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSArray+BlocksKit.h"

/*
 //这里的断言基本都以XCT开头，末参数一定为报错时展示的文字信息
 
 //断言,最基本的测试,第一个参数为真，则通过
 XCTAssert(_condition1 == _condition2, @"测试过程中出现错误");
 
 //bool测试中的true测试，首参数为真通过
 XCTAssertTrue(_condition1 == _condition2,@"BOOL测试中的true测试出错");
 
 //bool测试中的false测试，首参数为假通过
 XCTAssertFalse(_condition1 == _condition3,@"BOOL测试中的false测试出错");
 
 //相等测试，首参数与次参数相等通过
 XCTAssertEqual(_condition1, _condition2,@"相等测试出错");
 
 //不相等测试，首参数与次参数不相等通过
 XCTAssertNotEqual(_condition1, _condition3,@"不等测试出错");
 
 //针对loat或double比较，首参数与次参数的差，比第三参数的值小，通过
 //大于测试
 XCTAssertGreaterThan(_condition1, _condition3, @"大于测试出错");
 
 //大于等于测试
 XCTAssertGreaterThanOrEqual(_condition1, _condition2, @"大于或等于测试出错");
 
 //相差测试，首参数与次参数的差，比第三参数的值小，通过
 XCTAssertEqualWithAccuracy(0.6, 0.5, 0.11, @"相差测试结果比第三参数大");
 
 //针对loat或double比较，首参数与次参数的差，比第三参数的值大，通过
 XCTAssertNotEqualWithAccuracy(0.6, 0.5, 0.01, @"相差测试结果比第三参数小");
 
 //首参数为nil，通过
 XCTAssertNil(nil, @"nil测试");
 
 //首参数不为nil，通过
 XCTAssertNotNil(_condition4,@"非nil测试");
 
 //无条件报错
 XCTFail(@"强制失败");
 
*/
@interface NSArrayTest : XCTestCase

@end

@implementation NSArrayTest

//Setup是在所有测试用例运行之前运行的函数，在这个测试用例里进行一些通用的初始化工作
- (void)setUp {
    [super setUp];
    
}

//tearDown是在所有的测试用例都执行完毕后执行的
- (void)tearDown {
    
    [super tearDown];
}

- (void)testArray {
    NSArray *array = @[@"2",@"32",@"432"];
    NSString *string = [array bk_match:^BOOL(id  _Nonnull obj) {
        return ((NSString *)obj).length == 2;
    }];
    XCTAssertEqual(string, @"32",@"相等");
}


- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
