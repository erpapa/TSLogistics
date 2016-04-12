//
//  TSLMyContactDetailController.m
//  TSLogistics
//
//  Created by erpapa on 15/12/8.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLMyContactDetailController.h"
#import "TSLCollectInfo.h"

@interface TSLMyContactDetailController()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobilePhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *telphoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) UIWebView *webView;

@end
@implementation TSLMyContactDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.webView = [[UIWebView alloc] init];
    [self.view addSubview:self.webView];
    [self setupData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)setupData
{
    self.titleLabel.text = self.info.Compellation;
    self.mobilePhoneLabel.text = self.info.MobilePhone;
    self.telphoneLabel.text = self.info.Telephone;
    self.companyLabel.text = self.info.Company;
    self.sourceLabel.text = @"货源信息";// 由info.LogisticsType确定
    self.addressLabel.text = self.info.Address;
}

- (IBAction)call:(UIButton *)sender {
    NSURL *url = [NSURL URLWithString:[@"tel://" stringByAppendingString:self.info.MobilePhone]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
