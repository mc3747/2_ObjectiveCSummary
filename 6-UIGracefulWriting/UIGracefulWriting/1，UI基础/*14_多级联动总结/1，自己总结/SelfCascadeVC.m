//
//  SelfCascadeVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/4/11.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "SelfCascadeVC.h"
#import "PickPlaceMenu.h"
#import "FMDatabase.h"
#import "ZFButton.h"
#import "CommonData.h"
#import "YLSThreePickerView.h"
#import "YLSTwoPickerView.h"
#import "YLSOnePickerView.h"
#import "SexPickerButton.h"
#import "DatePickerButton.h"

@interface SelfCascadeVC ()
@property (nonatomic, strong) PickPlaceMenu *pullMenu1;
@property (nonatomic, strong) PickPlaceMenu *pullMenu2;
@property (nonatomic, strong) PickPlaceMenu *pullMenu3;
@property (nonatomic, strong) ZFButton *pickButton1;
@property (nonatomic, strong) ZFButton *pickButton2;
@property (nonatomic, strong) ZFButton *pickButton3;
@property (nonatomic, strong) DatePickerButton *datePickButton;
@property (nonatomic, strong) SexPickerButton *sexPickButton;
@end

@implementation SelfCascadeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addPullThreeLevel];
    [self addPullTwoLevel];
    [self addPullOneLevel];
    [self addSheetThreeLevel];
    [self addSheetTwoLevel];
    [self addSheetOneLevel];
    [self addDatePicker];
    [self addSexPicker];
}
#pragma mark -  下拉3级联动
- (void)addPullThreeLevel {
    NSMutableArray *threeLevelplaceArr =  [CommonData sharedInstance].threeLevelData;
    [self.pullMenu1 configViewWithData:threeLevelplaceArr tabNum:3 inSuperView:self.view];
}
#pragma mark -  下拉2级联动
- (void)addPullTwoLevel {
   NSMutableArray *twoLevelplaceArr =  [CommonData sharedInstance].twoLevelData;
    [self.pullMenu2 configViewWithData:twoLevelplaceArr tabNum:2 inSuperView:self.view];
    
}
#pragma mark -  下拉1级联动
- (void)addPullOneLevel {
   NSMutableArray *oneLevelplaceArr1 =  [CommonData sharedInstance].oneLevelData;
   [self.pullMenu3 configViewWithData:oneLevelplaceArr1 tabNum:1 inSuperView:self.view];
}
#pragma mark -  弹框3级联动
- (void)addSheetThreeLevel {
    NSString *defaultProvince = CommonData.sharedInstance.threeLevelData[0].province;
    NSString *defaultCity = CommonData.sharedInstance.threeLevelData[0].cityArr[0].city;
    NSString *defaultDistrict = CommonData.sharedInstance.threeLevelData[0].cityArr[0].districtArr[0].district;
    [self.pickButton1 setTitle:FMT_STR(@"%@,%@,%@",defaultProvince,defaultCity,defaultDistrict) forState:UIControlStateNormal];
    [self.pickButton1 addTarget:self action:@selector(addSheetThreeLevelAction) forControlEvents:UIControlEventTouchUpInside];
}
- (void)addSheetThreeLevelAction{
    YLSThreePickerView *picker = [[YLSThreePickerView alloc]init];
    picker.title = @"请选择行业";
    picker.array = CommonData.sharedInstance.threeLevelData;
    __block __weak typeof(_pickButton1) blockIickButton1 = _pickButton1;
    picker.pickBlock = ^(NSString * _Nonnull pickString) {
        [blockIickButton1 setTitle:pickString forState:UIControlStateNormal];
    };
    [picker show];
}
#pragma mark -  弹框2级联动
- (void)addSheetTwoLevel {
    NSString *defaultProvince = CommonData.sharedInstance.threeLevelData[0].province;
    NSString *defaultCity = CommonData.sharedInstance.threeLevelData[0].cityArr[0].city;
    [self.pickButton2 setTitle:FMT_STR(@"%@,%@",defaultProvince,defaultCity) forState:UIControlStateNormal];
     [self.pickButton2 addTarget:self action:@selector(addSheetTwoLevelAction) forControlEvents:UIControlEventTouchUpInside];
}
- (void)addSheetTwoLevelAction{
    YLSTwoPickerView *picker = [[YLSTwoPickerView alloc]init];
    picker.title = @"请选择行业";
    picker.array = CommonData.sharedInstance.twoLevelData;
    __block __weak typeof(_pickButton2) blockIickButton2 = _pickButton2;
    picker.pickBlock = ^(NSString * _Nonnull pickString) {
        [blockIickButton2 setTitle:pickString forState:UIControlStateNormal];
    };
    [picker show];
}
#pragma mark -  弹框1级联动
- (void)addSheetOneLevel {
    NSString *defaultProvince = CommonData.sharedInstance.threeLevelData[0].province;
    [self.pickButton3 setTitle:FMT_STR(@"%@",defaultProvince) forState:UIControlStateNormal];
     [self.pickButton3 addTarget:self action:@selector(addSheetOneLevelAction) forControlEvents:UIControlEventTouchUpInside];
}
- (void)addSheetOneLevelAction{
    YLSOnePickerView *picker = [[YLSOnePickerView alloc]init];
    picker.title = @"请选择行业";
    picker.array = CommonData.sharedInstance.oneLevelData;
    __block __weak typeof(_pickButton3) blockIickButton3 = _pickButton3;
    picker.pickBlock = ^(NSString * _Nonnull pickString) {
        [blockIickButton3 setTitle:pickString forState:UIControlStateNormal];
    };
    [picker show];
}

#pragma mark -  日期
- (void)addDatePicker {
    __block typeof(self.datePickButton) blockDatePickerButton = self.datePickButton;
    self.datePickButton.pickBlock = ^(NSString *pickDate) {
        [blockDatePickerButton setTitle:pickDate forState:UIControlStateNormal];
    };
}

#pragma mark -  性别
- (void)addSexPicker {
    self.sexPickButton.dataSourceArray = [NSMutableArray arrayWithObjects:@"未婚",@"已婚", nil];
    __block typeof(self.sexPickButton) blockSexPickerButton = self.sexPickButton;
    self.sexPickButton.pickBlock = ^(NSString *pickDate) {
        [blockSexPickerButton setTitle:pickDate forState:UIControlStateNormal];
    };
}

// =====================================================
/*
 懒加载
 */
