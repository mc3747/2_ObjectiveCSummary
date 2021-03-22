//
//  AutoLayoutVC.m
//  WHLatticeDemo
//
//  Created by gjfax on 2019/1/15.
//  Copyright © 2019 remember17. All rights reserved.
//

#import "AutoLayoutVC.h"
#import "ArrayDataSource.h"
#import "TestModel.h"
#import "TestCell.h"
#import "ALiOSDemoListController.h"
#import "StackViewLayoutVC.h"
#import "FrameLayoutHeightVC.h"
#import "JsonReturnLayoutVC.h"
#import "QiFrameViewController.h"
#import "QiAutoresizingViewController.h"
#import "QiStackViewViewController.h"

@interface AutoLayoutVC ()<UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) ArrayDataSource *dataSource;
@property(strong, nonatomic) NSArray *modelArr;
@end

static NSString *const CellId = @"CellId";
@implementation AutoLayoutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TableViewCellConfigureBlock configureBlock = ^(TestCell* cell, TestModel *item) {
        
        [cell configureWithModel:item];
    };
    
    self.dataSource = [[ArrayDataSource alloc]initWithItems:self.modelArr cellIdentifier:CellId cellName:@"TestCell" configureCellBlock:configureBlock];
    
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 0){
        QiFrameViewController *vc = [[QiFrameViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if(indexPath.row == 3){
           QiAutoresizingViewController *vc = [[QiAutoresizingViewController alloc] init];
           [self.navigationController pushViewController:vc animated:YES];
           
    }else if (indexPath.row == 4) {
        // 1.获取当前的StoryBoard面板
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MasonryDemoViewController" bundle:nil];
        
        // 2.通过标识符找到对应的页面
        UIViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"MasonryDemo"];
        
        // 3.这里以push的方式加载控制器
        [self.navigationController pushViewController:vc animated:YES];
      
    }else if(indexPath.row == 5){
        ALiOSDemoListController *vc = [[ALiOSDemoListController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if(indexPath.row == 6){
        
        QiStackViewViewController *vc = [[QiStackViewViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if(indexPath.row == 7){
        
        StackViewLayoutVC *vc = [[StackViewLayoutVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if(indexPath.row == 8){
        
        FrameLayoutHeightVC *vc = [[FrameLayoutHeightVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if(indexPath.row == 9){
        
      
        
    }else if(indexPath.row == 10){
        JsonReturnLayoutVC *vc = [[JsonReturnLayoutVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        
    }
    
}

- (NSArray *)modelArr {
    
    if (!_modelArr) {
        _modelArr = [TestModel modelList];
    }
    return _modelArr;
}

@end
