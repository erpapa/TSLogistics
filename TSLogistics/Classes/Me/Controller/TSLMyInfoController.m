//
//  TSLMyInfoController.m
//  TSLogistics
//
//  Created by erpapa on 15/11/14.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLMyInfoController.h"
#import "TSLUser.h"
#import "TSLHttpTool.h"
#import "MJExtension.h"
#import "MBProgressHUD+MJ.h"

@interface TSLMyInfoController ()
/**
 *  联系人
 */
@property (weak, nonatomic) IBOutlet UITextField *compellation;
/**
 *  座机号码
 */
@property (weak, nonatomic) IBOutlet UITextField *telephone;
/**
 *  电话号码
 */
@property (weak, nonatomic) IBOutlet UITextField *mobilePhone;
/**
 *  详细地址
 */
@property (weak, nonatomic) IBOutlet UITextField *address;

@end

@implementation TSLMyInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
}
/**
 *  加载数据
 */
- (void)setupData
{
    TSLUserInfo *userInfo = [TSLUser UserInfo];
    self.compellation.text = userInfo.Compellation;
    self.telephone.text = userInfo.Telephone;
    self.mobilePhone.text = userInfo.MobilePhone;
    self.address.text = userInfo.address;
}
/**
 *  提交修改
 */
- (IBAction)commit:(UIButton *)sender {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] = @([TSLUser sharedUser].Identifier);
    param[@"Compellation"] = self.compellation.text;
    param[@"Telephone"] = self.telephone.text;
    param[@"mobilePhone"] = self.mobilePhone.text;
    param[@"address"] = self.address.text;
    [TSLHttpTool POST:[NSString stringWithFormat:@"%@%@",TSLAPI_PREFIX, TSLAPI_REGISTER] parameters:param success:^(id json) {
        TSLUserInfo *userInfo = [TSLUserInfo objectWithKeyValues:json];
        if (userInfo.state == YES) {
            [TSLUser saveUserInfo:userInfo]; // 保存用户信息
            [MBProgressHUD showSuccess:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [MBProgressHUD showError:userInfo.Message];
        }
    } failure:^(NSError *error) {
            [MBProgressHUD showError:@"未知错误"];
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
