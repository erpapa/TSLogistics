//
//  TSLVehicleSourceParam.h
//  TSLogistics
//
//  Created by erpapa on 15/11/18.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSLVehicleSourceParam : NSObject
/** 返回的数据中iscollected = "1"表示已收藏 */
@property (assign, nonatomic) NSInteger collectid;
/** 消息标识 */
@property (assign, nonatomic) NSInteger identifier;
@property (assign, nonatomic) NSInteger userId;
@property (assign, nonatomic) NSInteger page;
@property (assign, nonatomic) NSInteger length;
@property (copy, nonatomic) NSString *keys;
@property (copy, nonatomic) NSString *vtypes;
@property (assign, nonatomic) NSInteger num1;
@property (assign, nonatomic) NSInteger num2;
@property (assign, nonatomic) NSInteger CityId;
@property (assign, nonatomic) NSInteger CityId2;
@property (assign, nonatomic) NSInteger CountyId;
@property (assign, nonatomic) NSInteger CountyId2;
@property (assign, nonatomic) NSInteger ProvinceId;
@property (assign, nonatomic) NSInteger ProvinceId2;
@end
