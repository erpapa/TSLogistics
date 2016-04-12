//
//  TSLPutAudioView.m
//  TSLogistics
//
//  Created by erpapa on 15/11/16.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLPutAudioView.h"
#import <AVFoundation/AVFoundation.h>
#import "TSLUtil.h"
#import "TSLFormData.h"

@interface TSLPutAudioView()<AVAudioPlayerDelegate>
@property (strong, nonatomic) UIView *centerView;
@property (strong, nonatomic) NSArray *imageArray;
@property (strong, nonatomic) UIButton *playBtn;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) AVAudioPlayer *player;
@property (strong, nonatomic) UILabel *telphoneLabel;
@property (strong, nonatomic) UILabel *optionLabel;
@property (strong, nonatomic) UITextField *phoneTextField;

@end
@implementation TSLPutAudioView

- (void)show
{
    UIViewController *vc = [[UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers lastObject];
    vc.definesPresentationContext = YES; //vc is presenting view controller
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [vc presentViewController:self animated:NO completion:nil];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.editTelphone = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupContentView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.editTelphone == NO) {
        self.telphoneLabel.hidden = YES;
        self.phoneTextField.hidden = YES;
        self.optionLabel.hidden = YES;
    }
    self.centerView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    [UIView animateWithDuration:0.35f animations:^{
        self.centerView.transform = CGAffineTransformIdentity;
    }];
}

- (void)setupContentView
{
    self.centerView = [[UIView alloc] initWithFrame:CGRectMake(20, (ScreenH - 280) / 2, 280, 280)];
    self.centerView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    self.centerView.layer.cornerRadius = 5;
    self.centerView.layer.masksToBounds = YES;
    [self.view addSubview:self.centerView];
    // 重听
    self.playBtn = [[UIButton alloc] initWithFrame:CGRectMake(95, 15, 90, 90)];
    [self.playBtn addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    
    self.imageView = [[UIImageView alloc] initWithFrame:self.playBtn.bounds];
    self.imageView.image = [UIImage imageNamed:@"首页重听_03"];
    self.imageView.animationImages = self.imageArray;
    [self.playBtn addSubview:self.imageView];
    // 手机号
    self.telphoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 130, 110, 30)];
    self.telphoneLabel.text = @"您的手机号是";
    self.phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(120, 130, 135, 30)];
    self.phoneTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 6, 0)];
    self.phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    TSLUserInfo *userInfo = [TSLUser UserInfo];
    self.phoneTextField.text = userInfo.MobilePhone;
    self.phoneTextField.background = [UIImage resizedImageWithName:@"input4"];
    self.optionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.telphoneLabel.frame) + 20, 270, 20)];
    self.optionLabel.text = @"请您务必留下有效的联系方式，方便客服与您联系";
    self.optionLabel.font = [UIFont systemFontOfSize:12];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.optionLabel.frame) + 20, 280, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    // 取消
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame), 140, 59)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:TSLColor(28, 128, 243) forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    // 提交
    UIButton *commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(140, CGRectGetMaxY(line.frame), 140, 59)];
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [commitBtn setTitleColor:TSLColor(28, 128, 243) forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.centerView addSubview:self.playBtn];
    [self.centerView addSubview:self.telphoneLabel];
    [self.centerView addSubview:self.phoneTextField];
    [self.centerView addSubview:self.optionLabel];
    [self.centerView addSubview:line];
    [self.centerView addSubview:cancelBtn];
    [self.centerView addSubview:commitBtn];
}

- (void)cancelBtnClick
{
    [self dismiss];
}

- (void)commitBtnClick
{
    TSLFormData *formData = [[TSLFormData alloc] init];
    formData.data = [NSData dataWithContentsOfFile:self.filePath];
    formData.name = @"upname";
    formData.filename = [self.filePath lastPathComponent];
    formData.mimeType = @"audio/mp3";
    [TSLHttpTool POST:[NSString stringWithFormat:@"%@%@",TSLAPI_PREFIX,TSLAPI_AudioAdd] parameters:@{@"identifier":@([TSLUser sharedUser].Identifier)} formDataArray:@[formData] success:^(id json) {
        if (json[@"state"]) {
            [self feedBackWithAudioName:json[@"audio"]]; // 发送telephone
        } else {
            [MBProgressHUD showError:json[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"未知错误"];
    }];
    [self dismiss];
}

- (void)feedBackWithAudioName:(NSString *)audioName{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"TelPhone"] = self.phoneTextField.text;
    param[@"audio"] = audioName;
    param[@"feedtype"] = @"iOS";
    param[@"sourcetype"] = @(1);
    param[@"userid"] = @([TSLUser sharedUser].Identifier);
    [TSLHttpTool POST:[NSString stringWithFormat:@"%@%@", TSLAPI_PREFIX, TSLAPI_FeedBackSave] parameters:param success:^(id json) {
        if (json[@"state"]) {
            [MBProgressHUD showSuccess:json[@"msg"]];
        } else {
            [MBProgressHUD showError:json[@"msg"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"未知错误"];
    }];
}

// 播放音频，显示动画
- (void)play:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error:nil];
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:self.filePath] error:nil];
        self.player.delegate = self;
        self.imageView.animationRepeatCount = 100;
        self.imageView.animationDuration = 1.2;
        [self.player play];
        [self.imageView startAnimating];
    } else {
        [self.player stop];
        [self.imageView stopAnimating];
    }
}

#pragma mark - 播放完成
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    self.playBtn.selected = NO;
    [self.imageView stopAnimating];
    [self.player prepareToPlay];
}

/**
 *  懒加载
 */
- (NSArray *)imageArray
{
    if (_imageArray == nil) {
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 1; i < 4; i++) {
            NSString *name = [NSString stringWithFormat:@"btnPlay%d", i];
            UIImage *kImage = [UIImage imageNamed:name];
            [array addObject:kImage];
        }
        _imageArray = array;
    }
    return _imageArray;
}

- (void)dismiss
{
    NSFileManager *manager = [[NSFileManager alloc] init];
    [manager removeItemAtPath:self.filePath error:NULL];// 删除mp3文件
    [UIView animateWithDuration:0.2f animations:^{
        self.centerView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        self.centerView.alpha = 0.8;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4f animations:^{
            self.centerView.transform = CGAffineTransformMakeScale(0.2, 0.2);
            self.centerView.alpha = 0;
            self.view.alpha = 0;
        } completion:^(BOOL finished) {
            [self dismissViewControllerAnimated:NO completion:nil]; // 先执行操作，最后调用remove
        }];
    }];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
