//
//  TSLUserInfo.h
//  TSLogistics
//
//  Created by erpapa on 15/11/14.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSLUserInfo : NSObject
/**
 *  登录返回状态
 */
@property (assign, nonatomic) BOOL state;
/**
 *  返回的消息
 */
@property (copy, nonatomic) NSString *Message;
/**
 *  用户标识
 */
@property (assign, nonatomic) NSInteger Identifier;
/**
 *  登录名
 */
@property (copy, nonatomic) NSString *UserName;
/**
 *  用户类型
 */
@property (assign, nonatomic) NSInteger UserType;
/**
 *  级别
 */
@property (assign, nonatomic) NSInteger Memberlevel;
/**
 *  城市名
 */
@property (copy, nonatomic) NSString *CityName;
/**
 *  地址
 */
@property (copy, nonatomic) NSString *address;
/**
 *  联系人姓名
 */
@property (copy, nonatomic) NSString *DistrictName;
/**
 *  公司名
 */
@property (copy, nonatomic) NSString *Company;
/**
 *  用户名
 */
@property (copy, nonatomic) NSString *Compellation;
/**
 *  联系电话
 */
@property (copy, nonatomic) NSString *Telephone;
/**
 *  手机号
 */
@property (copy, nonatomic) NSString *MobilePhone;
/**
 *  用户注册时间
 */
@property (copy, nonatomic) NSString *CreateDate;
/**
 *  头像
 */
@property (copy, nonatomic) NSString *HeadImage;

@end
