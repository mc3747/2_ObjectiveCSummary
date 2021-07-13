//
//  MJNewsViewController.m
//  Interview04-MVC-Apple
//
//  Created by MJ Lee on 2018/7/17.
//  Copyright © 2018年 MJ Lee. All rights reserved.
//

#import "MJNewsViewController.h"
#import "MJNews.h"
#import "MJShop.h"

@interface MJNewsViewController ()
@property (strong, nonatomic) NSMutableArray *newsData;
@property (strong, nonatomic) NSMutableArray *shopData;
@end

@implementation MJNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self loadNewsData];
    [self loadShopData];
}

- (void)loadShopData
{
    self.shopData = [NSMutableArray array];
    
    for (int i = 0; i < 20; i++) {
        MJShop *shop = [[MJShop alloc] init];
        shop.name = [NSString stringWithFormat:@"商品-%d", i];
        shop.price = [NSString stringWithFormat:@"￥19.%d", i];
        [self.shopData addObject:shop];
    }
}

- (void)loadNewsData
{
    self.newsData = [NSMutableArray array];
    
    for (int i = 0; i < 20; i++) {
        MJNews *news = [[MJNews alloc] init];
        news.title = [NSString stringWithFormat:@"news-title-%d", i];
        news.content = [NSString stringWithFormat:@"news-content-%d", i];
        [self.newsData addObject:news];
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.shopData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
    
    MJShop *shop = self.shopData[indexPath.row];
    
    cell.detailTextLabel.text = shop.price;
    cell.textLabel.text = shop.name;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"1111");
}

@end

