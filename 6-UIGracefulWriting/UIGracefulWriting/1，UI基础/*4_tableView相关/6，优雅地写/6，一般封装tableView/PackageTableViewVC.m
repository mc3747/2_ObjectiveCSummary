//
//  PackageTableViewVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/4/24.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "PackageTableViewVC.h"
#import "HActiveTableView.h"

@interface PackageTableViewVC ()

@end

@implementation PackageTableViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
        HActiveTableView *tableView = [[HActiveTableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        [self .view addSubview:tableView];
    
        tableView.dataArray  =[NSMutableArray arrayWithObjects:@"ewew",@"ewew" ,@"ewew",@"ewew",@"ewew" ,@"ewew",@"ewew",@"ewew" ,@"ewew",@"ewew",@"ewew" ,@"ewew",@"ewew",@"ewew" ,@"ewew",@"ewew",@"ewew" ,@"ewew",@"ewew",@"ewew" ,@"ewew",@"ewew",@"ewew" ,@"ewew",@"ewew",@"ewew" ,@"ewew",@"ewew",@"ewew" ,@"ewew",@"ewew",@"ewew" ,@"ewew",nil];
        [tableView setGetCell_HActiveTableView:^(UITableViewCell * _Nonnull cell, NSIndexPath * _Nonnull cellIndexPath) {
            CGRect rect  =CGRectMake(0, 0, self.view.frame.size.width, 100.0);
            if (cellIndexPath.row==0) {
                UIView *view  =[[UIView alloc]initWithFrame:rect];
                view.backgroundColor = [UIColor redColor];
                [cell addSubview:view];
            }else if(cellIndexPath.row==1){
                UIView *view  =[[UIView alloc]initWithFrame:rect];
                view.backgroundColor = [UIColor blueColor];
                [cell addSubview:view];
            }else if (cellIndexPath.row==2){
                UIView *view  =[[UIView alloc]initWithFrame:rect];
                view.backgroundColor = [UIColor yellowColor];
                [cell addSubview:view];
            }
        }];
    
        [tableView setDidSelectRowCell_HActiveTableView:^(UITableViewCell * _Nonnull cell, NSIndexPath * _Nonnull cellIndexPath) {
    
    
        }];
}



@end
