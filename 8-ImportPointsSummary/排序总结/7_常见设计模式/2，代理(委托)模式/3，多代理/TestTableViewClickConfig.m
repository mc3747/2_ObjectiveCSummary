//
//  TestTableViewClickConfig.m
//  YbProxyCuttingModule
//
//  Created by 杨少 on 2018/3/30.
//  Copyright © 2018年 杨波. All rights reserved.
//

#import "TestTableViewClickConfig.h"

@implementation TestTableViewClickConfig

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"click -- section:%ld, row:%ld", indexPath.section, indexPath.row);
}

@end
