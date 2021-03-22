//
//  Person.m
//  YYSaveModel
//
//  Created by yangyu on 2017/9/15.
//  Copyright © 2017年 yangyu. All rights reserved.
//

#import "YYPerson.h"
#define PersonKey @"product"

@implementation YYPerson
+ (void)setPerosnM:(YYPerson *)personM {
    NSUserDefaults *userDefalts = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:personM];
    [userDefalts setObject:data forKey:PersonKey];
    [userDefalts synchronize];
}

+ (YYPerson *)getPersonM {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:PersonKey];
    YYPerson *person = nil;
    if (data) {
        person = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return person;
}

+ (void)deletePersonM {
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:PersonKey];
}
@end
