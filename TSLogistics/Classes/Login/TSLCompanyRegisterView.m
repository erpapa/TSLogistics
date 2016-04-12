//
//  TSLCompanyRegisterView.m
//  TSLogistics
//
//  Created by erpapa on 15/11/13.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLCompanyRegisterView.h"
#import "TSLReadmeController.h"
#import "TSLRegisterParam.h"
#import "TSLUser.h"
#import "TSLHttpTool.h"
#import "MJExtension.h"
#import "MBProgressHUD+MJ.h"

@interface TSLCompanyRegisterView()<UITextFieldDelegate>
@property (strong, nonatomic) UITextField *userName;
@property (strong, nonatomic) UITextField *password;
@property (strong, nonatomic) UITextField *rePwd;
@property (strong, nonatomic) UITextField *compellation;
@property (strong, nonatomic) UITextField *mobilePhone;
@property (strong, nonatomic) UITextField *companyName;
@end
@implementation TSLCompanyRegisterView

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
    CGFloat x = 20;
    CGFloat width = ScreenW - 2 * x;
    CGFloat height = 34;
    self.userName = [[UITextField alloc] initWithFrame:CGRectMake(x, 10, width, height)];
    self.userName.placeholder = @"请输入用户名";
    self.userName.background = [UIImage resizedImageWithName:@"input5"];
    
    self.password = [[UITextField alloc] initWithFrame:CGRectMake(x,height + 20, width, height)];
    self.password.placeholder = @"请输入用户密码";
    self.password.background = [UIImage resizedImageWithName:@"input5"];
    self.password.secureTextEntry = YES;
    
    self.rePwd = [[UITextField alloc] initWithFrame:CGRectMake(x, height * 2 + 30, width, height)];
    self.rePwd.placeholder = @"确认密码";
    self.rePwd.background = [UIImage resizedImageWithName:@"input5"];
    self.rePwd.secureTextEntry = YES;
    
    self.compellation = [[UITextField alloc] initWithFrame:CGRectMake(x, height * 3 + 40, width, height)];
    self.compellation.placeholder = @"联系人";
    self.compellation.background = [UIImage resizedImageWithName:@"input5"];
    
    self.mobilePhone = [[UITextField alloc] initWithFrame:CGRectMake(x, height * 4 + 50, width, height)];
    self.mobilePhone.placeholder = @"联系电话";
    self.mobilePhone.background = [UIImage resizedImageWithName:@"input5"];
    self.mobilePhone.delegate = self;
    
    self.companyName = [[UITextField alloc] initWithFrame:CGRectMake(x, height * 5 + 60, width, height)];
    self.companyName.placeholder = @"公司名称";
    self.companyName.background = [UIImage resizedImageWithName:@"input5"];
    self.companyName.delegate = self;
    
    UIButton *areaButton = [[UIButton alloc] initWithFrame:CGRectMake(x, height * 6 + 70, width, height)];
    [areaButton setBackgroundImage:[UIImage resizedImageWithName:@"input2" left:33 top:33] forState:UIControlStateNormal];
    [areaButton setTitle:@"不限-不限-不限" forState:UIControlStateNormal];
    [areaButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIButton *registerButton = [[UIButton alloc] initWithFrame:CGRectMake(x, height * 7 + 80, width, height)];
    registerButton.backgroundColor = [UIColor orangeColor];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *aboutLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, height * 8 + 90, width, 20)];
    aboutLabel.text = @"点击注册即表示已阅读并同意";
    aboutLabel.font = [UIFont systemFontOfSize:14];
    aboutLabel.textAlignment = NSTextAlignmentCenter;
    
    UIButton *readme = [[UIButton alloc] initWithFrame:CGRectMake(x, height * 8 + 110, width, 20)];
    [readme setTitle:@"《物流唐山服务条款》" forState:UIControlStateNormal];
    [readme setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    readme.titleLabel.font = [UIFont systemFontOfSize:14];
    [readme addTarget:self action:@selector(readmeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.userName];
    [self addSubview:self.password];
    [self addSubview:self.rePwd];
    [self addSubview:self.compellation];
    [self addSubview:self.mobilePhone];
    [self addSubview:self.companyName];
    [self addSubview:areaButton];
    [self addSubview:registerButton];
    [self addSubview:aboutLabel];
    [self addSubview:readme];
}

/**
 *  用户注册
 */
- (void)registerButtonClick
{
    if (![self.password.text isEqualToString:self.rePwd.text]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请确认密码输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    } else {
        TSLRegisterParam *param = [[TSLRegisterParam alloc] init];
        param.username = self.userName.text;
        param.Password = self.password.text;
        param.rePwd = self.rePwd.text;
        param.compellation = self.compellation.text;
        param.company = self.companyName.text;
        param.mobilePhone = self.mobilePhone.text;
        param.usertype = 1;
        param.Register = @"WLIOS";
        param.Ltypeid = 29;
        // 所属区域暂时没实现
        [TSLHttpTool POST:[NSString stringWithFormat:@"%@%@",TSLAPI_PREFIX, TSLAPI_REGISTER] parameters:param.keyValues success:^(id json) {
            
            TSLUserInfo *userInfo = [TSLUserInfo objectWithKeyValues:json];
            if (userInfo.state == YES) {
                [TSLUser saveUserInfo:userInfo]; // 保存用户信息
                [self saveLoginConfig]; // 保存注册信息
                // 跳转到me
                NSArray *array = [UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers;
                UIViewController *toVc;
                UIViewController *fromVc = [array lastObject];
                for (NSInteger index = 0; index < array.count; index++) {
                    UIViewController *vc = array[index];
                    if ([vc isKindOfClass:NSClassFromString(@"TSLMyController")]) {
                        toVc = vc;
                        break;
                    }
                }
                [fromVc.navigationController popToViewController:toVc animated:YES];
            } else {
                [MBProgressHUD showError:userInfo.Message];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD showError:@"未知错误"];
        }];
    }
    
}

- (void)readmeButtonClick
{
    TSLReadmeController *readmeVc = [[TSLReadmeController alloc] init];
    [[[[UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers lastObject] navigationController] pushViewController:readmeVc animated:YES];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
    [UIView animateWithDuration:0.2 animations:^{
        self.transform = CGAffineTransformIdentity;
    }];
}
#pragma mark - UITextField代理
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    CGFloat h = CGRectGetMaxY(self.companyName.frame) + 105 - 316;
    if (h > 0) {
        [UIView animateWithDuration:0.2 animations:^{
            self.transform = CGAffineTransformMakeTranslation(0, -h);
        }];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.companyName) {
        [UIView animateWithDuration:0.2 animations:^{
            self.transform = CGAffineTransformIdentity;
        }];
    }
}


/**
 *  存储注册信息
 */
- (void)saveLoginConfig{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.userName.text forKey:@"userName"];
    [defaults setObject:self.password.text forKey:@"password"];
    [defaults setBool:YES forKey:@"autoSave"];
    [defaults setBool:YES forKey:@"autoLogin"];
    [defaults synchronize];
}
@end
