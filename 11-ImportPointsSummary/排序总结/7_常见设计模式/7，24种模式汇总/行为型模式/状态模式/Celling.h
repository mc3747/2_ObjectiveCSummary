//
//  Celling.h
//  行为型设计模式-状态模式
//
//  Created by 温杰 on 2018/4/11.
//  Copyright © 2018年 温杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellingState.h"
@interface Celling : NSObject
@property (nonatomic,strong) id<CellingState> state;

-(void)choose;
-(void)buy;
-(void)shipment;

@end
