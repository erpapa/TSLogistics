//
//  TSLAboutController.m
//  TSLogistics
//
//  Created by erpapa on 15/11/14.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLAboutController.h"

@interface TSLAboutController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation TSLAboutController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"about" ofType:@"html"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    self.webView.opaque = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
}

- (IBAction)call:(UIButton *)sender {
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://4006629256"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
