//
//  PackageEventTableViewCell.m
//  排序总结
//
//  Created by gjfax on 2019/5/10.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "PackageEventTableViewCell.h"
@interface PackageEventTableViewCell()
@property(nonatomic,strong) id target;
@property(nonatomic,assign) SEL action;
@property(nonatomic,strong) id object;
@end
@implementation PackageEventTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addBaseTarget:(id)target action:(SEL)action withObject:(id)object{
    
    
    self.target = target;
    self.action = action;
    self.object = object;
    
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    NSMethodSignature *signature = [self.target methodSignatureForSelector:self.action];
    //从签名获得调用对象
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    //设置target
    [invocation setTarget:self.target];
    //设置selector
    [invocation setSelector:self.action];
    
    //注意：设置参数的索引时不能从0开始，因为0已经被self占用，1已经被_cmd占用
    
    if (self.object) {
        id object = self.object;
        [invocation setArgument:&object atIndex:2];
    }
    //接收返回的值
    [invocation invoke];
    
    
}
@end
