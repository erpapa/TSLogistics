//
//  TSLRegisterParam.h
//  TSLogistics
//
//  Created by erpapa on 15/11/14.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSLRegisterParam : NSObject
/**
 *  昵称
 */
@property (copy, nonatomic) NSString *username;
/**
 *  姓名
 */
@property (copy, nonatomic) NSString *compellation;
/**
 *  公司名称
 */
@property (copy, nonatomic) NSString *company;
/**
 *  手机号
 */
@property (copy, nonatomic) NSString *mobilePhone ;
/**
 *  密码
 */
@property (copy, nonatomic) NSString *Password;
/**
 *  确认密码
 */
@property (copy, nonatomic) NSString *rePwd;
/**
 *  WLIOS
 */
@property (copy, nonatomic) NSString *Register;
/**
 *  用户类型
 */
@property (assign, nonatomic) NSInteger usertype;
/**
 *  Ltypeid
 */
@property (assign, nonatomic) NSInteger Ltypeid;
/**
 *  省
 */
@property (assign, nonatomic) NSInteger ProvinceId;
/**
 *  市
 */
@property (assign, nonatomic) NSInteger CityId;
/**
 *  区、县
 */
@property (assign, nonatomic) NSInteger CountyId;
@end
