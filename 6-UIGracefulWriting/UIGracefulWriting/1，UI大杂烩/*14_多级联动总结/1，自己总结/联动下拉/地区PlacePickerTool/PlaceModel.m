//
//  PlaceModel.m
//  RHPlacePick
//
//  Created by 郭人豪 on 2017/3/28.
//  Copyright © 2017年 Abner_G. All rights reserved.
//

#import "PlaceModel.h"

@implementation PlaceModel

@end
@implementation Province

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        self.cityArr = [[NSMutableArray alloc] initWithObjects:[[City alloc]init], nil];
        self.province = @"不选";
    }
    return self;
}

@end

@implementation City

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        self.districtArr = [[NSMutableArray alloc] initWithObjects:[[District alloc]init], nil];
        self.city = @"不选";
    }
    return self;
}

@end

@implementation District
- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        self.district = @"不选";
    }
    return self;
}

@end
