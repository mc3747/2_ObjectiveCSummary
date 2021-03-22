//
//  Switch4_ViewController.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/9/10.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "Switch4_ViewController.h"
#import "IndicatorCustomizeViewController.h"
#import "CellCustomizeViewController.h"
#import "SpecialCustomizeViewController.h"

@interface Switch4_ViewController ()

@end

@implementation Switch4_ViewController
- (instancetype)init
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Switch4_ViewController" bundle:nil];
    Switch4_ViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Switch4_ViewController"];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.tableView.rowHeight = 44;
    self.title = @"JXCategoryView Demo";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *title = @"";
    for (UIView *subview in cell.contentView.subviews) {
        if ([subview isKindOfClass:[UILabel class]]) {
            title = [(UILabel *)subview text];
        }
    }
    
    switch (indexPath.row) {
        case 0:
        {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Switch4_ViewController" bundle:nil];
            IndicatorCustomizeViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:NSStringFromClass([IndicatorCustomizeViewController class])];
            vc.title = title;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Switch4_ViewController" bundle:nil];
            CellCustomizeViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:NSStringFromClass([CellCustomizeViewController class])];
            vc.title = title;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Switch4_ViewController" bundle:nil];
            SpecialCustomizeViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:NSStringFromClass([SpecialCustomizeViewController class])];
            vc.title = title;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}


@end
