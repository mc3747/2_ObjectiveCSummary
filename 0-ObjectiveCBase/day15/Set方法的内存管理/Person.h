//
//  Person.h
//  day15
//
//  Created by xiaomage on 15/6/24.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Room.h"

@interface Person : NSObject
{
    Room *_room;
}

- (void)setRoom:(Room *)room;
- (Room *)room;
@end
