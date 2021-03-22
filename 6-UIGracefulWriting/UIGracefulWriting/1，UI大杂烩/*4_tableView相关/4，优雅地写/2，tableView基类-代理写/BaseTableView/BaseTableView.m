/*********************************************************/
/*                                                       *
 *                                                       *
 *   Follow your heart, but take your brain with you.    *
 *                                                       *
 *                                                       *
 *********************************************************/
//
//  BaseEmptyTableView.m
//  BaseTableView
//
//  Created by 刘一峰 on 2017/7/10.
//  Copyright © 2017年 刘一峰. All rights reserved.
//

#import "BaseTableView.h"

@interface BaseTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation BaseTableView

static NSString * identifier = nil;

- (instancetype)initWithFrame:(CGRect)frame callbackIdentifier:(NSString *(^)(void))callbackIdentifier {
    self = [super initWithFrame:frame];
    if (self) {
        [self setConfigure];
        identifier = callbackIdentifier();

    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setConfigure];
    }
    return self;
}

- (void)setConfigure {
    [super setConfigure];
    self.dataSource = self;
    self.delegate = self;
}

#pragma mark UITableViewDataSource - Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSAssert(identifier != nil,@"must invok  - (instancetype) initWithFrame: callbackIdentifier: Method to init current Tableview and callback a valid parameter for identifer");
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (_callbackCell) {
        cell = self.callbackCell(cell,indexPath);
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_callbackDidSelectedCell) {
        //TODO some code
        self.callbackDidSelectedCell(nil, indexPath);
    }
}

@end
