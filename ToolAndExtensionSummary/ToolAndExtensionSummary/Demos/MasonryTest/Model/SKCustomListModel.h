//
//  SKCustomListModel.h
//  MasonryFirDemo
//
//  Created by shavekevin on 16/4/25.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKCustomListModel : NSObject


@property(nonatomic, assign) BOOL hasTag;

@property(nonatomic, assign) BOOL hasData;

@property(nonatomic, copy) NSString * title;

@property(nonatomic, copy) NSString * content;

@property(nonatomic, assign) BOOL hasPic;

@property(nonatomic, assign) NSInteger type;

/**
 *  @brief cellHeight
 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
