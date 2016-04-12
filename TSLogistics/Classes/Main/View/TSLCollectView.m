//
//  TSLTelphoneView.m
//  TSLogistics
//
//  Created by erpapa on 15/12/1.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLCollectView.h"
#import "TSLCollectionParam.h"
#import "TSLUtil.h"

@interface TSLTelphoneView()<UIAlertViewDelegate>
@property (strong, nonatomic) UIButton *collectButton;
@property (strong, nonatomic) UIButton *callButton;
@property (strong, nonatomic) UIWebView *webView;
@end

@implementation TSLTelphoneView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupContentView];
    }
    return self;
}

- (void)setupContentView
{
    CGFloat buttonWidth = (self.bounds.size.width - 35) / 2;
    self.webView = [[UIWebView alloc] init];
    self.collectButton = [self buttonWithTitle:@"添加到通讯录" backgroundColor:[UIColor blueColor] selector:@selector(addCollect)];
    self.collectButton.frame = CGRectMake(10, 10, buttonWidth, 30);
    self.callButton = [self buttonWithTitle:@"拨打电话" backgroundColor:TSLColor(255, 75, 35) selector:@selector(call)];
    self.callButton.frame = CGRectMake(buttonWidth + 25, 10, buttonWidth, 30);
    [self addSubview:self.webView];
    [self addSubview:self.collectButton];
    [self addSubview:self.callButton];
}

- (UIButton *)buttonWithTitle:(NSString *)title backgroundColor:(UIColor *)color selector:(SEL)selector
{
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundColor:color];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 7;
    button.layer.masksToBounds = YES;
    return button;
}

- (void)addCollect
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"您确定要添加到通讯录" delegate:self cancelButtonTitle:@"不添加" otherButtonTitles:@"添加", nil];
    [alertView show];
}

- (void)call
{
    if (self.telString.length) {
        NSURL *url = [NSURL URLWithString:[@"tel://" stringByAppendingString:self.telString]];
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) return;
    if ([self.delegate respondsToSelector:@selector(collectionParam)]) {
        TSLCollectionParam *param = [self.delegate collectionParam];
        param.savetype = 1;
        [TSLHttpTool GET:[NSString stringWithFormat:@"%@%@", TSLAPI_PREFIX, TSLAPI_CollectionSave] parameters:param.keyValues success:^(id json) {
            BOOL state = [json[@"state"] boolValue];
            if ([self.delegate respondsToSelector:@selector(telphoneView:didCollected:)]) {
                [self.delegate telphoneView:self didCollected:state];
            }
            if (state) {
                [MBProgressHUD showSuccess:json[@"Message"]];
            } else {
                [MBProgressHUD showError:json[@"Message"]];
            }
        } failure:^(NSError *error) {
            if ([self.delegate respondsToSelector:@selector(telphoneView:didCollected:)]) {
                [self.delegate telphoneView:self didCollected:NO];
            }
            [MBProgressHUD showError:@"网络异常"];
        }];
    }
}

@end

@interface TSLCollectView()<UIAlertViewDelegate>
@property (strong, nonatomic) UIButton *collectButton;
@end

@implementation TSLCollectView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.collectButton = [[UIButton alloc] initWithFrame:self.bounds];
        self.collectButton.adjustsImageWhenHighlighted = NO;
        [self.collectButton setImage:[UIImage imageNamed:@"starsImage"] forState:UIControlStateNormal];
        [self.collectButton setImage:[UIImage imageNamed:@"starsImage_selected"] forState:UIControlStateSelected];
        [self.collectButton addTarget:self action:@selector(collect) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.collectButton];
    }
    return self;
}

- (void)collect
{
    if (self.isCollected == YES) return;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"您确定要添加到收藏" delegate:self cancelButtonTitle:@"不添加" otherButtonTitles:@"添加", nil];
    [alertView show];
}

- (void)setCollected:(BOOL)collected
{
    _collected = collected;
    self.collectButton.selected = collected;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) return;
    if ([self.delegate respondsToSelector:@selector(collectionParam)]) {
        TSLCollectionParam *param = [self.delegate collectionParam];
        param.savetype = 2;
        [TSLHttpTool GET:[NSString stringWithFormat:@"%@%@", TSLAPI_PREFIX, TSLAPI_CollectionSave] parameters:param.keyValues success:^(id json) {
            BOOL state = [json[@"state"] boolValue];
            if ([self.delegate respondsToSelector:@selector(collectView:didCollected:)]) {
                [self.delegate collectView:self didCollected:state];
            }
            if (state) {
                [MBProgressHUD showSuccess:json[@"Message"]];
            } else {
                [MBProgressHUD showError:json[@"Message"]];
            }
            self.collected = state;
        } failure:^(NSError *error) {
            if ([self.delegate respondsToSelector:@selector(collectView:didCollected:)]) {
                [self.delegate collectView:self didCollected:NO];
            }
            [MBProgressHUD showError:@"网络异常"];
        }];
    }
}

@end