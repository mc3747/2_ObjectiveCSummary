//
//  YLSThPickerView.m
//  YLSPicker
//
//  Created by yulingsong on 16/9/1.
//  Copyright © 2016年 yulingsong. All rights reserved.
//
#define YLSRect(x, y, w, h)  CGRectMake([UIScreen mainScreen].bounds.size.width * x, [UIScreen mainScreen].bounds.size.height * y, [UIScreen mainScreen].bounds.size.width * w,  [UIScreen mainScreen].bounds.size.height * h)
#define YLSFont(f) [UIFont systemFontOfSize:[UIScreen mainScreen].bounds.size.width * f]
#define YLSColorAlpha(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define YLSMainBackColor [UIColor colorWithRed:240/255.0 green:239/255.0 blue:245/255.0 alpha:1]
#define BlueColor [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1]
#define ClearColor [UIColor clearColor]

#import "YLSThreePickerView.h"

@interface YLSThreePickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
/** view */
@property (nonatomic,strong) UIView *topView;
/** button */
@property (nonatomic,strong) UIButton *doneBtn;
/** button */
@property (nonatomic,strong) UIButton *ranBtn;
/** pickerView */
@property (nonatomic,strong) UIPickerView *pickerView;
/** array */
@property (nonatomic,strong) NSMutableArray *oneArr;
/** array */
@property (nonatomic,strong) NSMutableArray *twoArr;
/** array */
@property (nonatomic,strong) NSMutableArray *threeArr;
/** string */
@property (nonatomic,strong) NSString *result1;
/** string */
@property (nonatomic,strong) NSString *result2;
/** string */
@property (nonatomic,strong) NSString *result3;
@property (nonatomic, assign) NSInteger oneIndex;
@property (nonatomic, assign) NSInteger twoIndex;
@property (nonatomic, assign) NSInteger threeIndex;
//背景view
@property (nonatomic, strong) UIView *bgView;
@end

@implementation YLSThreePickerView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:YLSRect(0, 0, 1, 917/667)];
    
    if (self)
    {
        self.backgroundColor = YLSColorAlpha(0, 0, 0, 0.4);
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.topView = [[UIView alloc]initWithFrame:YLSRect(0, 667/667, 1, 250/667)];
    self.topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.topView];
    
    //为view上面的两个角做成圆角。不喜欢的可以注掉
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.topView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.topView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.topView.layer.mask = maskLayer;
    
    self.doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.doneBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.doneBtn setFrame:YLSRect(320/375, 5/667, 50/375, 40/667)];
    [self.doneBtn addTarget:self action:@selector(pickFinishAction) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.doneBtn];
    
    self.ranBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.ranBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.ranBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.ranBtn setFrame:YLSRect(5/375, 5/667, 100/375, 40/667)];
    [self.ranBtn addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.ranBtn];
    
    UILabel *titlelb = [[UILabel alloc]initWithFrame:YLSRect(100/375, 0, 175/375, 50/667)];
    titlelb.backgroundColor = ClearColor;
    titlelb.textAlignment = NSTextAlignmentCenter;
    titlelb.text = self.title;
    titlelb.font = YLSFont(20/375);
    [self.topView addSubview:titlelb];
    
    self.pickerView = [[UIPickerView alloc]init];
    [self.pickerView setFrame:YLSRect(0, 50/667, 1, 200/667)];
    [self.pickerView setBackgroundColor:YLSMainBackColor];
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];
    [self.pickerView selectRow:0 inComponent:0 animated:YES];
    [self.topView addSubview:self.pickerView];
    
}

//快速创建
+(instancetype)pickerView
{
    return [[self alloc]init];
}

#pragma mark -  弹出
- (void)show
{
    [self showInView:[UIApplication sharedApplication].keyWindow];
}

//添加弹出移除的动画效果
- (void)showInView:(UIView *)view
{
    self.bgView.hidden = NO;
    GJWeakSelf;
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint point = weakSelf.center;
        point.y -= 250;
        weakSelf.center = point;
    } completion:^(BOOL finished) {
        
    }];
    [view addSubview:self];
}

