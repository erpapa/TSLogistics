//
//  TSLCollectInfo.h
//  TSLogistics
//
//  Created by erpapa on 15/12/8.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSLCollectInfo : NSObject
@property (assign, nonatomic) NSInteger Identifier;
@property (assign, nonatomic) NSInteger UserId;
@property (copy, nonatomic) NSString *Company;
/** 地址 */
@property (copy, nonatomic) NSString *Address;
/** 联系人 */
@property (copy, nonatomic) NSString *Compellation;
@property (copy, nonatomic) NSString *MobilePhone;
@property (copy, nonatomic) NSString *Telephone;
@property (assign, nonatomic) NSInteger LogisticsId;
/** 收藏的消息类型 */
@property (copy, nonatomic) NSString *LogisticsType;
@property (copy, nonatomic) NSString *AreaName;
@property (assign, nonatomic) NSInteger AreaID;
@property (copy, nonatomic) NSString *ReleaseTime;
@property (assign, nonatomic) NSInteger TheState;
/** 地址 */
@property (copy, nonatomic) NSString *xAddress;
/** 类型 */
@property (copy, nonatomic) NSString *TypeName;
/** 名称 */
@property (copy, nonatomic) NSString *NameCHN;
/** 发货地址 */
@property (copy, nonatomic) NSString *SendAddress;
/** 目的地址 */
@property (copy, nonatomic) NSString *ReceiveAddress;
@property (assign, nonatomic) NSInteger Area;
@property (assign, nonatomic) NSInteger ExistEnterprisesNum;
@property (assign, nonatomic) float Weight;
@property (assign, nonatomic) float Length;
@property (copy, nonatomic) NSString *SaveType;
@property (assign, nonatomic) NSInteger PersonId;
/** 姓名首字母 */
@property (copy, nonatomic) NSString *firstLetterStr;
@end
