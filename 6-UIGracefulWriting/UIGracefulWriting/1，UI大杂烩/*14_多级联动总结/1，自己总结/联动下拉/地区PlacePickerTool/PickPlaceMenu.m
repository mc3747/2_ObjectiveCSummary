//
//  PickPlaceMenu.m
//  RHPlacePick
//
//  Created by 郭人豪 on 2017/3/28.
//  Copyright © 2017年 Abner_G. All rights reserved.
//

#import "PickPlaceMenu.h"
#import "ZFButton.h"
#import "Masonry.h"
#import "PickPlaceView.h"


@interface PickPlaceMenu ()
@property (nonatomic, assign) NSUInteger tabNum;
@property (nonatomic, strong) ZFButton * btn_province;
@property (nonatomic, strong) ZFButton * btn_city;
@property (nonatomic, strong) ZFButton * btn_district;
@property (nonatomic, strong) PickPlaceView *list_province;
@property (nonatomic, strong) PickPlaceView *list_city;
@property (nonatomic, strong) PickPlaceView *list_district;
@property (nonatomic, assign)  NSInteger provinceIndex;
@property (nonatomic, assign)  NSInteger cityIndex;
@property (nonatomic, assign)  NSInteger districtIndex;
@property (nonatomic, assign)  NSString *provinceString;
@property (nonatomic, assign)  NSString *cityString;
@property (nonatomic, assign)  NSString *districtString;
@property (nonatomic, strong) NSMutableArray<Province *> *dataArray;
@property (nonatomic, strong) UIView *superView;
@end

@implementation PickPlaceMenu

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.provinceIndex = 0;
        self.cityIndex = 0;
        self.districtIndex = 0;
        self.provinceString = self.dataArray[0].province;
        self.cityString = ((City *)self.dataArray[0].cityArr[0]).city;
        self.districtString = ((District *)((City *)self.dataArray[0].cityArr[0]).districtArr[0]).district;
        [self addSubviews];
    }
    return self;
}
#pragma mark - 添加
- (void)addSubviews {
    [self addSubview:self.btn_province];
    [self addSubview:self.btn_city];
    [self addSubview:self.btn_district];
}

#pragma mark -  布局
- (void)layoutSubviews {
    [super layoutSubviews];
    float width = self.bounds.size.width;
//  1个tab
    GJWeakSelf;
        [_btn_province mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(@((width - (weakSelf.tabNum - 1)*5)/weakSelf.tabNum));
            make.top.mas_equalTo(@0);
            make.bottom.mas_equalTo(@-1);
            make.left.mas_equalTo(@0);
        }];
        [_btn_province updateButtonStyleWithType:ZFButtonTypeRightImageLeftTitle];
    
//  2个tab
    if (_tabNum == 3 || _tabNum == 2) {
      
        [_btn_city mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(@((width - (weakSelf.tabNum - 1)*5)/weakSelf.tabNum));
            make.top.mas_equalTo(@0);
            make.bottom.mas_equalTo(@-1);
            make.left.mas_equalTo(weakSelf.btn_province.mas_right).offset(5);
        }];
        [_btn_city updateButtonStyleWithType:ZFButtonTypeRightImageLeftTitle];

    }else {
        _btn_city.hidden = YES;
    }
  
//  3个tab
    if (_tabNum == 3 ) {
   
        [_btn_district mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(@((width - (weakSelf.tabNum - 1)*5)/weakSelf.tabNum));
            make.top.mas_equalTo(@0);
            make.bottom.mas_equalTo(@-1);
            make.left.mas_equalTo(weakSelf.btn_city.mas_right).offset(5);
        }];
        [_btn_district updateButtonStyleWithType:ZFButtonTypeRightImageLeftTitle];
        
    }else {
        _btn_district.hidden = YES;

    };
    
}

#pragma mark - 配置
- (void)configViewWithData:(NSMutableArray<Province *> *)dataArray tabNum:(NSUInteger)tabNum inSuperView:(UIView *)superView{
    _dataArray = dataArray;
    _tabNum = tabNum;
    _superView = superView;
    Province *province = dataArray.firstObject;
    City *city = province.cityArr.firstObject;
    District *district = city.districtArr.firstObject;
    
    if (province) {
        [_btn_province setTitle:province.province forState:UIControlStateNormal];
    }
    
    if (city) {
        [_btn_city setTitle:city.city forState:UIControlStateNormal];
    }
    
    if (district) {
        [_btn_district setTitle:district.district forState:UIControlStateNormal];
    }
}

#pragma mark -  复原
- (void)resetBtnState {
    if (_btn_province.selected) {
        _btn_province.selected = NO;
    }
    
    if (_btn_city.selected) {
        _btn_city.selected = NO;
    }
    
    if (_btn_district.selected) {
        _btn_district.selected = NO;
    }
}

#pragma mark - 点击省
- (void)clickSelectProvince:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    _btn_city.selected = NO;
    _btn_district.selected = NO;
    [self.list_city hide];
    [self.list_district hide];
    if (!sender.selected) {
        [self.list_province hide];
        return;
    };
    NSMutableArray *provinceArray =  [[NSMutableArray alloc] init];
    for (int i = 0; i<self.dataArray.count; i++) {
        [provinceArray addObject:self.dataArray[i].province];
    }
    [self.list_province reloadViewWithData:provinceArray];
    GJWeakSelf;
    self.list_province.clickListCellBlock = ^(NSInteger cellIndex, NSString *cellString) {
        
        if (weakSelf.clickMenuBlock) {
            weakSelf.clickMenuBlock(cellString, weakSelf.cityString, weakSelf.districtString);
        };
        weakSelf.provinceIndex = cellIndex;
        weakSelf.provinceString = cellString;
        [weakSelf.btn_province setTitle:cellString forState:UIControlStateNormal];
        [weakSelf resetBtnState];
    };
}
#pragma mark -  点击市
- (void)clickSelectCity:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    _btn_province.selected = NO;
    _btn_district.selected = NO;
    [self.list_province hide];
    [self.list_district hide];
    if (!sender.selected) {
        [self.list_city hide];
        return;
    };
    NSMutableArray *cityArray =  [[NSMutableArray alloc] init];
    for (int i = 0; i<self.dataArray[_provinceIndex].cityArr.count; i++) {
        City *city = self.dataArray[_provinceIndex].cityArr[i];
        [cityArray addObject:city.city];
    }
    [self.list_city reloadViewWithData:cityArray];
    GJWeakSelf;
    self.list_city.clickListCellBlock = ^(NSInteger cellIndex, NSString *cellString) {
        if (weakSelf.clickMenuBlock) {
            weakSelf.clickMenuBlock(weakSelf.provinceString, cellString, weakSelf.districtString);
        };
        weakSelf.cityIndex = cellIndex;
        weakSelf.cityString = cellString;
        [weakSelf.btn_city setTitle:cellString forState:UIControlStateNormal];
         [weakSelf resetBtnState];
    };
}
#pragma mark -  点击区
- (void)clickSelectDistrict:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    _btn_province.selected = NO;
    _btn_city.selected = NO;
    [self.list_province hide];
    [self.list_city hide];
    if (!sender.selected) {
        [self.list_district hide];
        return;
    };
    NSMutableArray *districtArray =  [[NSMutableArray alloc] init];
    for (int i = 0; i<self.dataArray[_provinceIndex].cityArr[_cityIndex].districtArr.count; i++) {
        District *district = self.dataArray[_provinceIndex].cityArr[_cityIndex].districtArr[i];
        [districtArray addObject:district.district];
    }
    [self.list_district reloadViewWithData:districtArray];
    GJWeakSelf;
    self.list_district.clickListCellBlock = ^(NSInteger cellIndex, NSString *cellString) {
        if (weakSelf.clickMenuBlock) {
            weakSelf.clickMenuBlock(weakSelf.provinceString, weakSelf.cityString, cellString);
        };
        weakSelf.districtIndex = cellIndex;
        weakSelf.districtString = cellString;
        [weakSelf.btn_district setTitle:cellString forState:UIControlStateNormal];
        [weakSelf resetBtnState];
    };
}


#pragma mark - setter and getter

- (ZFButton *)btn_province {
    
    if (!_btn_province) {
        _btn_province = [ZFButton zfButtonWithType:ZFButtonTypeRightImageLeftTitle];;
        _btn_province.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btn_province.titleLabel adjustsFontSizeToFitWidth];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 206/255.f, 206/255.f, 206/255.f, 1 });
        [_btn_province.layer setBorderColor:colorref];
        [_btn_province.layer setBorderWidth:0.5f];
        [_btn_province.layer setCornerRadius:3.f];
        [_btn_province setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn_province setTitleColor:SXRGB16Color(0xD34A19) forState:UIControlStateSelected];
        [_btn_province setImage:[UIImage imageNamed:@"login_input_arrow_normal"] forState:UIControlStateNormal];
        [_btn_province setImage:[UIImage imageNamed:@"login_input_arrow_click"] forState:UIControlStateSelected];
        [_btn_province addTarget:self action:@selector(clickSelectProvince:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_province;
}

- (ZFButton *)btn_city {
    
    if (!_btn_city) {
        _btn_city = [ZFButton zfButtonWithType:ZFButtonTypeRightImageLeftTitle];;
        _btn_city.titleLabel.font = [UIFont systemFontOfSize:14];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 206/255.f, 206/255.f, 206/255.f, 1 });
        [_btn_city.layer setBorderColor:colorref];
        [_btn_city.layer setBorderWidth:0.5f];
        [_btn_city.layer setCornerRadius:3.f];
        [_btn_city setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn_city setTitleColor:SXRGB16Color(0xD34A19) forState:UIControlStateSelected];
        [_btn_city setImage:[UIImage imageNamed:@"login_input_arrow_normal"] forState:UIControlStateNormal];
        [_btn_city setImage:[UIImage imageNamed:@"login_input_arrow_click"] forState:UIControlStateSelected];
        [_btn_city addTarget:self action:@selector(clickSelectCity:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_city;
}

- (ZFButton *)btn_district {
    
    if (!_btn_district) {
        _btn_district = [ZFButton zfButtonWithType:ZFButtonTypeRightImageLeftTitle];
        _btn_district.titleLabel.font = [UIFont systemFontOfSize:14];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 206/255.f, 206/255.f, 206/255.f, 1 });
        [_btn_district.layer setBorderColor:colorref];
        [_btn_district.layer setBorderWidth:0.5f];
        [_btn_district.layer setCornerRadius:3.f];
        [_btn_district setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn_district setTitleColor:SXRGB16Color(0xD34A19) forState:UIControlStateSelected];
        [_btn_district setImage:[UIImage imageNamed:@"login_input_arrow_normal"] forState:UIControlStateNormal];
        [_btn_district setImage:[UIImage imageNamed:@"login_input_arrow_click"] forState:UIControlStateSelected];
        [_btn_district addTarget:self action:@selector(clickSelectDistrict:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn_district;
}


- (PickPlaceView *)list_province
{
    if (!_list_province) {
        _list_province = [[PickPlaceView alloc] initWithFrame:CGRectMake(self.x, self.bottom, self.width, SCREEN_HEIGHT - self.bottom - 49 - 64 - Top_SafeArea_HEIGHT)];
        [self.superView addSubview:_list_province];
    }
    
    return _list_province;
}
- (PickPlaceView *)list_city
{
    if (!_list_city) {
        _list_city = [[PickPlaceView alloc] initWithFrame:CGRectMake(self.x, self.bottom, self.width, SCREEN_HEIGHT - self.bottom - 49 - 64 - Top_SafeArea_HEIGHT)];
        [self.superView addSubview:_list_city];
    }
    
    return _list_city;
}
- (PickPlaceView *)list_district
{
    if (!_list_district) {
        _list_district = [[PickPlaceView alloc] initWithFrame:CGRectMake(self.x, self.bottom, self.width, SCREEN_HEIGHT - self.bottom - 49 - 64 - Top_SafeArea_HEIGHT)];
         [self.superView addSubview:_list_district];
    }
    
    return _list_district;
}

@end