#pragma mark -  确定
-(void)pickFinishAction
{
    self.bgView.hidden = YES;
    GJWeakSelf;

    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alpha = 0;
        CGPoint point = weakSelf.center;
        point.y += 250;
        self.center = point;
    } completion:^(BOOL finished) {
        if (!weakSelf.result1)
        {
            weakSelf.result1 = weakSelf.oneArr[0];
        }
        if (!weakSelf.result2)
        {
            weakSelf.result2 = weakSelf.twoArr[0];
        }
        if (!weakSelf.result3)
        {
            weakSelf.result3 = weakSelf.threeArr[0];
        }
        NSString *result = [NSString stringWithFormat:@"%@ %@ %@",weakSelf.result1,weakSelf.result2,weakSelf.result3];
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"ThreeValues" object:result];
        if(weakSelf.pickBlock){
            weakSelf.pickBlock(result);
        }
        [weakSelf removeFromSuperview];
    }];
}
#pragma mark -  取消
-(void)dismiss:(UIPickerView *)picker
{
    self.bgView.hidden = YES;
    GJWeakSelf;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alpha = 0;
        CGPoint point = weakSelf.center;
        point.y += 250;
        weakSelf.center = point;
    } completion:^(BOOL finished) {
       
        [weakSelf removeFromSuperview];
    }];
}

#pragma mark -  代理方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (component == 0){
        return self.oneArr.count;
        
    }else if(component == 1){
        return self.twoArr.count;
        
    }else {
        return self.threeArr.count;
    };
}

// 返回第component列第row行的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0)
    {
        return [self.oneArr objectAtIndex:row];
        
    }else if(component == 1)
    {
        return [self.twoArr objectAtIndex:row];
        
    }else {
           return [self.threeArr objectAtIndex:row];
    }
}

// 选中第component第row的时候调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0){
     
        [self.twoArr removeAllObjects];
        for (int i = 0; i<self.array[row].cityArr.count; i++) {
            [self.twoArr addObject:self.array[row].cityArr[i].city];
        }
        
        [self.threeArr removeAllObjects];
        for (int i = 0; i<self.array[row].cityArr[0].districtArr.count; i++) {
            [self.threeArr addObject:self.array[row].cityArr[0].districtArr[i].district];
        }
    
        self.result1 = self.oneArr[row];
        self.result2 = self.twoArr[0];
        self.result3 = self.threeArr[0];
        self.oneIndex = row;

        [self.pickerView reloadComponent:1];
        [self.pickerView reloadComponent:2];
        [self.pickerView selectRow:0 inComponent:1 animated:YES];
        [self.pickerView selectRow:0 inComponent:2 animated:YES];
       
        
    }else if(component == 1){
        
        [self.threeArr removeAllObjects];
        for (int i = 0; i<self.array[_oneIndex].cityArr[row].districtArr.count; i++) {
            [self.threeArr addObject:self.array[_oneIndex].cityArr[row].districtArr[i].district];
        }
        
        self.result2 = self.twoArr[row];
        self.result3 = self.threeArr[0];
        self.twoIndex = row;
        
        [self.pickerView reloadComponent:2];
        [self.pickerView selectRow:0 inComponent:2 animated:YES];
      
    }else{
        self.result3 = self.threeArr[row];
        self.threeIndex = row;
    };
}

#pragma mark -  重写setter方法
- (void)setArray:(NSMutableArray<Province *> *)array {
    _array = array;
    [self returnOneArr];
    [self returnTwoArr];
    [self returnThreeArr];
}

#pragma mark -  标题数组
-(void)returnOneArr
{
    self.oneArr = [[NSMutableArray alloc] init];
    for (int i = 0; i<self.array.count; i++) {
       NSString *province =  self.array[i].province;
        [self.oneArr addObject:province];
    }
    self.oneIndex = 0;
    self.result1 = self.oneArr[0];
}

-(void)returnTwoArr
{
    self.twoArr = [[NSMutableArray alloc] init];
    for (int i = 0; i<self.array[0].cityArr.count; i++) {
        NSString *city =  self.array[0].cityArr[i].city;
        [self.twoArr addObject:city];
    }
    
    self.twoIndex = 0;
    self.result2 = self.twoArr[0];
}
-(void)returnThreeArr
{
    self.threeArr = [[NSMutableArray alloc] init];
    for (int i = 0; i<self.array[0].cityArr[0].districtArr.count; i++) {
        NSString *district =  self.array[0].cityArr[0].districtArr[0].district;
        [self.threeArr addObject:district];
    }
    self.threeIndex = 0;
    self.result3 = self.threeArr[0];
}
#pragma mark -  背景view
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        _bgView.frame = window.bounds;
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0.6;
        //给背景添加一个手势，后续方便移除视图
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss:)];
        [_bgView addGestureRecognizer:tap];
        [self addSubview:_bgView];
    }
    
    return _bgView;
}
@end
