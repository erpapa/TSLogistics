//
//  TSLNavigationController.m
//  TSLogistics
//
//  Created by erpapa on 15/11/9.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLNavigationController.h"

@interface TSLNavigationController ()

@end

@implementation TSLNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏属性
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.barTintColor = [UIColor blackColor];
    navBar.tintColor = [UIColor whiteColor];
    // navBar.backgroundColor = [UIColor blackColor];
    // 设置title属性
    NSMutableDictionary *titleTextAttrs = [NSMutableDictionary dictionary];
    titleTextAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    titleTextAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:17];
    [navBar setTitleTextAttributes:titleTextAttrs];
    // 设置返回item只保留箭头
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
}

/**
 *  设置状态栏字体颜色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
