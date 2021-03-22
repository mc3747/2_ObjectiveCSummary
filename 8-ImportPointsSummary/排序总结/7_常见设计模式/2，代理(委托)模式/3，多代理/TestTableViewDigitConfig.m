//
//  TestTableViewDigitConfig.m
//  YbProxyCuttingModule
//
//  Created by 杨少 on 2018/3/30.
//  Copyright © 2018年 杨波. All rights reserved.
//

#import "TestTableViewDigitConfig.h"

@implementation TestTableViewDigitConfig

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

@end
