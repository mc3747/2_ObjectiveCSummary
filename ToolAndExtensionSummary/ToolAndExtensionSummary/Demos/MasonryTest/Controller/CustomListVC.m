//
//  CustomListViewController.m
//  MasonryFirDemo
//
//  Created by shavekevin on 16/4/25.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "CustomListVC.h"
#import "CustomListCell.h"
#import "SKCustomListModel.h"

static NSString *const cellIdentifier = @"cellIdentifier";

@interface CustomListVC ()
<
UITableViewDataSource,
UITableViewDelegate
>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSourceArr;
/**
 *  临时cell
 */
@property (nonatomic, strong) CustomListCell *tempCell;

@end


@implementation CustomListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"滚动到某一行" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setFrame:CGRectMake(200, 30, 100, 30)];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
    }
    return self.dataSourceArr.count;
}
- (void)tap{
    //让tableview滚动到指定行
    //. 1. 设置tableview的偏移量
    /*
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    CGRect frame = [self.tableView rectForSection:indexPath.section];
    
    [self.tableView setContentOffset:CGPointMake(0, frame.origin.y) animated:YES];
     */
    /**
     *  2.首先使用selectRowAtIndexes: 选择行数，scrollview滚动到某个position 就计算这个position position = table row height * index，便得到滚动的位置了
     */
   //  UITableViewScrollPositionBottom  滚动到第某section 某row 的底部
    /*
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]
     
                                animated:YES
     
                          scrollPosition:UITableViewScrollPositionTop];
     */
    /*
    
    typedef NS_ENUM(NSInteger, UITableViewScrollPosition) {
     // 默认
        UITableViewScrollPositionNone,
     // 滚动到第某section 某row 的顶部
        UITableViewScrollPositionTop,
     //  中间
        UITableViewScrollPositionMiddle,
     // 滚动到第某section 某row 的底部
        UITableViewScrollPositionBottom
    };
*/
    
// 3. 实现原理同2 这个是scrollview 的滚动效果
    [self.tableView scrollToRowAtIndexPath: [NSIndexPath indexPathForRow:4 inSection:0]
     
                           atScrollPosition: UITableViewScrollPositionMiddle animated: YES ];
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *view = [UILabel new];
    view.frame  =CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 20);
    
    {
        view.backgroundColor = [UIColor orangeColor];
        view.text = @"2222222";
    }
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 20;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",indexPath.row);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    SKCustomListModel * model = [self.dataSourceArr objectAtIndex:indexPath.row];
    [cell setModel:model];
    [cell layOutViews];
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //0.5 to 1.0,away from black
    cell.contentView.backgroundColor =  [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SKCustomListModel * model = [self.dataSourceArr objectAtIndex:indexPath.row];
    [self.tempCell setModel:model];
    if (model.cellHeight <= 0) {
        return [self.tempCell calculateHeight];
    }
    return model.cellHeight;
}

#pragma mark |----- lazy load
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[CustomListCell class] forCellReuseIdentifier:cellIdentifier];
    }
    return _tableView;
}
- (CustomListCell *)tempCell {
    if (!_tempCell) {
        _tempCell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    return _tempCell;
}

- (NSMutableArray *)dataSourceArr{
    if (!_dataSourceArr) {
        
        NSString * str = @"sdklahdlahsdl;hsadhioqhwdoihoid;shai极好的；啊哈哈上登陆撒谎的拉开；导航栏；按说的撒肯定会来撒会带来；傻掉了；啥都上课的挥洒；来看待和拉萨客户端来看撒谎的其实偶怕；发货吧；石板房；拉萨；大厦；啥的；啥领导力；啥的；拉伸的；阿萨德了；hash； sdklahdlahsdl;hsadhioqhwdoihoid;shai极好的；啊哈哈上登陆撒谎的拉开；导航栏；按说的撒肯定会来撒会带来；傻掉了；啥都上课的挥洒；来看待和拉萨客户端来看撒谎的其实偶怕；发货吧；石板房；拉萨；大厦；啥的；啥领导力；啥的；拉伸的；阿萨德了；hash； sdklahdlahsdl;hsadhioqhwdoihoid;shai极好的；啊哈哈上登陆撒谎的拉开；导航栏；按说的撒肯定会来撒会带来；傻掉了；啥都上课的挥洒；来看待和拉萨客户端来看撒谎的其实偶怕；发货吧；石板房；拉萨；大厦；啥的；啥领导力；啥的；拉伸的；阿萨德了；hash； sdklahdlahsdl;hsadhioqhwdoihoid;shai极好的；啊哈哈上登陆撒谎的拉开；导航栏；按说的撒肯定会来撒会带来；傻掉了；啥都上课的挥洒；来看待和拉萨客户端来看撒谎的其实偶怕；发货吧；石板房；拉萨；大厦；啥的；啥领导力；啥的；拉伸的；阿萨德了；hash； sdklahdlahsdl;hsadhioqhwdoihoid;shai极好的；啊哈哈上登陆撒谎的拉开；导航栏；按说的撒肯定会来撒会带来；傻掉了；啥都上课的挥洒；来看待和拉萨客户端来看撒谎的其实偶怕；发货吧；石板房；拉萨；大厦；啥的；啥领导力；啥的；拉伸的；阿萨德了；hash； ";
        
        _dataSourceArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < 100; i++) {
            SKCustomListModel * model = [[SKCustomListModel alloc] init];
            model.hasTag = (i % 3 == 2);
            model.title = [NSString stringWithFormat:@"%zd%@", i, [str substringToIndex:i]];
            model.content = [str substringFromIndex:i];
            model.hasPic = (i % 5 == 3);
            model.type = ((i % 2 == 0) ? 1 : 2);
            [_dataSourceArr addObject:model];
        }
    }
    return _dataSourceArr;
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSArray *array  = [self.tableView visibleCells];
    CustomListCell *cell = array[1];
   CGRect rect =   [self.view convertRect:cell.picImageView.frame fromView:cell];
    CGRect rect2 =   [self.view convertRect:cell.collectionControl.frame fromView:cell];
    NSLog(@"%f",rect.origin.y);
    NSLog(@"%f",rect2.origin.y);

    
}

@end
