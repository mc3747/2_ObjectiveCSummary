//
//  ArrayDataSource.m
//  slimController
//
//  Created by zhifanYoung on 16/4/12.
//  Copyright © 2016年 zhifanYoung. All rights reserved.
//

#import "ArrayDataSource.h"
#import "TestCell.h"

@interface ArrayDataSource ()

@property(strong, nonatomic) NSArray *itmes;
@property(strong, nonatomic) NSString *cellIdentifier;
@property(strong, nonatomic) NSString *cellName;

@property(copy, nonatomic) TableViewCellConfigureBlock configureBlock;

@end

@implementation ArrayDataSource

- (instancetype)initWithItems:(NSArray *)anItems cellIdentifier:(NSString *)aCellIdentifier cellName:(NSString *)cellName configureCellBlock:(TableViewCellConfigureBlock)aConfigureBlock {

    if (self = [super init]) {
     
        self.itmes = anItems;
        self.cellIdentifier = aCellIdentifier;
        self.configureBlock = aConfigureBlock;
        self.cellName = cellName;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.itmes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    if (!cell) {
        Class class = NSClassFromString(self.cellName);
        if (class) {
             cell = [[class alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:self.cellIdentifier];
        }else {
             cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:self.cellIdentifier];
        };
    }
    id item = self.itmes[indexPath.row];
    self.configureBlock(cell, item);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
