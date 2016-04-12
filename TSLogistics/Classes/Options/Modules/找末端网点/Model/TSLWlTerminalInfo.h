//
//  TSLWlTerminalInfo.h
//  TSLogistics
//
//  Created by erpapa on 15/12/31.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSLWlTerminalInfo : NSObject
@property (assign, nonatomic) NSInteger Identifier;
@property (assign, nonatomic) NSInteger User_Id;
/** 末端网点名 */
@property (copy, nonatomic) NSString *NameCHN;
@property (assign, nonatomic) NSInteger TheState;
/** 服务范围 */
@property (copy, nonatomic) NSString *TdScope;
/** 地址 */
@property (copy, nonatomic) NSString *TdAddress;
@property (copy, nonatomic) NSString *Description;
@property (copy, nonatomic) NSString *ReleaseTime;
@property (copy, nonatomic) NSString *MapX;
@property (copy, nonatomic) NSString *MapY;
/** 联系人 */
@property (copy, nonatomic) NSString *Person;
@property (copy, nonatomic) NSString *PersonTel;
@property (copy, nonatomic) NSString *StateName;
/** 所属区域 */
@property (copy, nonatomic) NSString *TdRegionName;
@property (copy, nonatomic) NSString *CompanyName;
@property (copy, nonatomic) NSString *CompanyInfo;
@property (assign, nonatomic) NSInteger PersonId;
@property (copy, nonatomic) NSString *Keys;
@property (copy, nonatomic) NSString *ArrayArea;
@property (copy, nonatomic) NSString *CustomPerson;
@property (copy, nonatomic) NSString *CustomPersonTel;
/** 末端类型 */
@property (assign, nonatomic) NSInteger TypeId;
@property (copy, nonatomic) NSString *CompanyAddress;
@property (assign, nonatomic) NSInteger ProId;
@property (assign, nonatomic) NSInteger CityId;
@property (assign, nonatomic) NSInteger CountyId;
@property (copy, nonatomic) NSString *Areamark;
@property (copy, nonatomic) NSString *Areamark2;
@property (copy, nonatomic) NSString *MainPerson;
@property (copy, nonatomic) NSString *iscollected;

/** 末端类型str */
@property (copy, nonatomic) NSString *TypeIdString;
/** 姓名 */
@property (copy, nonatomic) NSString *PersonString;
/** 电话 */
@property (copy, nonatomic) NSString *PersonTelString;
@end
