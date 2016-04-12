//
//  TSLChangePasswordController.m
//  TSLogistics
//
//  Created by erpapa on 15/11/14.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLChangePasswordController.h"
#import "TSLHttpTool.h"
#import "TSLUser.h"
#import "MBProgressHUD+MJ.h"

@interface TSLChangePasswordController ()
@property (weak, nonatomic) IBOutlet UITextField *oldpwd;
@property (weak, nonatomic) IBOutlet UITextField *newpwd;
@property (weak, nonatomic) IBOutlet UITextField *repwd;

@end

@implementation TSLChangePasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)commit:(UIButton *)sender {
    if (![self.newpwd.text isEqualToString:self.repwd.text]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请确认密码输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    } else {
        [TSLHttpTool POST:[NSString stringWithFormat:@"%@%@",TSLAPI_PREFIX, TSLAPI_SAVEPWD] parameters:@{@"userid":@([TSLUser sharedUser].Identifier),@"oldpwd":self.oldpwd.text,@"newpwd":self.newpwd.text} success:^(id json) {
            if ([[json valueForKey:@"succ"] boolValue] == YES) {
                [MBProgressHUD showSuccess:@"修改成功"];
                [TSLUser saveUserInfo:nil];
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                [MBProgressHUD showError:@"修改失败"];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD showError:@"未知错误"];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
