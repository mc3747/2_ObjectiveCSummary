//
//  PickPlaceView.m
//  RHPlacePick
//
//  Created by 郭人豪 on 2017/3/28.
//  Copyright © 2017年 Abner_G. All rights reserved.
//

#import "PickPlaceView.h"

#define Cell_Place    @"Cell_Place"
@interface PickPlaceView () <UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataArr;

@end
@implementation PickPlaceView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
         [self addSubview:self.tableView];
    }
    return self;
}

#pragma mark - public method
- (void)reloadViewWithData:(NSArray *)dataArr  {
    
    self.dataArr = [NSMutableArray arrayWithArray:dataArr];
    [_tableView reloadData];
    [self show:self.bounds.size.height];
   
}

#pragma mark -  下拉顶部不要穿透
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    float offset = scrollView.contentOffset.y;
    if (offset <= 0) {
        [scrollView setContentOffset:CGPointMake(0, 0)];
    }
}

#pragma mark - tableView dataSource and delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:Cell_Place forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell_Place];
    }
    if (indexPath.row < self.dataArr.count) {
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.text = _dataArr[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.5f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = Wonderful_GrayColor3;
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *place = self.dataArr[indexPath.row];
    
    if (self.clickListCellBlock) {
        self.clickListCellBlock(indexPath.row, place);
    }
    [self hide];
}
#pragma mark - 展示
- (void)show:(CGFloat)tableHeight {
    self.hidden = NO;
    _tableView.frame = CGRectMake(0, -44, self.bounds.size.width, tableHeight);
    GJWeakSelf;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.alpha = 1.f;
        weakSelf.backgroundColor = SXRGBAColor(0, 0, 0, 0.3);
        
        weakSelf.tableView.frame = CGRectMake(0, 0, weakSelf.size.width, tableHeight);
    }];
}
#pragma mark -  隐藏
- (void)hide {
     GJWeakSelf;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.alpha = 0.f;
        weakSelf.backgroundColor = SXRGBAColor(0, 0, 0, 0);
        weakSelf.tableView.frame = CGRectMake(0,-44, weakSelf.size.width, weakSelf.size.height);
    } completion:^(BOOL finished) {
        
        weakSelf.hidden = YES;
    }];
}

#pragma mark - setter and getter

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = SXRGBAColor(0, 0, 0, 0);
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:Cell_Place];
        UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewTouchInSide)];
        tableViewGesture.numberOfTapsRequired = 1;//几个手指点击
        tableViewGesture.delegate = self;
        [_tableView addGestureRecognizer:tableViewGesture];
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}
//tableView添加空白处的点击
- (void)tableViewTouchInSide{
    [self hide];
    
}
//tableViewCell的点击事件拦截
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UITableView class]]) {
        return YES;
    }
    
    return  NO;
}

- (NSMutableArray *)dataArr {
    
    if (!_dataArr) {
        
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}


@end
