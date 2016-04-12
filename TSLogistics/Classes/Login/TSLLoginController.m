//
//  TSLLoginController.m
//  TSLogistics
//
//  Created by erpapa on 15/11/13.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLLoginController.h"
#import "TSLHttpTool.h"
#import "TSLUser.h"
#import "MBProgressHUD+MJ.h"
#import "MJExtension.h"

@interface TSLLoginController ()<UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *bgView;
@property (strong, nonatomic) UITextField *userField;
@property (strong, nonatomic) UITextField *pwdField;
@property (strong, nonatomic) UIButton *rememberPwdBox;
@property (strong, nonatomic) UIButton *autoLoginBox;
@end

@implementation TSLLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupScrollView];
    [self setupLoginView];
    [self loadLoginConfig];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [TSLNotificationCenter addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [TSLNotificationCenter removeObserver:self];
}

- (void)setupScrollView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.contentSize = CGSizeMake(ScreenW, ScreenH - 64);
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 1, 0);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH + 72)];
    self.bgView.image = [UIImage imageNamed:@"登录bg"];
    self.bgView.userInteractionEnabled = YES;
    [self.scrollView addSubview:self.bgView];
    [self.view addSubview:self.scrollView];
}

- (void)setupLoginView
{
    CGFloat x = 20;
    CGFloat width = ScreenW - 2 * x;
    CGFloat userFieldY = ScreenH * 0.5 - 64;
    CGFloat textHeight = 34;
    // 登录logo
    UIImage *logoImage = [UIImage imageNamed:@"dl_logo"];
    CGFloat logoHeight = width * logoImage.size.height / logoImage.size.width;
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(x, userFieldY - logoHeight - 50, width, logoHeight)];
    logoView.image = logoImage;
    // 文本框
    self.userField = [[UITextField alloc] initWithFrame:CGRectMake(x, userFieldY, width, textHeight)];
    self.userField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, textHeight)];
    self.userField.leftViewMode = UITextFieldViewModeAlways;
//    userField.placeholder = @"请输入用户名";
    [self.userField setAutocorrectionType:UITextAutocorrectionTypeNo];// 关闭联想
    [self.userField setAutocapitalizationType:UITextAutocapitalizationTypeNone];// 关闭首字母大写
    self.userField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入用户名" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.userField.textColor = [UIColor whiteColor];
    self.userField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.userField.background = [UIImage resizedImageWithName:@"登录用户名" left:33 top:33];
    self.pwdField = [[UITextField alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(self.userField.frame) + 8, width, textHeight)];
    self.pwdField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, textHeight)];
    self.pwdField.leftViewMode = UITextFieldViewModeAlways;
    self.pwdField.placeholder = @"请输入密码";
    self.pwdField.textColor = [UIColor lightGrayColor];
    self.pwdField.secureTextEntry = YES;
    self.pwdField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.pwdField.background = [UIImage resizedImageWithName:@"登录密码" left:33 top:33];
    // 勾选
    self.rememberPwdBox = [[UIButton alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(self.pwdField.frame) + 16, 100, 22)];
    [self.rememberPwdBox setTitle:@"记住密码" forState:UIControlStateNormal];
    [self.rememberPwdBox setImage:[UIImage imageNamed:@"cb_glossy_off"] forState:UIControlStateNormal];
    [self.rememberPwdBox setImage:[UIImage imageNamed:@"cb_glossy_on"] forState:UIControlStateSelected];
    [self.rememberPwdBox addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
    self.rememberPwdBox.selected = YES;
    
    self.autoLoginBox = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - x - 100, CGRectGetMaxY(self.pwdField.frame) + 16, 100, 22)];
    [self.autoLoginBox setTitle:@"自动登录" forState:UIControlStateNormal];
    [self.autoLoginBox setImage:[UIImage imageNamed:@"cb_glossy_off"] forState:UIControlStateNormal];
    [self.autoLoginBox setImage:[UIImage imageNamed:@"cb_glossy_on"] forState:UIControlStateSelected];
    [self.autoLoginBox addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
    self.autoLoginBox.selected = YES;
    // 登录按钮
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(self.autoLoginBox.frame) + 16, width, 30)];
    loginBtn.backgroundColor = [UIColor orangeColor];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    // other
    UIButton *retrievePwd = [[UIButton alloc] initWithFrame:CGRectMake(x + 8, CGRectGetMaxY(loginBtn.frame) + 16, 75, 22)];
    [retrievePwd setTitle:@"找回密码" forState:UIControlStateNormal];
    [retrievePwd addTarget:self action:@selector(retrievePwd) forControlEvents:UIControlEventTouchUpInside];
    UIButton *registerUser = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - x - 90, CGRectGetMaxY(loginBtn.frame) + 16, 90, 22)];
    [registerUser setTitle:@"新用户注册" forState:UIControlStateNormal];
    [registerUser addTarget:self action:@selector(registUser) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bgView addSubview:logoView];
    [self.bgView addSubview:self.userField];
    [self.bgView addSubview:self.pwdField];
    [self.bgView addSubview:self.rememberPwdBox];
    [self.bgView addSubview:self.autoLoginBox];
    [self.bgView addSubview:loginBtn];
    [self.bgView addSubview:retrievePwd];
    [self.bgView addSubview:registerUser];
    
}

