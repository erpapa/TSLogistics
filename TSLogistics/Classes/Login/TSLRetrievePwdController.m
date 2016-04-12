//
//  TSLRetrievePwdController.m
//  TSLogistics
//
//  Created by erpapa on 15/11/13.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLRetrievePwdController.h"

@interface TSLRetrievePwdController ()
@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (strong, nonatomic) UIWebView *webView;
@end

@implementation TSLRetrievePwdController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *originImage = [UIImage imageNamed:@"dianhua"];
    [self.callButton setImage:[UIImage imageFromOrigin:originImage scaleToSize:CGSizeMake(40, 40)] forState:UIControlStateNormal];
    [self.callButton setAdjustsImageWhenHighlighted:NO];
    
    self.webView = [[UIWebView alloc] init];// 用于拨打电话
    [self.view addSubview:self.webView];
}
- (IBAction)callButtonClick:(UIButton *)sender {
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://4006629256"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
