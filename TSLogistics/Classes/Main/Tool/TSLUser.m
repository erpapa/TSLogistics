//
//  TSLUser.m
//  TSLogistics
//
//  Created by erpapa on 15/11/14.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLUser.h"

@implementation TSLUser
static TSLUser *instance;

+ (id)allocWithZone:(struct _NSZone *)zone
{
    // dispatch_once是线程安全的，onceToken默认为0
    static dispatch_once_t onceToken;
    // dispatch_once宏可以保证块代码中的指令只被执行一次
    dispatch_once(&onceToken, ^{
        // 在多线程环境下，永远只会被执行一次，instance只会被实例化一次
        instance = [super allocWithZone:zone];
    });
    
    return instance;
}
+ (instancetype)sharedUser
{
    if (instance == nil) {
        instance = [[self alloc] init];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        BOOL autoLogin = [defaults boolForKey:@"autoLogin"];
        if (autoLogin == YES) {// 在自动登录的情况下才加载用户信息
            TSLUserInfo *userInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:TSLUserInfoPath];
            instance.Identifier = userInfo.Identifier;
            instance.UserName = userInfo.UserName;
        }
    }
    return instance;
}

+ (TSLUserInfo *)UserInfo
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:TSLUserInfoPath];
}

+ (void)saveUserInfo:(TSLUserInfo *)userInfo
{
    instance.Identifier = userInfo.Identifier;
    instance.UserName = userInfo.UserName;
    // 归档保存
    [NSKeyedArchiver archiveRootObject:userInfo toFile:TSLUserInfoPath];
}

@end
