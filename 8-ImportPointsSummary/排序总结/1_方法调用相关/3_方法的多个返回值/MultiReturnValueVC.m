//
//  MultiReturnValueVC.m
//  排序总结
//
//  Created by gjfax on 2018/11/9.
//  Copyright © 2018 macheng. All rights reserved.
//

#import "MultiReturnValueVC.h"
#import "ReturnValueManager.h"

@interface MultiReturnValueVC ()

@end

@implementation MultiReturnValueVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentArray = @[@"返回字典",@"传入指针",@"返回block"];
    self.vcTitleArray = self.contentArray;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        NSString *methodString = [NSString stringWithFormat:@"test%ld",indexPath.row + 1];
        SEL selector = NSSelectorFromString(methodString);
        [self performSelector:selector withObject:nil afterDelay:0.01f];
}

#pragma mark -  1，返回字典
- (void)test1 {
    
    //返回字典
    NSDictionary *dic = [ReturnValueManager returnMoreResult1:@"20"];
    NSLog(@"返回结果%@",dic);

}

#pragma mark -  2，传入指针
- (void)test2 {
    
    //传入指针
    NSString *string1;
    NSString *string2;
    [ReturnValueManager returnMoreResult2:@"30" returnString1:&string1 returnString2:&string2];
    NSLog(@"返回结果：%@和%@",string1,string2);
}

#pragma mark -  3，返回block
- (void)test3 {
    //返回block
    [ReturnValueManager returnMoreResult3:@"40" Block:^(NSString *returnString1, NSString *returnString2) {
        NSLog(@"返回结果：%@和%@",returnString1,returnString2);
    }];
}
@end
