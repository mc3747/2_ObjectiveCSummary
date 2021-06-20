//
//  ViewController.m
//  系统声音
//
//  Created by 思久科技 on 16/9/20.
//  Copyright © 2016年 思久科技. All rights reserved.
//

#import "AudioPlistVC.h"
#import <AudioToolbox/AudioToolbox.h>
#import "SystemSoundModel.h"

@interface AudioPlistVC (){
    NSMutableArray *_dataArray;      //返回数据
}

@property (weak, nonatomic) IBOutlet UITextField *nameTF;

@end

@implementation AudioPlistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SystemSound" ofType:@"plist"];
    NSMutableArray *soundAry = [NSMutableArray arrayWithContentsOfFile:path];
    
    NSDictionary *dictionary = soundAry[0];
    NSString *category = dictionary[@"Category"];
    NSString *fileName = dictionary[@"FileName"];
    SystemSoundID soundId = [dictionary[@"SoundID"] intValue];
    
    _dataArray = [NSMutableArray array];
    
    // 列举对象所有子对象，相当于遍历，也可以使用for循环代理。
    [soundAry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SystemSoundModel *model = [SystemSoundModel new];
        [model setValuesForKeysWithDictionary:obj];
        [_dataArray addObject:model];
        
        [self.tableView reloadData];
    }];
}

- (IBAction)playSound:(id)sender {
    if ([self.nameTF.text length]> 0) {
        [self playSoundWithFileName:self.nameTF.text];
    }else{
        NSLog(@"音频文件名不能为空！");
    }
}

#pragma mark - UITableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(_dataArray != nil && _dataArray.count != 0){
        return _dataArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    SystemSoundModel *model = _dataArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld %@", (long)indexPath.row,model.Category];
    
    return cell;
}

#pragma mark - UITableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SystemSoundModel *model = _dataArray[indexPath.row];
    SystemSoundID soundId = [model.SoundID intValue];
    AudioServicesPlaySystemSound(soundId);
}

#pragma mark - UITextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self.view endEditing:YES];
    return YES;
}

/**
 播放自定义本地声音
 
 @param fileName 文件名 包含后缀
 */
- (void)playSoundWithFileName:(NSString *)fileName
{
    SystemSoundID soundID;
    NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
    OSStatus errorCode = AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url) , &soundID);
    if (errorCode != 0) {
        NSLog(@"create sound failed");
    }else{
        AudioServicesPlaySystemSound(soundID);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