- (void)checkboxClick:(UIButton *)sender{
    sender.selected = !sender.isSelected;
    
    if (sender == self.rememberPwdBox && !sender.isSelected) { // 取消了“记住密码”
        self.autoLoginBox.selected = NO;
    } else if (sender == self.autoLoginBox && sender.isSelected) { // 勾选了“自动登录”
        self.rememberPwdBox.selected = YES;
    }
}
/**
 *  登录
 */
- (void)login
{
    [self.view endEditing:YES];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"Username"] = self.userField.text;
    param[@"Password"] = self.pwdField.text;
    [TSLHttpTool POST:[NSString stringWithFormat:@"%@%@", TSLAPI_PREFIX, TSLAPI_LOGIN] parameters:param success:^(id json) {
        TSLUserInfo *userInfo = [TSLUserInfo objectWithKeyValues:json];
        if (userInfo.state == YES) {
            [TSLUser saveUserInfo:userInfo]; // 保存用户信息
            [self saveLoginConfig];// 保存登录信息
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [MBProgressHUD showError:userInfo.Message];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"未知错误"];
    }];
}
/**
 *  找回密码
 */
- (void)retrievePwd
{
    [self performSegueWithIdentifier:@"retrieve" sender:nil];
}
/**
 *  注册
 */
- (void)registUser
{
    [self performSegueWithIdentifier:@"register" sender:nil];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    
    //动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //键盘位置停止改变时的frame
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //计算控制器的view移动到目标位置的Y值
    if (rect.origin.y == ScreenH) {
        [UIView animateWithDuration:duration animations:^{
            self.scrollView.contentOffset = CGPointMake(0, 0);
        }];
    } else {
        [UIView animateWithDuration:duration animations:^{
            self.scrollView.contentOffset = CGPointMake(0, 20);
        }];
    }
}

/**
 *  加载登录信息
 */
-(void)loadLoginConfig{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.userField.text = [defaults objectForKey:@"userName"];
    self.pwdField.text = [defaults objectForKey:@"password"];
    self.rememberPwdBox.selected = [defaults boolForKey:@"autoSave"];
    self.autoLoginBox.selected = [defaults boolForKey:@"autoLogin"];
}

/**
 *  存储登录信息
 */
- (void)saveLoginConfig{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.userField.text forKey:@"userName"];
    [defaults setObject:self.rememberPwdBox.isSelected ? self.pwdField.text:nil forKey:@"password"];
    [defaults setBool:self.rememberPwdBox.isSelected forKey:@"autoSave"];
    [defaults setBool:self.autoLoginBox.isSelected forKey:@"autoLogin"];
    [defaults synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
