//
//  Common_ViewController.m
//  ReactNativeDemo
//
//  Created by gjfax on 2018/7/31.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "Common_ViewController.h"
static NSString const *imgArr[3] = {
    @"引导页1",
    @"引导页2",
    @"引导页3"
};


@interface Common_ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL isSelfDefined;
@property (nonatomic, strong) NSArray *colorArray;
@end

@implementation Common_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _colorArray = @[SXRGB16Color(0x70b5ff),SXRGB16Color(0xfff64a),SXRGB16Color(0xa8ff75),SXRGB16Color(0xff7070)];
    [self.view addSubview:self.tableView];
}
#pragma mark -  数据源
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 10, 20)];
    UIColor *color = [self getColor:section];
    label.backgroundColor = color;
    label.text = FMT_STR(@"%li,%@",(long)section,self.sectionTitleArray[section]);
    label.textColor = [color reverseColor];
    return label;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footView= [UIView new];
    return footView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.subtitleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((NSArray *)self.subtitleArray[section]).count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    /*cell重用 */
    static NSString *cellIndentifier = @"LoginAndRegistContractVCCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    NSInteger sequenceNumber = [self getSequenceNumber:self.subtitleArray indexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld,%@",(long)sequenceNumber,self.subtitleArray[indexPath.section][indexPath.row]];
    cell.textLabel.textColor = [UIColor blackColor];
    /*cell设置 */
    cell.selectionStyle = UITableViewCellSelectionStyleGray;            // 点击阴影效果
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;   // 右侧小箭头显示
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
- (NSInteger )getSequenceNumber:(NSArray *)array indexPath:(NSIndexPath *)indexPath {
    
    if (array.count == 0) {
        return 1;
        
    }else if (array.count == 1) {
        return indexPath.row;
        
    }else  {
        NSInteger count = 0;
        for (int i = 0; i< indexPath.section; i++) {
             count += ((NSArray *)array[i]).count;
        }
        return count + indexPath.row;
    };
}

#pragma mark -  点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //选中阴影消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_isSelfDefined) {
        if (self.clickBlock) {
            self.clickBlock(indexPath);
        };
        return;
    }
    
//    //跳转到Demo_ViewController
    NSString *className = self.vcNameArray[indexPath.section][indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *ctrl = class.new;
        ctrl.title = _subtitleArray[indexPath.section][indexPath.row];
        ctrl.view.backgroundColor = [UIColor lavender];
        [self.navigationController pushViewController:ctrl animated:YES];
    };
}
- (void)getSelfDefinedBlock:(ClickCellBlock)clickBlock with:(BOOL)isSelfDefined{
    _clickBlock = clickBlock;
    _isSelfDefined = isSelfDefined;
}
#pragma mark - tableView懒加载
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 49 - 64 - Top_SafeArea_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor lightGrayColor];
        _tableView.separatorStyle = UITableViewCellSelectionStyleGray;   // 灰色分割线
        _tableView.separatorColor = [UIColor lightGrayColor];             // 分割线的颜色
        
    }
    
    return _tableView;
}

- (UIColor *)getColor:(NSInteger )section {
   
    NSInteger index =  section % 4;
    return _colorArray[index];
    
}
@end
