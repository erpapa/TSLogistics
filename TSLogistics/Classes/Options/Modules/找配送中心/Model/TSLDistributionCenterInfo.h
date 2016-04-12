//
//  TSLDistributionCenterInfo.h
//  TSLogistics
//
//  Created by erpapa on 15/12/30.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSLDistributionCenterInfo : NSObject
@property (assign, nonatomic) NSInteger Identifier;
@property (assign, nonatomic) NSInteger User_Id;
/** 公司名称 */
@property (copy, nonatomic) NSString *NameCHN;
@property (assign, nonatomic) NSInteger TheState;
/** 地址 */
@property (copy, nonatomic) NSString *DCAddress;
/** 客户数量 */
@property (assign, nonatomic) NSInteger KehuCount;
/** 服务区域 */
@property (copy, nonatomic) NSString *ServerRegion;
@property (copy, nonatomic) NSString *Description;
@property (copy, nonatomic) NSString *ReleaseTime;
@property (copy, nonatomic) NSString *MapX;
@property (copy, nonatomic) NSString *MapY;
/** 联系人 */
@property (copy, nonatomic) NSString *Person;
/** 联系电话 */
@property (copy, nonatomic) NSString *PersonTel;
@property (copy, nonatomic) NSString *StateName;
@property (copy, nonatomic) NSString *MainPerson;
/** 所属区域 */
@property (copy, nonatomic) NSString *DCRegionName;
@property (copy, nonatomic) NSString *CompanyName;
@property (copy, nonatomic) NSString *CompanyInfo;
@property (assign, nonatomic) NSInteger PersonId;
@property (assign, nonatomic) NSInteger ApplyNum;
/** 类别 */
@property (assign, nonatomic) NSInteger ServerType;
@property (copy, nonatomic) NSString *ServerTypes;
@property (copy, nonatomic) NSString *Keys;
@property (copy, nonatomic) NSString *CustomPerson;
@property (copy, nonatomic) NSString *CustomPersonTel;
@property (copy, nonatomic) NSString *ArrayArea;
@property (assign, nonatomic) NSInteger proId;
@property (assign, nonatomic) NSInteger cityId;
@property (assign, nonatomic) NSInteger countyId;
@property (copy, nonatomic) NSString *Areamark;
@property (copy, nonatomic) NSString *Areamark2;
@property (copy, nonatomic) NSString *iscollected;

/** 类别str */
@property (copy, nonatomic) NSString *ServerTypeString;
/** 姓名 */
@property (copy, nonatomic) NSString *PersonString;
/** 电话 */
@property (copy, nonatomic) NSString *PersonTelString;

@end
