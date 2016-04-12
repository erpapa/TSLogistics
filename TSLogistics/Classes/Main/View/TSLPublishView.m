//
//  TSLPublishView.m
//  TSLogistics
//
//  Created by erpapa on 15/11/9.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLPublishView.h"
#import "TSLPutAudioView.h"
#import "VoiceConverter.h"
#import "UIView+MJExtension.h"
#define kTitleFontSize 16

@interface TSLPublishView ()<AVAudioRecorderDelegate>
@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIButton *sayButton;
@property (strong, nonatomic) NSArray *imageArray;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) AVAudioRecorder *recorder;
@property (copy, nonatomic) NSString *recordFilePath;
@property (assign, nonatomic) float second;
@end

@implementation TSLPublishView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.opacity = 0.1; // 不透明度默认0.1
        [self setupContentView];
    }
    return self;
}

/**
 *  初始化控件
 */
- (void)setupContentView
{
    self.bgView = [[UIView alloc] initWithFrame:self.bounds];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bgView];
    
    // 说话按钮
    UIImage *sayButtonImage = [UIImage imageNamed:@"完成_07"];
    self.sayButton = [[UIButton alloc] initWithFrame:CGRectMake((ScreenW - sayButtonImage.size.width) / 2, ScreenH - sayButtonImage.size.height - 2, sayButtonImage.size.width,sayButtonImage.size.height)];
    [self.sayButton setImage:sayButtonImage forState:UIControlStateNormal];
    [self.sayButton addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
    [self.sayButton addTarget:self action:@selector(touchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [self.sayButton addTarget:self action:@selector(touchOutside) forControlEvents:UIControlEventTouchUpOutside];
    [self addSubview:self.sayButton];
    
    // 动画
    UIImage *voiceImage = [UIImage imageNamed:@"yin1"];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenW - voiceImage.size.width) / 2, CGRectGetMinY(self.sayButton.frame) - voiceImage.size.height - 60, voiceImage.size.width, voiceImage.size.height)];
    self.imageView.image = voiceImage;
    self.imageView.animationImages = self.imageArray;
    self.imageView.animationDuration = 1.2f;
    self.imageView.animationRepeatCount = 100;
    [self addSubview:self.imageView];
    
    // 文字
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMinY(self.imageView.frame) - 40, self.frame.size.width - 20, 20)];
    self.titleLabel.text = @"语音快速发布您的需求";
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = [UIFont systemFontOfSize:kTitleFontSize];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
    
    
}
/**
 *  按下button
 */
- (void)touchDown
{
    [self.imageView startAnimating];
    self.second = 0.0f;
    self.timer = [NSTimer timerWithTimeInterval:0.1f target:self selector:@selector(addSecond) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self startRecorder];
}
/**
 *  在button内部移开
 */
- (void)touchUpInside
{
    [self.imageView stopAnimating];
    [self.timer invalidate];
    self.timer = nil;
    if (self.second < 2.5f) {
        [self stopRecorderAndDelete:YES];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"说话时间太短" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    } else {
        [self stopRecorderAndDelete:NO];
    }
}
/**
 *  在button外部移开
 */
- (void)touchOutside
{
    [self.imageView stopAnimating];
    [self.timer invalidate];
    self.timer = nil;
    [self stopRecorderAndDelete:YES];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已取消录音" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
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
/**
 *  停止录音
 *
 *  @param delete 是否删除录音文件
 */
- (void)stopRecorderAndDelete:(BOOL)delete
{
    // 必须先stop，再setCategory以及setActive！！！
    [self.recorder stop];
    if (delete) {
        [self.recorder deleteRecording];
    }
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayAndRecord error:nil];
    [[AVAudioSession sharedInstance] setActive:NO error:nil];
    
}
/**
 *  点击view从父控件移除
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.35f animations:^{
        self.center = CGPointMake(ScreenW * 0.5, ScreenH * 1.5);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
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
    self.recorder = nil;
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
    [putView show];
}

- (void)layoutSubviews
{
    if (self.bottom) { // 距离底部的距离
        self.sayButton.mj_y = self.frame.size.height - self.bottom;
        self.imageView.mj_y = CGRectGetMinY(self.sayButton.frame) - self.imageView.mj_h - 60;
        self.titleLabel.mj_y = CGRectGetMinY(self.imageView.frame) - self.titleLabel.mj_h - 20;
    }
    if (self.title) {
        self.titleLabel.text = self.title;
        CGSize labelSize = [self.title sizeWithFont:[UIFont systemFontOfSize:kTitleFontSize] maxSize:CGSizeMake(self.mj_w - 30, 200)];
        self.titleLabel.frame = CGRectMake(10, CGRectGetMinY(self.imageView.frame) - labelSize.height - 60, self.mj_w - 20, labelSize.height);
    }
    self.bgView.alpha = 1 - self.opacity;// alpha值
}

/*
- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    self.center = CGPointMake(ScreenW * 0.5, -ScreenH * 0.5);
    [UIView animateWithDuration:0.35f animations:^{
        self.center = CGPointMake(ScreenW * 0.5, ScreenH * 0.5);
    }];
}
*/


@end
