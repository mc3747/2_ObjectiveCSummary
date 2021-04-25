//
//  ViewController.m
//  TableViewIndex
//
//  Created by lujh on 2017/9/5.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "IndexAnimationDemo1VC.h"
#import "SectionIndexItem.h"
#import "SectionIndexView.h"
#import "MJExtension.h"
#import "FriendModel.h"
#import "THDepModelTool.h"

#define kSectionIndexWidth 40.f
#define kSectionItemHeight 20.f

@interface IndexAnimationDemo1VC ()<DSectionIndexViewDelegate,DSectionIndexViewDataSource,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
// 索引sectionIndexView
@property (strong, nonatomic) SectionIndexView *sectionIndexView;
// tableview
@property (nonatomic, strong) UITableView *tableview;
// 滚动的偏移量
@property (nonatomic,assign) CGFloat oldY;
// 当前显示的组头
@property (nonatomic,assign) NSUInteger currentSection;
// 是否是上拉滚动
@property (nonatomic,assign) BOOL isUpScroll;
// 是否第一次加载tableView
@property (nonatomic,assign) BOOL isFirstLoad;
// 数据字典dataDic
@property (nonatomic, strong) NSDictionary *dataDic;
// indexArray
@property (nonatomic, strong) NSArray *indexArray;
// netArray
@property (nonatomic, strong) NSArray *netArray;
// 是否点击isClick
@property (nonatomic, assign) BOOL isClick;
@end

@implementation IndexAnimationDemo1VC


#pragma mark - defalt

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"索引动画1";
    
    [self _createData];
    
    [self _initTableView];
    
    [self _initIndexView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.sectionIndexView reloadItemViews];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGFloat H = kSectionItemHeight*self.indexArray.count;
    _sectionIndexView.frame = CGRectMake(CGRectGetWidth(self.tableview.frame) - kSectionIndexWidth -10, (CGRectGetHeight(self.tableview.frame) - H)/2, kSectionIndexWidth, H);
    _sectionIndexView.layer.cornerRadius = 12;
    [_sectionIndexView setBackgroundViewFrame];
}

#pragma mark - private

- (void)_initIndexView
{
    _sectionIndexView = [[SectionIndexView alloc] init];
    _sectionIndexView.backgroundColor = [UIColor greenColor];
    _sectionIndexView.dataSource = self;
    _sectionIndexView.delegate = self;
    _sectionIndexView.isShowCallout = YES;
    _sectionIndexView.calloutViewType = CalloutViewTypeForUserDefined;
    _sectionIndexView.calloutDirection = SectionIndexCalloutDirectionLeft;
    _sectionIndexView.calloutMargin = 100.f;
    [self.view addSubview:self.sectionIndexView];
}

- (void)_initTableView
{
    _tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    _tableview.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableview];
    
    _isFirstLoad = YES;
}

- (void)_createData
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"friends.plist" ofType:nil];
    // 模型数组
    self.netArray = [FriendModel mj_objectArrayWithFile:path];
    // 数据源
    self.dataDic = [THDepModelTool sortWithDataArray:_netArray andPropertyName:@"name"];
    // 所有 key 组头
    self.indexArray = [THDepModelTool sortFirstStrWithArray:self.dataDic.allKeys];
}




#pragma mark UITableViewDataSource && delegate method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    // 索引定组
    return self.indexArray.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *value = [self.dataDic objectForKey:_indexArray[section]];
    // 根据索引取值, 取完返回
    return value.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cellindex";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    NSArray *value = [_dataDic objectForKey:_indexArray[indexPath.section]];
    FriendModel *model = value[indexPath.row];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.pic;
    
    return cell;
}

#pragma mark 组头
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return self.indexArray[section];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 30;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    view.backgroundColor = [UIColor cyanColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
    label.text = [self.indexArray objectAtIndex:section];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor redColor];
    [view addSubview:label];
    return view;
}

#pragma mark DSectionIndexViewDataSource && delegate method
- (NSInteger)numberOfItemViewForSectionIndexView:(SectionIndexView *)sectionIndexView
{
    return self.tableview.numberOfSections;
}

