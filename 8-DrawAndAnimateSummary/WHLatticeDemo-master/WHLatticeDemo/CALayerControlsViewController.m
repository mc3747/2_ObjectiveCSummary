//
//  CALayerControlsViewController.m
//  LayerPlayerOc
//
//  Created by 武蕴 on 15/8/17.
//  Copyright (c) 2015年 WymanY. All rights reserved.
//

#import "CALayerControlsViewController.h"
#import "CALayerViewController.h"

//enum Row: Int {
//case ContentsGravity, ContentsGravityPicker, DisplayContents, GeometryFlipped, Hidden, Opacity, CornerRadius, BorderWidth, BorderColor, BackgroundColor, ShadowOpacity, ShadowOffset, ShadowRadius, ShadowColor, MagnificationFilter
//}

typedef NS_ENUM(NSUInteger, Row) {
    ContentsGravity,
    ContentsGravityPicker,
    DisplayContents,
    GeometryFlipped,
    Hidden,
    Opacity,
    CornerRadius,
    BorderWidth,
    BorderColor,
    BackgroundColor,
    ShadowOpacity,
    ShadowOffset,
    ShadowRadius,
    ShadowColor,
    MagnificationFilter
};

typedef NS_ENUM(NSUInteger, Switch) {
    displayContents,
    geometryFlipped,
    hidden,
};

typedef NS_ENUM(NSUInteger, Slider) {
    opacity,
    cornerRadius,
    borderWidth,
    shadowOpacity,
    shadowRadius
};
//enum MagnificationFilter: Int {
//case Linear, Nearest, Trilinear
//}

typedef NS_ENUM(NSUInteger,magnificationFilter) {
    linear,
    nearest,
    trilinear,
};

@interface CALayerControlsViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSArray *contentsGravityValues;
    BOOL   contentsGravityPickerVisible;
}
@property (weak, nonatomic) IBOutlet UILabel *ContentsGravityPickerValueLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *contentsGravityPick;
@property (strong, nonatomic) IBOutletCollection(UISwitch)  NSArray*switches;
@property (strong, nonatomic) IBOutletCollection(UISlider) NSArray *sliders;

@property (strong, nonatomic) IBOutletCollection(UISlider) NSArray *borderColorSilders;
@property (strong, nonatomic) IBOutletCollection(UISlider) NSArray *backgroundColorSlider;
@property (strong, nonatomic) IBOutletCollection(UILabel)  NSArray*SliderValueLabels;

@property (weak, nonatomic) IBOutlet UISegmentedControl *magnificationFilterSegemnetedControl;
@property (weak, nonatomic) IBOutlet UILabel *backGroundSliderVauleLabel;
@property (weak, nonatomic) IBOutlet UILabel *borderColorValueLabel;
@property (strong, nonatomic) IBOutletCollection(UISlider) NSArray *shadowColorSliders;
@property (weak, nonatomic) IBOutlet UILabel *shadowColorValueLabel;

@property (strong, nonatomic) IBOutletCollection(UISlider) NSArray *shadowOffsetSliders;
@property (weak, nonatomic) IBOutlet UILabel *shadowOffsetValueLabel;

@end

@implementation CALayerControlsViewController

#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    contentsGravityValues = @[kCAGravityCenter, kCAGravityTop, kCAGravityBottom, kCAGravityLeft, kCAGravityRight, kCAGravityTopLeft, kCAGravityTopRight, kCAGravityBottomLeft, kCAGravityBottomRight, kCAGravityResize, kCAGravityResizeAspect, kCAGravityResizeAspectFill];
}



#pragma mark - PickViewData Source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return contentsGravityValues.count;
}


#pragma mark -PickView Delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return contentsGravityValues[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.layerViewController.layer.contentsGravity = contentsGravityValues[row];
    [self updateContentsGravityPickerValueLabel];
}

- (void)updateContentsGravityPickerValueLabel
{
    _ContentsGravityPickerValueLabel.text = _layerViewController.layer.contentsGravity;
}

#pragma mark -tableviewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (ContentsGravityPicker == indexPath.row)
    {
        return contentsGravityPickerVisible ? 162.0 : 0.0;
    }
    else
    {
        return  44.f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!contentsGravityPickerVisible) {
        if (ContentsGravity == indexPath.row) {
            [self showContentsGravityPicker];
        }
    }
    else
    {
        [self hideContensGravityPicker];
    }
}

- (void)showContentsGravityPicker
{
    contentsGravityPickerVisible = YES;
    [self relayoutTableViewCells];
    
    NSLog(@"%@",self.layerViewController.layer.contentsGravity);
    NSUInteger index = [contentsGravityValues indexOfObject:self.layerViewController.layer.contentsGravity];
    
    
    [_contentsGravityPick selectRow:index inComponent:0 animated:YES];
    _contentsGravityPick.hidden = NO;
    _contentsGravityPick.alpha = 0.0;
    [UIView animateWithDuration:0.25 animations:^{
        _contentsGravityPick.alpha = 1.0;
    }];
    
}

