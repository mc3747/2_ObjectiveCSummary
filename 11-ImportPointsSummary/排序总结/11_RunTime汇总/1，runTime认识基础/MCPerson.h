//
//  MCPerson.h
//  排序总结
//
//  Created by gjfax on 2019/5/6.
//  Copyright © 2019 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCPerson : NSObject

@property (assign, nonatomic) int ID;
@property (assign, nonatomic) int weight;
@property (assign, nonatomic) int age;
@property (copy, nonatomic) NSString *name;

//消息发送
-(void)testSendMessage;

//动态方法解析
- (void)test1;
+ (void)test1;

//动态添加方法
- (void)test2;
+ (void)test2;

//消息转发
- (void)test3;
+ (void)test3;

//获取成员变量
- (void)test4;
@end

NS_ASSUME_NONNULL_END
