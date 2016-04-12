//
//  TSLExpressStationInfo.h
//  TSLogistics
//
//  Created by erpapa on 15/12/31.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSLExpressStationInfo : NSObject
@property (assign, nonatomic) NSInteger Identifier;
@property (assign, nonatomic) NSInteger User_Id;
/** 快递网点名 */
@property (copy, nonatomic) NSString *NameCHN;
@property (assign, nonatomic) NSInteger TheState;
/** 所属公司 */
@property (assign, nonatomic) NSInteger ESCompany;
/** 服务范围 */
@property (copy, nonatomic) NSString *ESScope;
/** 地址 */
@property (copy, nonatomic) NSString *ESAddress;
@property (copy, nonatomic) NSString *Description;
@property (copy, nonatomic) NSString *ReleaseTime;
@property (copy, nonatomic) NSString *MapX;
@property (copy, nonatomic) NSString *MapY;
/** 联系人 */
@property (copy, nonatomic) NSString *Person;
@property (copy, nonatomic) NSString *PersonTel;
@property (copy, nonatomic) NSString *StateName;
@property (copy, nonatomic) NSString *MainPerson;
/** 所属区域 */
@property (copy, nonatomic) NSString *ESRegionName;
@property (copy, nonatomic) NSString *CompanyName;
@property (copy, nonatomic) NSString *CompanyInfo;
@property (assign, nonatomic) NSInteger PersonId;
@property (copy, nonatomic) NSString *Keys;
@property (copy, nonatomic) NSString *ArrayArea;
@property (copy, nonatomic) NSString *CustomPerson;
@property (copy, nonatomic) NSString *CustomPersonTel;
/** 快递类型 */
@property (assign, nonatomic) NSInteger ESType;
@property (assign, nonatomic) NSInteger IsShangMen;
@property (assign, nonatomic) NSInteger ProId;
@property (assign, nonatomic) NSInteger CityId;
@property (assign, nonatomic) NSInteger CountyId;
@property (copy, nonatomic) NSString *Areamark;
@property (copy, nonatomic) NSString *Areamark2;
@property (copy, nonatomic) NSString *BDPixelX;
@property (copy, nonatomic) NSString *BDPixelY;
@property (copy, nonatomic) NSString *iscollected;

/** 快递类型str */
@property (copy, nonatomic) NSString *ESTypeString;
/** 所属公司str */
@property (copy, nonatomic) NSString *ESCompanyString;
/** 姓名 */
@property (copy, nonatomic) NSString *PersonString;
/** 电话 */
@property (copy, nonatomic) NSString *PersonTelString;
@end
