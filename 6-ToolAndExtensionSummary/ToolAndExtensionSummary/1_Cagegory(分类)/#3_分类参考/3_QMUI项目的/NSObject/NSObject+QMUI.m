//
//  NSObject+QMUI.m
//  qmui
//
//  Created by MoLice on 2016/11/1.
//  Copyright © 2016年 QMUI Team. All rights reserved.
//

#import "NSObject+QMUI.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import <CoreData/CoreData.h>

static NSSet *foundationClasses_;
@implementation NSObject (QMUI)

- (BOOL)qmui_hasOverrideMethod:(SEL)selector ofSuperclass:(Class)superclass {
    if (![[self class] isSubclassOfClass:superclass]) {
//        NSLog(@"%s, %@ 并非 %@ 的父类", __func__, NSStringFromClass(superclass), NSStringFromClass([self class]));
        return NO;
    }
    
    if (![superclass instancesRespondToSelector:selector]) {
//        NSLog(@"%s, 父类 %@ 自己本来就无法响应 %@ 方法", __func__, NSStringFromClass(superclass), NSStringFromSelector(selector));
        return NO;
    }
    
    Method superclassMethod = class_getInstanceMethod(superclass, selector);
    Method instanceMethod = class_getInstanceMethod([self class], selector);
    if (!instanceMethod || instanceMethod == superclassMethod) {
        return NO;
    }
    return YES;
}

- (id)qmui_performSelectorToSuperclass:(SEL)aSelector {
    struct objc_super mySuper;
    mySuper.receiver = self;
    mySuper.super_class = class_getSuperclass(object_getClass(self));
    
    id (*objc_superAllocTyped)(struct objc_super *, SEL) = (void *)&objc_msgSendSuper;
    return (*objc_superAllocTyped)(&mySuper, aSelector);
}

- (id)qmui_performSelectorToSuperclass:(SEL)aSelector withObject:(id)object {
    struct objc_super mySuper;
    mySuper.receiver = self;
    mySuper.super_class = class_getSuperclass(object_getClass(self));
    
    id (*objc_superAllocTyped)(struct objc_super *, SEL, ...) = (void *)&objc_msgSendSuper;
    return (*objc_superAllocTyped)(&mySuper, aSelector, object);
}

- (void)qmui_enumrateInstanceMethodsUsingBlock:(void (^)(SEL))block {
    [NSObject qmui_enumrateInstanceMethodsOfClass:self.class usingBlock:block];
}

+ (void)qmui_enumrateInstanceMethodsOfClass:(Class)aClass usingBlock:(void (^)(SEL selector))block {
    unsigned int methodCount = 0;
    Method *methods = class_copyMethodList(aClass, &methodCount);
    
    for (unsigned int i = 0; i < methodCount; i++) {
        Method method = methods[i];
        SEL selector = method_getName(method);
        if (block) block(selector);
    }
    
    free(methods);
}

