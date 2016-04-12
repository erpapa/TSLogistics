//
//  TSLMeController.m
//  TSLogistics
//
//  Created by erpapa on 15/11/10.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLMyController.h"
#import "TSLMyViewCell.h"
#import "TSLLoginController.h"
#import "TSLUser.h"
#import <ShareSDK/ShareSDK.h>
#import "MBProgressHUD+MJ.h"

@interface TSLMyController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *userButton;
@property (strong, nonatomic) NSArray *infoArray;
@property (strong, nonatomic) UIWebView *webView;
@end

@implementation TSLMyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = TSLBackgroundColor;
    [self setupContentView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    TSLUser *user = [TSLUser sharedUser];
    if (user.UserName) {
        [self.userButton setTitle:user.UserName forState:UIControlStateNormal];
        self.userButton.enabled = NO;
        self.tableView.tableFooterView.hidden = NO;
    } else {
        [self.userButton setTitle:@"点击登录" forState:UIControlStateNormal];
        self.userButton.enabled = YES;
        self.tableView.tableFooterView.hidden = YES;
    }
}

/**
 *  初始化子控件
 */
- (void)setupContentView
{
    // 用户名
    self.userButton.layer.cornerRadius = 15;
    self.userButton.layer.masksToBounds = YES;
    self.userButton.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.7];
    // 退出登录
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 85)];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(8, 15, ScreenW - 16, 35)];
    [button setTitle:@"退出登录" forState:UIControlStateNormal];
    button.titleLabel.textColor = [UIColor whiteColor];
    button.backgroundColor = TSLColor(80, 160, 230);
    [button addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:button];
    self.tableView.tableFooterView = footerView;
    self.tableView.tableFooterView.hidden = YES;
}
- (IBAction)login
{
    [self performSegueWithIdentifier:@"login" sender:nil];
}
/**
 *  退出
 */
- (void)logout
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"退出登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [TSLUser saveUserInfo:nil];
        [self performSegueWithIdentifier:@"login" sender:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSLMyViewCell *cell = [TSLMyViewCell cellWithTableView:tableView];
    // 设置cell的数据
    NSDictionary *dict = [self.infoArray objectAtIndex:indexPath.row];
    cell.title = [[dict allKeys] firstObject];
    cell.image = [[dict allValues] firstObject];
    cell.textLabel.text = indexPath.row == 4 ? @"更多" : nil;
    return cell;
}

/**
 *  返回每组高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4)
        return 45.0f;
    else
        return 55.0f;
}

/**
 *  选中
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [self.infoArray objectAtIndex:indexPath.row];
    NSString *identifer = [[dict allValues] firstObject];// 背景图片名就是标识
    if (indexPath.row < 4) {
        TSLUser *user = [TSLUser sharedUser];
        if (user.UserName) {
            [self performSegueWithIdentifier:identifer sender:nil];
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"您还未登录" delegate:self cancelButtonTitle:@"不登录" otherButtonTitles:@"去登录", nil];
            [alertView show];
        }
    }else {
        switch (indexPath.row) {
            case 5:
                [self performSegueWithIdentifier:identifer sender:nil];
                break;
            case 6:
                [self performSegueWithIdentifier:identifer sender:nil];
                break;
            case 7:{
                if (_webView == nil) {
                    _webView = [[UIWebView alloc] init];// 用于拨打电话
                }
                [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://4006629256"]]];
            }
                break;
            case 8:
                [self shareApp];
                break;
            default:
                break;
        }
    }
}

- (NSArray *)infoArray
{
    if (_infoArray == nil) {
        self.infoArray = [NSArray arrayWithObjects:
                          @{@"基本信息":@"me_0"},
                          @{@"我的收藏":@"me_1"},
                          @{@"通讯录":@"me_2"},
                          @{@"修改密码":@"me_3"},
                          @{@"":@""},
                          @{@"意见反馈":@"me_4"},
                          @{@"关于我们":@"me_5"},
                          @{@"客服电话":@"me_6"},
                          @{@"分享软件":@"me_7"},
                          nil];
    }
    return _infoArray;
}
- (void)shareApp
{
    NSArray *shareList = [ShareSDK getShareListWithType:
                          ShareTypeSinaWeibo,
                          ShareTypeWeixiSession,
                          ShareTypeQQ,
                          ShareTypeWeixiTimeline,
                          ShareTypeWeixiFav,
                          ShareTypeQQSpace,nil];
    //构造分享内容
    NSString *url = @"https://itunes.apple.com/cn/app/wu-liu-tang-shan/id990902550?mt=8";
    id<ISSContent> publishContent = [ShareSDK content:url
                                       defaultContent:@"share"
                                                image:nil
                                                title:@"Share"
                                                  url:url
                                          description:@"share"
                                            mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:self.view arrowDirect:UIPopoverArrowDirectionUp];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:shareList
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end)
    {
    if (state == SSResponseStateSuccess)
    {
        [MBProgressHUD showSuccess:@"分享成功"];
    }
    else if (state == SSResponseStateFail)
    {
        NSString *msg = [NSString stringWithFormat:@"错误码:%ld,错误描述:%@", [error errorCode], [error errorDescription]];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }}];
}
@end
