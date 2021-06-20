//
//  UIButton+PassValue.m
//  排序总结
//
//  Created by gjfax on 2019/12/13.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "UIButton+PassValue.h"

@implementation UIButton (PassValue)
-(NSDictionary *)paramDic{

    return objc_getAssociatedObject(self, _cmd);

}

-(void)setParamDic:(NSDictionary *)paramDic{

    objc_setAssociatedObject(self, @selector(paramDic), paramDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}


@end
