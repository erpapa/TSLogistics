//
//  TSLUser.h
//  TSLogistics
//
//  Created by erpapa on 15/11/14.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSLUserInfo.h"
@interface TSLUser : NSObject
/** 用户标识 */
@property (assign, nonatomic) NSInteger Identifier;
/** 登录名 */
@property (copy, nonatomic) NSString *UserName;
/** user单例 */
+ (instancetype)sharedUser;
/** TSLUserInfo对象 */
+ (TSLUserInfo *)UserInfo;
/** 保存TSLUserInfo对象 */
+ (void)saveUserInfo:(TSLUserInfo *)userInfo;

@end