- (void)hideContensGravityPicker
{
    contentsGravityPickerVisible = NO;
    [self relayoutTableViewCells];
    self.tableView.userInteractionEnabled = NO;

    [UIView animateWithDuration:0.25 animations:^{
        _contentsGravityPick.alpha = 0.0;
    } completion:^(BOOL finished) {
        _contentsGravityPick.hidden = YES;
        self.tableView.userInteractionEnabled = YES;
    }];
}

- (void)relayoutTableViewCells
{
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

- (IBAction)switchChanged:(UISwitch *)sender {
    NSUInteger theSwitch = [self.switches indexOfObject:sender];
    switch (theSwitch) {
        case displayContents:
        {
            _layerViewController.layer.contents = (id)(sender.isOn ? _layerViewController.star.CGImage : nil);
            break;
        }
        case geometryFlipped:
        {
            _layerViewController.layer.geometryFlipped = sender.isOn;
            break;
        }
         
        case hidden:
        {
            _layerViewController.layer.hidden = sender.isOn;
            break;
        }

    }
}
- (IBAction)SliderChanged:(UISlider *)sender {
    NSUInteger slider = [self.sliders indexOfObject:sender];
    switch (slider) {
        case borderWidth:
        {
            self.layerViewController.layer.borderWidth = sender.value;
            break;
        }
        case cornerRadius:
        {
            self.layerViewController.layer.cornerRadius = sender.value;
            break;
        }
        case opacity:
        {
            self.layerViewController.layer.opacity = sender.value;
            break;
        }
        case shadowOpacity:
        {
            self.layerViewController.layer.shadowOpacity = sender.value;
            break;
        }
        case shadowRadius:
        {
            self.layerViewController.layer.shadowRadius = sender.value;
            break;
        }
           
            
        default:
            break;
    }
    [self updateSliderValueLabelWithIndex:slider];
}
- (IBAction)BorderColorSliderChanged:(UISlider *)sender {
    NSArray *colorLabel = [self colorAndSliderForSlider:(self.borderColorSilders)];
    self.layerViewController.layer.borderColor = [colorLabel[0] CGColor];
    self.borderColorValueLabel.text = colorLabel[1];
}
- (IBAction)backgroundColorSliderChanged:(UISlider *)sender {
    NSArray *colorLabel = [self colorAndSliderForSlider:(self.backgroundColorSlider)];
    self.layerViewController.layer.backgroundColor = [colorLabel[0] CGColor];
    self.backGroundSliderVauleLabel.text = colorLabel[1];
    
}
- (IBAction)shadowColorSliderChanged:(id)sender {
    NSArray *colorLabel = [self colorAndSliderForSlider:(self.shadowColorSliders)];
    self.layerViewController.layer.shadowColor = [colorLabel[0] CGColor];
    self.shadowColorValueLabel.text = colorLabel[1];
}
- (IBAction)magnificationSegmenteControlChanged:(UISegmentedControl *)sender {
    
    NSUInteger filter = sender.selectedSegmentIndex;
    switch (filter) {
        case linear:
        {
            self.layerViewController.layer.minificationFilter = kCAFilterLinear;
            break;
        }
        case nearest:
        {
            self.layerViewController.layer.minificationFilter = kCAFilterNearest;
            break;
        }
        case trilinear:
        {
            self.layerViewController.layer.minificationFilter = kCAFilterTrilinear;
            break;
        }

        default:
            break;
    }
    
}


- (IBAction)shadowOffsetSliderChanged:(id)sender {
    UISlider *widthSlider = self.shadowOffsetSliders[0];
    CGFloat width = widthSlider.value;
    
    UISlider *heightSlider = self.shadowOffsetSliders[1];
    CGFloat height = heightSlider.value;
    
    self.layerViewController.layer.shadowOffset = CGSizeMake(width, height);
    
    NSString *offsetStr = [NSString stringWithFormat:@"Width: %d,Height: %d",(int)width,(int)height];
    self.shadowOffsetValueLabel.text = offsetStr;
    
}





- (void)updateSliderValueLabelWithIndex:(NSUInteger)sliderEnum;
{
    UILabel *sliderValueLabel = self.SliderValueLabels[sliderEnum];
    UISlider *slider = self.sliders[sliderEnum];
    
    switch (sliderEnum) {
        case opacity:
        case shadowOpacity:
        {
            sliderValueLabel.text = [NSString stringWithFormat:@"%.1f",slider.value];
            break;
        }
        case cornerRadius:
        case borderWidth:
        case shadowRadius:
        {
            sliderValueLabel.text = [NSString stringWithFormat:@"%d",(int)(slider.value)];
        }
    }
    
}

- (NSArray *)colorAndSliderForSlider:(NSArray *)sliderArray
{
    UISlider *redSlider = sliderArray[0];
    UISlider *greenSlider = sliderArray[1];
    UISlider *blueSlider = sliderArray[2];
    CGFloat red = redSlider.value;
    CGFloat green = greenSlider.value;
    CGFloat blue = blueSlider.value;
    UIColor *color = [UIColor colorWithRed:red /255.f green:green /255.f blue:blue /255.f alpha:1.0];
    NSString *labelStr = [NSString stringWithFormat:@"RGB: %d, %d, %d",(int)red,(int)green,(int)blue];
    
    return @[color,labelStr];
}




@end
