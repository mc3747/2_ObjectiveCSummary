//
//  ViewController.m
//  AutoCompleteTextViewDemo
//
//  Created by 白仕云 on 2018/6/13.
//  Copyright © 2018年 BSY.com. All rights reserved.
//

#import "InputHistoryVC.h"
#import "AutoCompleteTextView.h"

@interface InputHistoryVC ()

@end

@implementation InputHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];


      NSArray *temp  =@[@"1",@"3",@"3444",@"7835y398475y",@"tt4443",@"%332gh",@"123344444",@"66555"];

    AutoCompleteTextView *searchText = [[AutoCompleteTextView alloc]initWithFrame:CGRectMake(50, 100, 200, 44) superView:self.view];
    [self.view addSubview:searchText];
    searchText.dataArray = [temp mutableCopy];

    __weak typeof(searchText)weakSearchText   = searchText;
    [searchText setBSYAutoCompleteShowChange:^(NSIndexPath *indexPath, AutoCompleteShowListCell *cell, id cellObj) {
        cell.showText.text = cellObj;
    }];

    [searchText setDidSelectRowAtIndexPathChange:^(NSIndexPath *indexPath, AutoCompleteShowListCell *cell, id cellObj) {
        weakSearchText.text = cellObj;
    }];

    [searchText setAutoCompleteTextViewTextFieldTextChange:^(NSString *searchTextString) {
        NSMutableArray *rr  =[NSMutableArray array];
        for (int index=0; index<temp.count; index++) {
            if ([[temp objectAtIndex:index] containsString:searchTextString]) {
                [rr addObject:[temp objectAtIndex:index]];
            }
        }
        weakSearchText.dataArray = rr;
    }];

}



@end