+ (void)qmui_enumerateProtocolMethods:(Protocol *)protocol usingBlock:(void (^)(SEL))block {
    unsigned int methodCount = 0;
    struct objc_method_description *methods = protocol_copyMethodDescriptionList(protocol, NO, YES, &methodCount);
    for (int i = 0; i < methodCount; i++) {
        struct objc_method_description methodDescription = methods[i];
        if (block) {
            block(methodDescription.name);
        }
    }
    free(methods);
}
#pragma mark - 数据校验
//
//NSString* GJSToString(id obj)
//{
//    return [obj isKindOfClass:[NSObject class]] ? [NSString stringWithFormat:@"%@",obj] : @"";
//}
//
//NSArray* GJSToArray(id obj)
//{
//    return [obj isKindOfClass:[NSArray class]] ? obj : nil;
//}
//
//NSDictionary* GJSToDictionary(id obj)
//{
//    return [obj isKindOfClass:[NSDictionary class]] ? obj : nil;
//}
//
//NSMutableArray* GJSToMutableArray(id obj)
//{
//    return [obj isKindOfClass:[NSArray class]] ||
//    [obj isKindOfClass:[NSMutableArray class]] ? [NSMutableArray arrayWithArray:obj] : nil;
//}
//
//NSMutableDictionary* GJSToMutableDictionary(id obj)
//{
//    return [obj isKindOfClass:[NSDictionary class]] ||
//    [obj isKindOfClass:[NSMutableDictionary class]] ? [NSMutableDictionary dictionaryWithDictionary:obj] : nil;
//}
//
//
//#pragma mark - 字典转模型 /***********==========******* */
// /*字典设置 */
//- (void)GJSAutoSetPropertySafety:(NSDictionary *)item
//{
//    if (!item || ![item isKindOfClass:[NSDictionary class]]) {
//        return;
//    }
//    //遍历所有property
//    [[self class] GJSEnumerateAllClasses:^(__unsafe_unretained Class c, BOOL *stop) {
//
//        [self setClassProperty:c withPropertyDic:item];
//
//    }];
//
//}
// /*遍历字典 */
//- (void)setClassProperty:(Class)class withPropertyDic:(NSDictionary *)item
//{
//    unsigned int outCount, i;
//    objc_property_t *properties = class_copyPropertyList(class, &outCount);
//    for (i = 0; i < outCount; i++)
//    {
//        objc_property_t property = properties[i];
//        const char *char_f = property_getName(property);
//        //property名称
//        NSString *propertyName = [NSString stringWithUTF8String:char_f];
//        id valueItem = item[propertyName];
//        if (valueItem) {
//            //获取该property的数据类型
//            const char *attries = property_getAttributes(property);
//            NSString *attrString = [NSString stringWithUTF8String:attries];
//            [self GJSSetPropery:attrString value:valueItem propertyName:propertyName];
//        }
//    }
//    if(properties) free(properties);
//}
//
///*字典转模型每个key&value设置 */
//- (void)GJSSetPropery:(NSString *)attriString
//                value:(id)value
//         propertyName:(NSString *)propertyName
//{
//    //kvc不支持c的数据类型，所以只能NSNumber转化，NSNumber可以  64位是TB
//    if ([attriString hasPrefix:@"T@\"NSString\""]) {
//        [self setValue:GJSToString(value) forKey:propertyName];
//    }
//    else if ([attriString hasPrefix:@"Tc"] || [attriString hasPrefix:@"TB"]) {
//        //32位Tc  64位TB
//        [self setValue:[NSNumber numberWithBool:[value boolValue]] forKey:propertyName];
//    }
//    else if ([attriString hasPrefix:@"Ti"] || [attriString hasPrefix:@"Tq"]) {
//        //32位 Ti是int 和 NSInteger  64位后，long 和  NSInteger 都是Tq， int 是Ti
//        [self setValue:[NSNumber numberWithInteger:[GJSToString(value) integerValue]] forKey:propertyName];
//    }
//    else if ([attriString hasPrefix:@"TQ"] || [attriString hasPrefix:@"TI"]) {
//        [self setValue:[NSNumber numberWithInteger:[GJSToString(value) integerValue]] forKey:propertyName];
//    }
//    else if ([attriString hasPrefix:@"Tl"]) { //32位 long
//        [self setValue:[NSNumber numberWithLongLong:[GJSToString(value) longLongValue]] forKey:propertyName];
//    }
//    else if ([attriString hasPrefix:@"Tf"]) { //float
//        [self setValue:[NSNumber numberWithFloat:[GJSToString(value) floatValue]] forKey:propertyName];
//    }
//    else if ([attriString hasPrefix:@"Td"]) { //CGFloat
//        [self setValue:[NSNumber numberWithDouble:[GJSToString(value) doubleValue]] forKey:propertyName];
//    }
//    else if ([attriString hasPrefix:@"T@\"NSMutableArray\""]) {
//        [self setValue:GJSToMutableArray(value) forKey:propertyName];
//    }
//    else if ([attriString hasPrefix:@"T@\"NSArray\""]) {
//        [self setValue:GJSToArray(value) forKey:propertyName];
//    }
//    else if ([attriString hasPrefix:@"T@\"NSDictionary\""]) {
//        [self setValue:GJSToDictionary(value) forKey:propertyName];
//    }
//    else if ([attriString hasPrefix:@"T@\"NSMutableDictionary\""]) {
//        [self setValue:GJSToMutableDictionary(value) forKey:propertyName];
//    }
//    else if ([attriString hasPrefix:@"T@\"NSNumber\""]) {
//        [self setValue:@([GJSToString(value) integerValue]) forKey:propertyName];
//    }
//}
//#pragma mark - 获取字典元素
// /***********==========******* */
// /*字典获取 */
//- (NSMutableDictionary *)GJSAllPropertiestAndValues
//{
//    //  获取所有propertiest
//    NSMutableDictionary *propertiestDic = [NSMutableDictionary dictionary];
//    [[self class] GJSEnumerateAllClasses:^(__unsafe_unretained Class c, BOOL *stop) {
//
//        [propertiestDic addEntriesFromDictionary:[self GJSCurClassAllPropertiestAndValues:c]];
//    }];
//    return propertiestDic;
//}
// /*获取字典元素 */
//- (NSMutableDictionary *)GJSCurClassAllPropertiestAndValues:(Class)class
//{
//    NSMutableDictionary *props = [NSMutableDictionary dictionary];
//    unsigned int outCount, i;
//    objc_property_t *properties = class_copyPropertyList(class, &outCount);
//    for (i = 0; i < outCount; i++)
//    {
//        objc_property_t property = properties[i];
//        const char *char_f = property_getName(property);
//        //property名称
//        NSString *propertyName = [NSString stringWithUTF8String:char_f];
//        if ([self valueForKey:propertyName]) {
//            [props setObject:[self valueForKey:propertyName] forKey:propertyName];
//        }
//    }
//    if(properties) free(properties);
//    return props;
//}
//
// /*字典每个key安全获取 */
//- (id)GJSObjectFortKeySafe:(NSString *)key
//{
//    if ([self isKindOfClass:[NSDictionary class]] ||
//        [self isKindOfClass:[NSMutableDictionary class]])
//    {
//        return [(NSDictionary *)self objectForKey:key];
//    }
//    return nil;
//}
//#pragma mark - 获取数组元素
// /*数组获取 */
//- (NSMutableArray *)GJSAllPropertiest
//{
//    NSMutableArray *propertiestArray = [NSMutableArray array];
//    [[self class] GJSEnumerateAllClasses:^(__unsafe_unretained Class c, BOOL *stop) {
//
//        [propertiestArray addObjectsFromArray:[c GJSCurClassAllPropertiest]];
//    }];
//
//    return propertiestArray;
//}
// /*遍历数组 */
//- (NSMutableArray *)GJSCurClassAllPropertiest
//{
//
//    NSMutableArray *props = [NSMutableArray array];
//    unsigned int outCount, i;
//    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
//    for (i = 0; i < outCount; i++)
//    {
//        objc_property_t property = properties[i];
//        const char* char_f = property_getName(property);
//        //property名称
//        NSString *propertyName = [NSString stringWithUTF8String:char_f];
//        [props addObject:propertyName];
//    }
//    if(properties) free(properties);
//    return props;
//}
// /*数组每个元素安全获取 */
//- (id)GJSObjectIndexSafe:(NSUInteger)index
//{
//    if ([self isKindOfClass:[NSArray class]] ||
//        [self isKindOfClass:[NSMutableArray class]])
//    {
//        if (index < [(NSArray *)self count]) {
//            return [(NSArray *)self objectAtIndex:index];
//        }
//        return nil;
//    }
//    return nil;
//}
//#pragma mark - 重置属性
///*重制属性 */
//- (void)GJSResetAllProperty
//{
//    //获取所有property
//    [[self class] GJSEnumerateAllClasses:^(__unsafe_unretained Class c, BOOL *stop) {
//
//        [self GJSCurClassResetAllProperty:c];
//
//    }];
//
//}
// /*重置每个元素 */
//- (void)GJSCurClassResetAllProperty:(Class)class
//{
//    //获取所有property
//    unsigned int outCount, i;
//    objc_property_t *properties = class_copyPropertyList(class, &outCount);
//    for (i = 0; i < outCount; i++)
//    {
//        objc_property_t property = properties[i];
//        const char *char_f = property_getName(property);
//        //property名称
//        NSString *propertyName = [NSString stringWithUTF8String:char_f];
//        //获取该property的数据类型
//        const char *attries = property_getAttributes(property);
//        NSString *attrString = [NSString stringWithUTF8String:attries];
//
//        [self GJSSetPropery:attrString value:nil propertyName:propertyName];
//    }
//    if(properties) free(properties);
//}
//
//
//#pragma mark - 遍历每一个属性
////  获取该之类下的所有父类 【第一个为 self class】
//+ (void)GJSEnumerateAllClasses:(void (^)(Class c, BOOL *stop))enumeration
//{
//    // 1.没有block就直接返回
//    if (enumeration == nil) return;
//    // 2.停止遍历的标记
//    BOOL stop = NO;
//    // 3.当前正在遍历的类
//    Class c = self;
//    // 4.开始遍历每一个类
//    while (c && !stop) {
//        // 4.1.执行操作
//        enumeration(c, &stop);
//        // 4.2.获得父类
//        c = class_getSuperclass(c);
//        //  如果是系统类 就终止
//        if ([self GJSIsClassFromFoundation:c]) {
//            break;
//        }
//    }
//}
//
////  需要排除的系统类， 继承于NSOject
//- (NSSet *)GJSFoundationClasses
//{
//    if (foundationClasses_ == nil) {
//        // 集合中没有NSObject，因为几乎所有的类都是继承自NSObject，具体是不是NSObject需要特殊判断
//        foundationClasses_ = [NSSet setWithObjects:
//                              [NSURL class],
//                              [NSDate class],
//                              [NSValue class],
//                              [NSData class],
//                              [NSError class],
//                              [NSArray class],
//                              [NSDictionary class],
//                              [NSString class],
//                              [NSAttributedString class], nil];
//    }
//    return foundationClasses_;
//}
//
////  是否是 系统类
//- (BOOL)GJSIsClassFromFoundation:(Class)c
//{
//    if (c == [NSObject class] ||
//        c == [NSManagedObject class]) {
//        return YES;
//    }
//
//    __block BOOL result = NO;
//    [[self GJSFoundationClasses] enumerateObjectsUsingBlock:^(Class foundationClass, BOOL *stop) {
//        if ([c isSubclassOfClass:foundationClass]) {
//            result = YES;
//            *stop = YES;
//        }
//    }];
//    return result;
//}
//
//#pragma mark - 是否为序列化的数据格式
//- (NSString *)GJSJsonEncode
//{
//    if ([self isKindOfClass:[NSArray class]] ||
//        [self isKindOfClass:[NSMutableArray class]] ||
//        [self isKindOfClass:[NSDictionary class]] ||
//        [self isKindOfClass:[NSMutableDictionary class]])
//    {
//        NSError *error = nil;
//        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
//                                                           options:NSJSONWritingPrettyPrinted
//                                                             error:&error];
//        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    }
//    return nil;
//}
//
//#pragma mark - 判断对象是否为空
//- (BOOL)isNilObj
//{
//    //  判断value是否为空
//    //  1.空对象指针nil
//    //  2.空类指针Nil
//    //  3.空对象[NSNull null]<非nil> - 不会造成容器崩溃
//    //  4.空基本数据类型NULL
//    //  5.空类[NSNull class]
//    if ([self isEqual:[NSNull null]] || nil == self || Nil == self || NULL == self) {
//        //DLog(@"isNilObj - nil obj");
//        return YES;
//    } else if ([self isKindOfClass:[NSNull class]]) {
//        //DLog(@"isNilObj - nil class");
//        return YES;
//    } else if ([self isKindOfClass:[NSString class]] && [NSString stringWithFormat:@"%@",self].length <= 0) {
//        //DLog(@"isNilObj - self is NSString && length <= 0");
//        return YES;
//    } else if ([[NSString stringWithFormat:@"%@",self] isEqualToString:@"(null)"] || [[NSString stringWithFormat:@"%@",self] isEqualToString:@"<null>"]) {
//        //  服务器返回的特殊空字符
//        return YES;
//    }
//
//    return NO;
//}

@end
