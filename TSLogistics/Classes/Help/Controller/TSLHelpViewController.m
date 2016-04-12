//
//  TSLHelpViewController.m
//  TSLogistics
//
//  Created by erpapa on 15/11/9.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLHelpViewController.h"

@interface TSLHelpViewController ()
@property (strong, nonatomic) UIWebView *webView;
@end

@implementation TSLHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)callTokefu:(id)sender {
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://4006629256"]]];
}
- (IBAction)callTelphone:(UIButton *)sender {
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://18903151256"]]];
}
- (IBAction)talk:(UIButton *)sender {
    switch (sender.tag) {
        case 101:{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mqq://im/chat?chat_type=wpa&uin=2074468308&version=1&src_type=web"]];
//            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"mqq://im/chat?chat_type=wpa&uin=2074468308&version=1&src_type=web"]]];
        }
            break;
        case 102:{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mqq://im/chat?chat_type=wpa&uin=2602392759&version=1&src_type=web"]];
        }
            break;
        case 103:{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mqq://im/chat?chat_type=wpa&uin=1242148629&version=1&src_type=web"]];
        }
            break;
        case 104:{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mqq://im/chat?chat_type=wpa&uin=2870987021&version=1&src_type=web"]];
        }
            break;
            
        default:
            break;
    }
}

- (UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] init];
    }
    return _webView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
