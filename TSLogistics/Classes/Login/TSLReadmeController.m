//
//  TSLReadmeController.m
//  TSLogistics
//
//  Created by erpapa on 15/11/13.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLReadmeController.h"

@interface TSLReadmeController ()<UIWebViewDelegate>

@end

@implementation TSLReadmeController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.delegate = self;
    webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:webView];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"service" ofType:@"html"];
//    [webView loadData:[NSData dataWithContentsOfFile:path] MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:nil];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
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
