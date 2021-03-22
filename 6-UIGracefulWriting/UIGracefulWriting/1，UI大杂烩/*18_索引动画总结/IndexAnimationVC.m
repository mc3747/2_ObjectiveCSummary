//
//  IndexAnimationVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/5/15.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "IndexAnimationVC.h"

@interface IndexAnimationVC ()

@end

@implementation IndexAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)demo1Action:(id)sender {
    [self pushToVCWithName:@"IndexAnimationDemo1VC"];
}

- (IBAction)demo2Action:(id)sender {
    
}

- (IBAction)demo3Action:(id)sender {
    
}

- (void)pushToVCWithName:(NSString *)vcName{
    Class class = NSClassFromString(vcName);
    UIViewController *vc = [[class alloc] init];
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
