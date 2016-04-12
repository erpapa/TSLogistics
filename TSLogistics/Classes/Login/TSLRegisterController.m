//
//  TSLRegisterController.m
//  TSLogistics
//
//  Created by erpapa on 15/11/13.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLRegisterController.h"
#import "TSLTopButton.h"
#import "TSLPersonalRegisterView.h"
#import "TSLCompanyRegisterView.h"

@interface TSLRegisterController ()<UIScrollViewDelegate>
@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) TSLTopButton *currentButton;
@end

@implementation TSLRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTopView];
    [self setupScrollView];
}

- (void)setupTopView
{
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenW, 41)];
    self.topView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.topView];
    TSLTopButton *btn0 = [[TSLTopButton alloc] initWithFrame:CGRectMake(0, 0, ScreenW / 2, 40)];
    [btn0 setTitle:@"个人注册" forState:UIControlStateNormal];
    [btn0 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn0 setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [btn0 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn0.selected = YES;
    btn0.tag = 0;
    self.currentButton = btn0;
    TSLTopButton *btn1 = [[TSLTopButton alloc] initWithFrame:CGRectMake(ScreenW / 2, 0, ScreenW / 2, 40)];
    [btn1 setTitle:@"公司注册" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn1.tag = 1;
    [self.topView addSubview:btn0];
    [self.topView addSubview:btn1];
    
}
- (void)setupScrollView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 105, ScreenW, ScreenH)];
    self.scrollView.contentSize = CGSizeMake(ScreenW * 2, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    TSLPersonalRegisterView *personalView = [[TSLPersonalRegisterView alloc] initWithFrame:self.view.bounds];
    TSLCompanyRegisterView *companyView = [[TSLCompanyRegisterView alloc] initWithFrame:CGRectMake(ScreenW, 0, ScreenW, ScreenH)];
    
    [self.scrollView addSubview:personalView];
    [self.scrollView addSubview:companyView];
}

- (void)btnClick:(TSLTopButton *)sender
{
    if (sender == self.currentButton) {
        return;
    } else {
        self.currentButton.selected = NO;
        sender.selected = YES;
        self.currentButton = sender;
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * sender.tag, 0);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = roundf(scrollView.contentOffset.x / scrollView.frame.size.width);
    page = MAX(page, 0);
    page = MIN(page, 1);
    TSLTopButton *button = self.topView.subviews[page];
    if (button == self.currentButton) {
        return;
    } else {
        self.currentButton.selected = NO;
        button.selected = YES;
        self.currentButton = button;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
