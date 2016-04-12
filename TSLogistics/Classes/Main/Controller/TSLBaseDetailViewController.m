//
//  TSLBaseDetailViewController.m
//  TSLogistics
//
//  Created by erpapa on 15/11/29.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLBaseDetailViewController.h"
#import "TSLDestinationViewController.h"

@interface TSLBaseDetailViewController ()

@end

@implementation TSLBaseDetailViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"地图首页"] style:UIBarButtonItemStylePlain target:self action:@selector(showDestination)];
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityView.center = self.view.center;
    self.activityView.color = [UIColor grayColor];
    self.activityView.hidesWhenStopped = YES;
    [self.view addSubview:self.activityView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:self.activityView];
}

- (UIButton *)buttonWithTitle:(NSString *)title image:(NSString *)image
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenW - 2 * kBorderX, kHeight)];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;// 超出显示省略号
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 0);
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.userInteractionEnabled = NO;
    return button;
}

- (UILabel *)labelWithTitle:(NSString *)title origin:(CGPoint)origin
{
    CGFloat labelWidth = [title sizeWithFont:[UIFont systemFontOfSize:17]].width;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(origin.x, origin.y, labelWidth, kHeight)];
    label.text = title;
    label.textColor = [UIColor lightGrayColor];
    // label.textAlignment = NSTextAlignmentRight;
    return label;
}

- (UIView *)lineWithOrigin:(CGPoint)origin
{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(origin.x, origin.y, ScreenW - 2 * kBorderX, 1)];
    line.backgroundColor = TSLBackgroundColor;
    return line;
}

- (void)showDestination
{
    if (self.DestinationCoordinate.latitude <= 0 || self.DestinationCoordinate.longitude <= 0 || self.DestinationCoordinate.latitude > 90 || self.DestinationCoordinate.longitude > 180) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"商家暂未提供位置信息" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
    } else
    {
        TSLDestinationViewController *destVC = [[TSLDestinationViewController alloc] init];
        destVC.DestinationCoordinate = self.DestinationCoordinate;
        [self presentViewController:destVC animated:YES completion:nil];
    }
}
@end
