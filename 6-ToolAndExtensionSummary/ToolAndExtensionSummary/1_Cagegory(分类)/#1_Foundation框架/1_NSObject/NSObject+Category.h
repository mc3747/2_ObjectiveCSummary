
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef __nonnull id <NSObject, NSCopying> BKCancellationToken;

@interface NSObject (Category)


#pragma mark - Sending messages with variable parameters(对象本身传可变参数)
/*
 直接调用方法和用performSecector方法的区别：
 1，直接调用方法
    1，在编译时
    2，必须包含头文件
    3，检查方法是否存在，要不然编译器会报错
 2，使用performSecector方法
    1，在运行时才检查，编译时候不检查
    2，不要包含头文件
    3，不用检查方法是否存在（可使用respondsToSelector来检查，类似delegate响应方法也一样）
    4，cocoa动态支持添加方法，所以有必要
 */
//可变参数
- (nullable id)performSelectorWithArgs:(SEL)sel, ...;

//可变参数 + 延时（按钮重复点击的场合）
- (void)performSelectorWithArgs:(SEL)sel afterDelay:(NSTimeInterval)delay, ...;

//可变参数 + 回到主线程
- (nullable id)performSelectorWithArgsOnMainThread:(SEL)sel waitUntilDone:(BOOL)wait, ...;

//可变参数 + 指定主线程
- (nullable id)performSelectorWithArgs:(SEL)sel onThread:(NSThread *)thread waitUntilDone:(BOOL)wait, ...;

//可变参数 + 后台主线程
- (void)performSelectorWithArgsInBackground:(SEL)sel, ...;

//不可变参数 + 当前线程
- (void)performSelector:(SEL)sel afterDelay:(NSTimeInterval)delay;


#pragma mark - Swap method (Swizzling)
//交换实例方法的实现
+ (BOOL)swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel;

//交换类方法的实现
+ (BOOL)swizzleClassMethod:(SEL)originalSel with:(SEL)newSel;


#pragma mark - Associate value（应用在分类中不能关联属性的情况等场景）
//关联对象
- (void)setAssociateValue:(nullable id)value withKey:(void *)key;
//关联weak对象
- (void)setAssociateWeakValue:(nullable id)value withKey:(void *)key;
//获取关联对象
- (nullable id)getAssociatedValueForKey:(void *)key;
//移除所有关联对象
- (void)removeAssociatedValues;


#pragma mark - Others
//类名
+ (NSString *)className;
//类名
- (NSString *)className;
//深拷贝
- (nullable id)deepCopy;
//深拷贝并持久化
- (nullable id)deepCopyWithArchiver:(Class)archiver unarchiver:(Class)unarchiver;


#pragma mark -  是否为空对象
- (BOOL)isNilObj;


#pragma mark -  数据校验
//c语言函数：根据对象返回对应的数据类型，否则为空
NSString* GJSToString(id obj);
NSArray* GJSToArray(id obj);
NSDictionary* GJSToDictionary(id obj);
NSMutableArray* GJSToMutableArray(id obj);
NSMutableDictionary* GJSToMutableDictionary(id obj);

//oc版方法
//获取class 所有属性：数组
- (NSMutableArray *)GJSAllPropertiest;

//获取class的property和value：字典
- (NSMutableDictionary *)GJSAllPropertiestAndValues;

//重置所有对象
- (void)GJSResetAllProperty;

//获取服务器安全字典，并将字典的元素赋值给当前类的所有属性
- (void)GJSAutoSetPropertySafety:(NSDictionary *)item;

//返回标准的json值
- (NSString*)GJSJsonEncode;

//获取字典的安全value
- (id)GJSObjectFortKeySafe:(NSString*)key;

//获取数组的安全元素
- (id)GJSObjectIndexSafe:(NSUInteger)index;


#pragma mark -  添加属性
//`nonatomic` and `retain`.
- (void)bk_associateValue:(nullable id)value withKey:(const void *)key;
+ (void)bk_associateValue:(nullable id)value withKey:(const void *)key;

//`atomic` and `retain`.
- (void)bk_atomicallyAssociateValue:(nullable id)value withKey:(const void *)key;
+ (void)bk_atomicallyAssociateValue:(nullable id)value withKey:(const void *)key;

//`nonatomic` and `copy`
- (void)bk_associateCopyOfValue:(nullable id)value withKey:(const void *)key;
+ (void)bk_associateCopyOfValue:(nullable id)value withKey:(const void *)key;

//`atomic` and `copy`
- (void)bk_atomicallyAssociateCopyOfValue:(nullable id)value withKey:(const void *)key;
+ (void)bk_atomicallyAssociateCopyOfValue:(nullable id)value withKey:(const void *)key;

//weak
- (void)bk_weaklyAssociateValue:(nullable __autoreleasing id)value withKey:(const void *)key;
+ (void)bk_weaklyAssociateValue:(nullable __autoreleasing id)value withKey:(const void *)key;

#pragma mark - 获取属性
- (nullable id)bk_associatedValueForKey:(const void *)key;
+ (nullable id)bk_associatedValueForKey:(const void *)key;

#pragma mark - 移除属性
- (void)bk_removeAllAssociatedObjects;
+ (void)bk_removeAllAssociatedObjects;

#pragma mark -  指定线程，延迟后执行（可以取消，用token接，然后用token取消）
//主线程
- (BKCancellationToken)bk_performAfterDelay:(NSTimeInterval)delay usingBlock:(void (^)(id obj))block;
+ (BKCancellationToken)bk_performAfterDelay:(NSTimeInterval)delay usingBlock:(void (^)(void))block;

//后台线程
- (BKCancellationToken)bk_performInBackgroundAfterDelay:(NSTimeInterval)delay usingBlock:(void (^)(id obj))block;
+ (BKCancellationToken)bk_performInBackgroundAfterDelay:(NSTimeInterval)delay usingBlock:(void (^)(void))block;

//指定线程
- (BKCancellationToken)bk_performOnQueue:(dispatch_queue_t)queue afterDelay:(NSTimeInterval)delay usingBlock:(void (^)(id obj))block;
+ (BKCancellationToken)bk_performOnQueue:(dispatch_queue_t)queue afterDelay:(NSTimeInterval)delay usingBlock:(void (^)(void))block;

//取消block
+ (void)bk_cancelBlock:(BKCancellationToken)token;



@end

NS_ASSUME_NONNULL_END