// =====================================================
- (PickPlaceMenu *)pullMenu1
{
    if (!_pullMenu1) {
        _pullMenu1 = [[PickPlaceMenu alloc] initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH - 40 , 50)];
        [self.view addSubview:_pullMenu1];
    }
    
    return _pullMenu1;
}
- (PickPlaceMenu *)pullMenu2
{
    if (!_pullMenu2) {
        _pullMenu2 = [[PickPlaceMenu alloc] initWithFrame:CGRectMake(20, 80, SCREEN_WIDTH - 40 , 50)];
        [self.view addSubview:_pullMenu2];
    }
    
    return _pullMenu2;
}
- (PickPlaceMenu *)pullMenu3
{
    if (!_pullMenu3) {
        _pullMenu3 = [[PickPlaceMenu alloc] initWithFrame:CGRectMake(20, 140, SCREEN_WIDTH - 40 , 50)];
        [self.view addSubview:_pullMenu3];
    }
    
    return _pullMenu3;
}
- (ZFButton *)pickButton1
{
    if (!_pickButton1) {
        _pickButton1 = [[ZFButton alloc] initWithFrame:CGRectMake(20, 210, SCREEN_WIDTH - 40 , 50)];
        [self commonSettingWithButton:_pickButton1];
        
    }
    
    return _pickButton1;
}
- (ZFButton *)pickButton2
{
    if (!_pickButton2) {
        _pickButton2 = [[ZFButton alloc] initWithFrame:CGRectMake(20, 270, SCREEN_WIDTH - 40 , 50)];
        [self commonSettingWithButton:_pickButton2];
        
    }
    
    return _pickButton2;
}
- (ZFButton *)pickButton3
{
    if (!_pickButton3) {
        _pickButton3 = [[ZFButton alloc] initWithFrame:CGRectMake(20, 330, SCREEN_WIDTH - 40 , 50)];
        [self commonSettingWithButton:_pickButton3];
        
    }
    
    return _pickButton3;
}
- (DatePickerButton *)datePickButton
{
    if (!_datePickButton) {
        _datePickButton = [[DatePickerButton alloc] initWithFrame:CGRectMake(20, 400, SCREEN_WIDTH - 40 , 50)];
        [self commonSettingWithButton:_datePickButton];
        [_datePickButton setTitle:@"不选-不选-不选" forState:UIControlStateNormal];
        [_datePickButton setTitleColor:Wonderful_PurpleColor10 forState:UIControlStateNormal];
    }
    
    return _datePickButton;
}
- (SexPickerButton *)sexPickButton
{
    if (!_sexPickButton) {
        _sexPickButton = [[SexPickerButton alloc] initWithFrame:CGRectMake(20, 460, SCREEN_WIDTH - 40 , 50)];
        [self commonSettingWithButton:_sexPickButton];
        [_sexPickButton setTitle:@"不选" forState:UIControlStateNormal];
        [_sexPickButton setTitleColor:Wonderful_PurpleColor10 forState:UIControlStateNormal];
    }
    
    return _sexPickButton;
}
- (void)commonSettingWithButton:(ZFButton *)pickButton{
    [pickButton updateButtonStyleWithType:ZFButtonTypeRightImageLeftTitle];
    [pickButton setImage:[UIImage imageNamed:@"login_input_arrow_normal"] forState:UIControlStateNormal];
    [pickButton setImage:[UIImage imageNamed:@"login_input_arrow_click"] forState:UIControlStateSelected];
    [pickButton setViewBorderColor:[UIColor grayColor] radius:3.f border:0.5f];
    [pickButton setTitleColor:Wonderful_RedColor10 forState:UIControlStateNormal];
    [self.view addSubview:pickButton];
}
@end
