//
//  WHCModelVC.m
//  排序总结
//
//  Created by gjfax on 2019/4/30.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "WHCModelVC.h"
#import "NSObject+WHC_Model.h"
#import "ModelObject.h"
#import <objc/runtime.h>
#import <mach/mach_time.h>

@interface WHCModelVC ()

@end

@implementation WHCModelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// 从文件ModelObject读取json对象
    NSString * jsonString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ModelObject" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    
    NSData * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    /************** 解析jsonData **************/
    ModelObject * model = [ModelObject whc_ModelWithJson:jsonData];
    NSLog(@"解析jsonData model = %@\n\n",model);
    
    /************** json -> modelObject **************/
    model = [ModelObject whc_ModelWithJson:jsonString];
    NSLog(@"json -> modelObject model = %@\n\n\n",model);
    
    /************** modelObject -> json **************/
    NSString * modelString = [model whc_Json];
    NSLog(@"modelObject -> json modelString = %@\n\n\n",modelString);
    
    /************** modelObject - > NSDictionary **************/
    NSDictionary * modelDict = [model whc_Dictionary];
    NSLog(@"modelObject - > NSDictionary modelDict = %@\n\n\n",modelDict);
    
    /************** 指定路径只解析Head对象 **************/
    Head * head = [Head whc_ModelWithJson:jsonString keyPath:@"Head"];
    head.testNum = [NSNumber numberWithInt:100];
    {
        /************** 归档对象 **************/
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:head];
        
        /************** 解归档对象 **************/
        Head * tempHead = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        NSLog(@"tempHead.testNum = %@",tempHead.testNum);
    }
    NSLog(@"指定路径只解析Head对象 head = %@\n\n\n",head);
    
    /************** 指定路径只解析ResponseBody对象 **************/
    ResponseBody * body = [ResponseBody whc_ModelWithJson:jsonString keyPath:@"ResponseBody"];
    NSLog(@"指定路径只解析ResponseBody对象 ResponseBody = %@\n\n\n",body);
    
    /************** 指定路径只解析PolicyRuleList集合中第一个对象 **************/
    PolicyRuleList * rule = [PolicyRuleList whc_ModelWithJson:jsonString keyPath:@"ResponseBody.PolicyRuleList[10]"];
    NSLog(@"指定路径只解析PolicyRuleList集合中第一个对象 rule = %@\n\n\n",rule);
    
    /************** 归档对象 **************/
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
    
    /************** 解归档对象 **************/
    ModelObject * tempModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSLog(@"tempModel = %@",tempModel);
    
    /************** 复制对象 **************/
    ModelObject * copyModel = model.copy;
    NSLog(@"copyModel = %@",copyModel);
}



@end
