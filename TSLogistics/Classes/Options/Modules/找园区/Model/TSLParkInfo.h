//
//  TSLParkInfo.h
//  TSLogistics
//
//  Created by erpapa on 15/12/15.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSLParkInfo : NSObject
@property (assign, nonatomic) NSInteger Identifier;
@property (assign, nonatomic) NSInteger User_Id;
@property (copy, nonatomic) NSString *NameCHN;
@property (assign, nonatomic) NSInteger TheState;
/** 园区类型 */
@property (assign, nonatomic) NSInteger LPType;
/** 地址 */
@property (copy, nonatomic) NSString *LPAddress;
/** 占地面积/亩 */
@property (assign, nonatomic) float LPArea;
/** 闲置面积/亩 */
@property (assign, nonatomic) float LPAreaRemaind;
/** 入驻企业 */
@property (assign, nonatomic) NSInteger ExistEnterprisesNum;
/** 可入驻企业 */
@property (assign, nonatomic) NSInteger EnterprisesNum;
/** 园区描述 */
@property (copy, nonatomic) NSString *Description;
@property (copy, nonatomic) NSString *ReleaseTime;
@property (copy, nonatomic) NSString *MapX;
@property (copy, nonatomic) NSString *MapY;
@property (copy, nonatomic) NSString *Person;
@property (copy, nonatomic) NSString *PersonTel;
@property (copy, nonatomic) NSString *StateName;
@property (copy, nonatomic) NSString *MainPerson;
/** 公司名 */
@property (copy, nonatomic) NSString *CompanyName;
@property (copy, nonatomic) NSString *CompanyInfo;
@property (assign, nonatomic) NSInteger PersonId;
@property (assign, nonatomic) NSInteger ApplyNum;
@property (copy, nonatomic) NSString *Keys;
@property (copy, nonatomic) NSString *ArrayArea;
@property (copy, nonatomic) NSString *CustomPerson;
@property (copy, nonatomic) NSString *CustomPersonTel;
@property (copy, nonatomic) NSString *LogoFilePath;
/** 场地面积：亩 */
@property (assign, nonatomic) float CDArea;
/** 仓储面积:m² */
@property (assign, nonatomic) float CCArea;
/** 辐射范围 */
@property (copy, nonatomic) NSString *FSrange;
/** 新办主体 */
@property (copy, nonatomic) NSString *xingban;
@property (copy, nonatomic) NSString *LPImg;
@property (assign, nonatomic) NSInteger proId;
@property (assign, nonatomic) NSInteger cityId;
@property (assign, nonatomic) NSInteger countyId;
@property (copy, nonatomic) NSString *ProvinceName;
@property (copy, nonatomic) NSString *CityName;
/** 所属区域 */
@property (copy, nonatomic) NSString *DistrictName;
@property (copy, nonatomic) NSString *Areamark;
@property (copy, nonatomic) NSString *Areamark2;
@property (copy, nonatomic) NSString *BDPixelX;
@property (copy, nonatomic) NSString *BDPixelY;
@property (copy, nonatomic) NSString *iscollected;

/** 姓名 */
@property (copy, nonatomic) NSString *PersonString;
/** 电话 */
@property (copy, nonatomic) NSString *PersonTelString;
@property (copy, nonatomic) NSString *LPTypeString;
@end
