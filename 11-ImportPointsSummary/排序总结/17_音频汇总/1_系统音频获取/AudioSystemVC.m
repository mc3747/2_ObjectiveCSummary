//
//  SoundListViewController.m
//  SystemSoundLibrary
//
//  Created by Anton Pauli on 12.10.13.
//  Copyright (c) 2013 Anton Pauli. All rights reserved.
//

#import "AudioSystemVC.h"
#import <AudioToolbox/AudioToolbox.h>
#import "SystemSoundModel.h"
@interface AudioSystemVC ()
@property (nonatomic, strong) NSMutableArray *audioFileList;
@property (nonatomic, strong) NSMutableArray<SystemSoundModel *> *audioModelArray;
@end

@implementation AudioSystemVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadAudioFileList];
}
/*
 includingPropertiesForKeys 属性有好多，这里仅介绍几个：
 NSURLNameKey：文件名
 NSURLIsDirectoryKey：是否是文件夹
 NSURLIsPackageKey：是否是一个包（比如APP）
 NSURLIsHiddenKey：是否是隐藏文件
 NSURLCreationDateKey：创建日期
 
 
 options 的属性：
 NSDirectoryEnumerationSkipsSubdirectoryDescendants: 浅层的枚举，不会枚举子目录
 NSDirectoryEnumerationSkipsPackageDescendants: 不会扫描pakages的内容
 NSDirectoryEnumerationSkipsHiddenFile: 不会扫描隐藏文件
 ---------------------

 */
-(void)loadAudioFileList{
    _audioFileList = [[NSMutableArray alloc] init];
    _audioModelArray = [[NSMutableArray alloc] init];

    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSURL *directoryURL = [NSURL URLWithString:@"/System/Library/Audio/UISounds"];
    NSArray *keys = [NSArray arrayWithObject:NSURLIsDirectoryKey];
    
    NSDirectoryEnumerator *enumerator = [fileManager
                                         enumeratorAtURL:directoryURL
                                         includingPropertiesForKeys:keys
                                         options:0
                                         errorHandler:^(NSURL *url, NSError *error) {
                                             // Handle the error.
                                             // Return YES if the enumeration should continue after the error.
                                             return YES;
                                         }];
    
    for (NSURL *url in enumerator) {
        NSError *error;
        NSNumber *isDirectory = nil;
        if (! [url getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:&error]) {
            // handle error
            
        }else if (! [isDirectory boolValue]) {
            [_audioFileList addObject:url];
            
        }else {
            //  文件夹层级
            NSDirectoryEnumerator *newEnumerator = [fileManager
                                                 enumeratorAtURL:url
                                                 includingPropertiesForKeys:keys
                                                 options:0
                                                 errorHandler:^(NSURL *url, NSError *error) {

                                                     return YES;
                                                 }];
            for (NSURL *url in newEnumerator) {
                NSError *error;
                NSNumber *isDirectory = nil;
                if (! [url getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:&error]) {
                    // handle error

                }else if (! [isDirectory boolValue]) {
                    [_audioFileList addObject:url];

                }else {

                };
            };
        }
    };
    
    [_audioFileList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SystemSoundID soundID;
        AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef)obj,&soundID);
        SystemSoundModel *model = [[SystemSoundModel alloc] init];
        model.FileName = [obj lastPathComponent];
        model.SoundID = [NSNumber numberWithInt:soundID];
        [self.audioModelArray addObject:model];
    }];
    
    [self.audioModelArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        SystemSoundModel *pModel1 = obj1;
        SystemSoundModel *pModel2 = obj2;
        
        if ([pModel1.SoundID integerValue] > [pModel2.SoundID integerValue]) { //不使用intValue比较无效
            return NSOrderedDescending;//降序
            
        }else if ([pModel1.SoundID integerValue] < [pModel2.SoundID integerValue]){
            return NSOrderedAscending;//升序
            
        }else {
            return NSOrderedSame;//相等
        }
    }];
    NSLog(@"文件的数量%li",_audioFileList.count);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"AudioSystemCell"];
     [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_audioFileList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AudioSystemCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
     }
    
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef)[_audioFileList objectAtIndex:indexPath.row],&soundID);
//    NSString *fileName = [[_audioFileList objectAtIndex:indexPath.row] lastPathComponent];
    cell.textLabel.text = [NSString stringWithFormat:@"%li_%@(%@)",indexPath.row,_audioModelArray[indexPath.row].FileName,_audioModelArray[indexPath.row].SoundID];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    SystemSoundID soundID;
//    AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef)[_audioFileList objectAtIndex:indexPath.row],&soundID);
//    AudioServicesPlaySystemSound(soundID);
    
    AudioServicesPlaySystemSound([_audioModelArray[indexPath.row].SoundID intValue]);
//    NSLog(@"File url: %@", [[_audioFileList objectAtIndex:indexPath.row] description]);
    NSLog(@"soundId:%i",[_audioModelArray[indexPath.row].SoundID intValue]);
}

@end
