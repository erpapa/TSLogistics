//
//  TSLMyFeedbackController.m
//  TSLogistics
//
//  Created by erpapa on 15/11/14.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLMyFeedbackController.h"
#import "TSLPutAudioView.h"
#import "VoiceConverter.h"

@interface TSLMyFeedbackController ()<AVAudioRecorderDelegate>
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) NSArray *imageArray;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) AVAudioRecorder *recorder;
@property (assign, nonatomic) float second;
@property (copy, nonatomic) NSString *recordFilePath;
@end

@implementation TSLMyFeedbackController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 动画
    self.imageView.animationImages = self.imageArray;
    self.imageView.animationDuration = 1.2f;
    self.imageView.animationRepeatCount = 100;
}

/**
 *  按下button
 */
- (IBAction)touchDown
{
    [self.imageView startAnimating];
    self.second = 0;
    self.timer = [NSTimer timerWithTimeInterval:0.1f target:self selector:@selector(addSecond) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self startRecorder];
}
/**
 *  在button内部移开
 */
- (IBAction)touchUpInside
{
    [self.imageView stopAnimating];
    [self.timer invalidate];
    self.timer = nil;
    if (self.second < 2.5f) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"说话时间太短" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        [self stopRecorderAndDelete:YES];
    }
    [self stopRecorderAndDelete:NO];
}
/**
 *  在button外部移开
 */
- (IBAction)touchOutside
{
    [self.imageView stopAnimating];
    [self.timer invalidate];
    self.timer = nil;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已取消录音" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    [self stopRecorderAndDelete:YES];
}
/**
 *  增加时间
 */
- (void)addSecond
{
    self.second += 0.1f;
}

- (void)startRecorder
{
    //根据当前时间生成文件名
    NSString *recordFileName = [VoiceConverter getCurrentTimeString];
    //获取路径
    self.recordFilePath = [VoiceConverter getPathFromFileName:recordFileName ofType:@"wav"];
    //初始化录音
    self.recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:self.recordFilePath] settings:[VoiceConverter GetAudioRecorderSettingDict] error:nil];
    self.recorder.delegate = self;
    //准备录音
    if ([self.recorder prepareToRecord]){
        
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryRecord error:nil];
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        [self.recorder record];
    }
}

- (void)stopRecorderAndDelete:(BOOL)delete
{
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayAndRecord error:nil];
    [[AVAudioSession sharedInstance] setActive:NO error:nil];
    [self.recorder stop];
    if (delete) {
        [self.recorder deleteRecording];
    }
}

/**
 *  懒加载
 */
- (NSArray *)imageArray
{
    if (_imageArray == nil) {
        NSMutableArray *Array = [NSMutableArray array];
        for (int i = 1; i < 8; i++) {
            NSString *name = [NSString stringWithFormat:@"yin%d", i];
            UIImage *kImage = [UIImage imageNamed:name];
            [Array addObject:kImage];
        }
        _imageArray = Array;
    }
    return _imageArray;
}

#pragma mark - 录音结束返回的信息
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    NSFileManager *manager = [[NSFileManager alloc] init];
    if (![manager fileExistsAtPath:self.recordFilePath]) {
        return;// 如果文件不存在自己返回
    }
    // 获取转换后的mp3文件路径
    NSString *mp3FilePath = [VoiceConverter getPathFromFileName:@"lvRecord1" ofType:@"mp3"];
    if ([VoiceConverter ConvertWavToMp3:self.recordFilePath mp3SavePath:mp3FilePath]) {
        [manager removeItemAtPath:self.recordFilePath error:NULL];// 删除录音文件
    }
    TSLPutAudioView *putView = [[TSLPutAudioView alloc] init];
    putView.filePath = mp3FilePath;
    putView.editTelphone = NO;
    [putView show];
}

@end
