//
//  TestRelaceIfElseVC.h
//  排序总结
//
//  Created by gjfax on 2019/1/18.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "BaseTableViewVC.h"

typedef NS_ENUM(NSInteger,TestType){
    TestTypeIfElse = 0,
    TestTypeIfReturn,
    TestTypeSwitchCase,
    TestTypeTernaryOperator,
    
};

NS_ASSUME_NONNULL_BEGIN

@interface TestReplaceIfElseVC : BaseTableViewVC
@property (nonatomic, assign) TestType testType;
@end

NS_ASSUME_NONNULL_END
