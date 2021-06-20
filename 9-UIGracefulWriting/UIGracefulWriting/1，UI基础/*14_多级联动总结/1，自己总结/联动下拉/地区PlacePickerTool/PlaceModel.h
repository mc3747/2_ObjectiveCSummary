//
//  PlaceModel.h
//  RHPlacePick
//
//  Created by 郭人豪 on 2017/3/28.
//  Copyright © 2017年 Abner_G. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Province;
@class City;
@class District;

@interface PlaceModel : NSObject

@end

@interface Province : NSObject

@property (nonatomic, copy) NSString * province;
@property (nonatomic, strong) NSMutableArray<City *> * cityArr;
@end

@interface City : NSObject

@property (nonatomic, copy) NSString * city;
@property (nonatomic, strong) NSMutableArray<District *> * districtArr;
@end

@interface District : NSObject

@property (nonatomic, copy) NSString * district;
@end
