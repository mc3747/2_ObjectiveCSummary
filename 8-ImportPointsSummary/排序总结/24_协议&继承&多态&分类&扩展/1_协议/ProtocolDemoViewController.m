//
//  ProtocolDemoViewController.m
//  排序总结
//
//  Created by gjfax on 2020/3/9.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "ProtocolDemoViewController.h"
#import "MC_Father.h"
#import "MC_Mother.h"
#import "MC_Son.h"
#import "MC_Daughter.h"
@interface ProtocolDemoViewController ()

@end

@implementation ProtocolDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RandomBackgroundColor;
    
// 1_协议中,可以定义方法,也可以定义属性(@property,s在实现类中要么使用@synthesize,要么重写该属性的setter和getter方法)

// 2_协议方法可以用@required,@optional来修饰
    
// 3_协议方法不一定都有实现,所有拿来直接使用,可能会崩掉,要用respondsToSelector来判断
    
  //4_不同的类,都可以遵守不同的协议
    MC_Father *father = [[MC_Father alloc] init];
    father.sportType = @"力量型";
    if([father respondsToSelector:@selector(playBasketball)]){
        [father playBasketball];
    };
    if([father respondsToSelector:@selector(playFootball)]){
              [father playFootball];
    };
 
    NSLog(@"%@",father.sportType);
  
    MC_Mother *mother = [[MC_Mother alloc] init];
   mother.sportType = @"技术型";
    if([mother respondsToSelector:@selector(playBasketball)]){
          [mother playBasketball];
      };
    if([mother respondsToSelector:@selector(playFootball)]){
          [mother playFootball];
      };
   NSLog(@"%@",mother.sportType);
    
 //5_父类遵守了某个协议,子类也自动遵守
    MC_Son *son = [[MC_Son alloc] init];
    son.sportType = @"搞笑型";
    if([son respondsToSelector:@selector(playBasketball)]){
          [son playBasketball];
      };
    if([son respondsToSelector:@selector(playFootball)]){
          [son playFootball];
      };
    NSLog(@"%@",son.sportType);
    
 //6_一个类可以遵守多个协议
    MC_Daughter *daughter = [[MC_Daughter alloc] init];
    daughter.sportType = @"优雅型";
    if([daughter respondsToSelector:@selector(playBasketball)]){
          [daughter playBasketball];
      };
    if([daughter respondsToSelector:@selector(playFootball)]){
          [daughter playFootball];
      };
    if([daughter respondsToSelector:@selector(run)]){
          [daughter run];
      };
    if([daughter respondsToSelector:@selector(swim)]){
          [daughter swim];
      };
  
    NSLog(@"%@",daughter.sportType);
}







@end