- (SectionIndexItem *)sectionIndexView:(SectionIndexView *)sectionIndexView itemViewForSection:(NSInteger)section
{
    SectionIndexItem *itemView = [[SectionIndexItem alloc] init];
    itemView.titleLabel.text = [self.indexArray objectAtIndex:section];
    itemView.titleLabel.font = [UIFont systemFontOfSize:12];
    itemView.titleLabel.textColor = [UIColor darkGrayColor];
    itemView.titleLabel.highlightedTextColor = [UIColor redColor];
    itemView.titleLabel.shadowColor = [UIColor whiteColor];
    itemView.titleLabel.shadowOffset = CGSizeMake(0, 1);
    [itemView setSelected:YES animated:YES];
    itemView.titleLabel.tag = section +1;
    return itemView;
}

- (UIView *)sectionIndexView:(SectionIndexView *)sectionIndexView calloutViewForSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 80, 80);
    label.center = self.view.center;
    label.text = [self.indexArray objectAtIndex:section];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor redColor];
    label.font = [UIFont boldSystemFontOfSize:36];
    label.textAlignment = NSTextAlignmentCenter;
    [label.layer setCornerRadius:label.frame.size.width/2];
    [label.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [label.layer setBorderWidth:3.0f];
    [label.layer setShadowColor:[UIColor blackColor].CGColor];
    [label.layer setShadowOpacity:0.8];
    [label.layer setShadowRadius:5.0];
    [label.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    return label;
}

- (NSString *)sectionIndexView:(SectionIndexView *)sectionIndexView
               titleForSection:(NSInteger)section
{
    return [self.indexArray objectAtIndex:section];
}

- (void)sectionIndexView:(SectionIndexView *)sectionIndexView didSelectSection:(NSInteger)section
{
    
    self.isClick = YES;
    
    UILabel *label = [self.view viewWithTag:section+1];
    
    
    for (int i = 1; i<=self.indexArray.count; i++) {
        
        UILabel *otherLabel = [self.view viewWithTag:i];
        
        if (section != i -1) {
            
            otherLabel.font = [UIFont systemFontOfSize:12];
        }
        
        if (section == i-1) {
            
            label.font = [UIFont systemFontOfSize:20];
        }
    }
    
    
    [self.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}




- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    
    
    // 向下
    if(!_isUpScroll && (_currentSection - section) == 1&&self.isClick == NO){
        
        //最上面组头（不一定是第一个组头，指最近刚被顶出去的组头）又被拉回来
        
        _currentSection = section;
        
        UILabel *label = [self.view viewWithTag:section+1];
        
        
        for (int i = 1; i<=self.indexArray.count; i++) {
            
            UILabel *otherLabel = [self.view viewWithTag:i];
            
            if (section != i -1) {
                
                otherLabel.font = [UIFont systemFontOfSize:12];
            }
            
            if (section == i-1) {
                
                label.font = [UIFont systemFontOfSize:20];
            }
        }
        
    }
    
}


- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section{
    
    // 向上
    if(!_isFirstLoad && _isUpScroll&&self.isClick == NO){
        
        _currentSection = section + 1;
        
        UILabel *label = [self.view viewWithTag:section+2];
        
        UILabel *firstLabel = [self.view viewWithTag:section +1];
        firstLabel.font = [UIFont systemFontOfSize:12];
        
        for (int i = 2; i<=self.indexArray.count; i++) {
            
            UILabel *otherLabel = [self.view viewWithTag:i];
            
            if ((section +1)!= i -1) {
                
                otherLabel.font = [UIFont systemFontOfSize:12];
            }
            
            if ((section +1) == i-1) {
                
                label.font = [UIFont systemFontOfSize:20];
            }
        }
        
    }
    
}

#pragma mark -UIScrollViewDelegate
int _lastPosition;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    int currentPostion = scrollView.contentOffset.y;
    
    if (currentPostion - _lastPosition > 0.01) {
        _lastPosition = currentPostion;
        _isUpScroll = YES;
        
    }
    else if (_lastPosition - currentPostion > 0.01)
    {
        _lastPosition = currentPostion;
        _isUpScroll = NO;
        
    }
    
    _isFirstLoad = NO;
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{

    self.isClick = NO;
}

@end
