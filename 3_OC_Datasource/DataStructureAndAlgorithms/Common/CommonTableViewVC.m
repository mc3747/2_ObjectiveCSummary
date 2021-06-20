//
//  BorrowMoneyContractVC.m
//  GjFax
//
//  Created by gjfax on 2017/11/22.
//  Copyright © 2017年 GjFax. All rights reserved.
//

#import "CommonTableViewVC.h"
#import "CommonRankVC.h"


@interface CommonTableViewVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CommonTableViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _titleString;
    [self.view addSubview:self.tableView];
}

#pragma mark - tableView数据源和代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.subtitleArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = COMMON_GREY_WHITE_COLOR;
    return footerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
/*cell重用 */
    static NSString *cellIndentifier = @"LoginAndRegistContractVCCell";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    cell.textLabel.text = self.subtitleArray[indexPath.row];
    cell.textLabel.textColor = COMMON_BLACK_COLOR;
/*cell设置 */
    cell.selectionStyle = UITableViewCellSelectionStyleGray;            // 点击阴影效果
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;   // 右侧小箭头显示
    cell.backgroundColor = COMMON_WHITE_COLOR;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //选中阴影消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //跳转到VC
    [self goToVC:_subtitleArray[indexPath.row] And:indexPath];
   
}

#pragma mark - 跳转到webview
- (void)goToVC:(NSString *)subtitleString And:(NSIndexPath *)indexPath{
    switch (_classType) {
        case ClassTypeDataSouceC:
            
            break;
            
        case ClassTypeDataSouceOC:
            
            break;
            
        case ClassTypeAlgorithemC:
            
            break;
            
        case ClassTypeAlgorithemOC:
        { CommonRankVC *vc = [[CommonRankVC alloc]init];
            vc.title = subtitleString;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark - tableView懒加载
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT - 64 - IPHONE_X_Bottom_SafeArea_Height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = COMMON_GREY_WHITE_COLOR;
        _tableView.separatorStyle = UITableViewCellSelectionStyleGray;   // 灰色分割线
        _tableView.separatorColor = COMMON_LIGHT_GREY_COLOR;             // 分割线的颜色
    }
    
    return _tableView;
}
@end
