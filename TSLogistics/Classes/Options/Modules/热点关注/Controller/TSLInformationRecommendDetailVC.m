//
//  TSLInformationRecommendDetailVC.m
//  TSLogistics
//
//  Created by erpapa on 15/11/17.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLInformationRecommendDetailVC.h"
#import "TSLRecommendInfo.h"

@interface TSLInformationRecommendDetailVC ()<UIWebViewDelegate>

@end

@implementation TSLInformationRecommendDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupContentView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupContentView
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 70, ScreenW - 32, 50)];
    titleLabel.text = self.info.NameCHN;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.numberOfLines = 0;
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 120, ScreenW * 0.3, 30)];
    timeLabel.text = self.info.ReleaseTime;
    timeLabel.font = [UIFont systemFontOfSize:14];
    UILabel *sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW * 0.5 - 16, 120, ScreenW * 0.5, 30)];
    sourceLabel.text = self.info.SourceName;
    sourceLabel.font = [UIFont systemFontOfSize:14];
    sourceLabel.textColor = [UIColor orangeColor];
    sourceLabel.textAlignment = NSTextAlignmentRight;
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(timeLabel.frame), ScreenW - 20, 1)];
    line.backgroundColor = TSLBackgroundColor;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame), ScreenW, ScreenH - CGRectGetMaxY(line.frame))];
    [webView loadHTMLString:self.info.Content baseURL:nil];
    webView.delegate = self;
    webView.opaque = NO;
    webView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:titleLabel];
    [self.view addSubview:timeLabel];
    [self.view addSubview:sourceLabel];
    [self.view addSubview:line];
    [self.view addSubview:webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
