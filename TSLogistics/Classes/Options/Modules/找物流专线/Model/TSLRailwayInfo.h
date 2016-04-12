//
//  TSLRailwayInfo.h
//  TSLogistics
//
//  Created by erpapa on 15/12/15.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSLRailwayInfo : NSObject
@property (assign, nonatomic) NSInteger Identifier;
@property (assign, nonatomic) NSInteger User_Id;
@property (assign, nonatomic) NSInteger TheState;
/** 物流专线类型 */
@property (assign, nonatomic) NSInteger DSType;
@property (copy, nonatomic) NSString *TypeName;
@property (assign, nonatomic) NSInteger AreaLevel;
/** 公司地址 */
@property (copy, nonatomic) NSString *DSAddress;
@property (copy, nonatomic) NSString *Description;
/** 发布日期 */
@property (copy, nonatomic) NSString *ReleaseTime;
@property (copy, nonatomic) NSString *MapX;
@property (copy, nonatomic) NSString *MapY;
/** 联系人 */
@property (copy, nonatomic) NSString *Person;
/** 联系人电话 */
@property (copy, nonatomic) NSString *PersonTel;
@property (copy, nonatomic) NSString *StateName;
@property (copy, nonatomic) NSString *MainPerson;
@property (copy, nonatomic) NSString *DSRegionName;
/** 起始地址 */
@property (copy, nonatomic) NSString *SendRegionName;
/** 终点地址 */
@property (copy, nonatomic) NSString *ReceiveRegionName;
/** 公司名 */
@property (copy, nonatomic) NSString *CompanyName;
@property (copy, nonatomic) NSString *CompanyInfo;
@property (assign, nonatomic) NSInteger PersonId;
@property (copy, nonatomic) NSString *Keys;
@property (copy, nonatomic) NSString *RailwayDetail;
@property (assign, nonatomic) float Price;
@property (assign, nonatomic) NSInteger PriceType;
@property (assign, nonatomic) NSInteger PriceUnit;
@property (copy, nonatomic) NSString *CustomPerson;
@property (copy, nonatomic) NSString *CustomPersonTel;
@property (assign, nonatomic) NSInteger TransGoodsType;
/** 车辆类型 */
@property (assign, nonatomic) NSInteger VehicleType;
@property (assign, nonatomic) float Weight;
@property (assign, nonatomic) float Length;
@property (assign, nonatomic) float Num3;
@property (assign, nonatomic) float Num4;
@property (assign, nonatomic) NSInteger proId;
@property (assign, nonatomic) NSInteger cityId;
@property (assign, nonatomic) NSInteger countyId;
@property (copy, nonatomic) NSString *ProvinceName;
@property (copy, nonatomic) NSString *CityName;
@property (copy, nonatomic) NSString *DistrictName;
@property (assign, nonatomic) NSInteger proId2;
@property (assign, nonatomic) NSInteger cityId2;
@property (assign, nonatomic) NSInteger countyId2;
@property (copy, nonatomic) NSString *ProvinceName2;
@property (copy, nonatomic) NSString *CityName2;
@property (copy, nonatomic) NSString *DistrictName2;
@property (copy, nonatomic) NSString *Areamark;
@property (copy, nonatomic) NSString *Areamark2;
@property (copy, nonatomic) NSString *fromdate;
@property (copy, nonatomic) NSString *enddate;
@property (copy, nonatomic) NSString *iscollected;

/** 姓名 */
@property (copy, nonatomic) NSString *PersonString;
/** 电话 */
@property (copy, nonatomic) NSString *PersonTelString;
/** 专线类型str */
@property (copy, nonatomic) NSString *DSTypeString;
/** 货物类型str */
@property (copy, nonatomic) NSString *TransGoodsTypeString;
/** 运输类型str */
@property (copy, nonatomic) NSString *PriceTypeString;
/** 运输价格str */
@property (copy, nonatomic) NSString *PriceString;
/** 车辆类型str */
@property (copy, nonatomic) NSString *VehicleTypeString;
@end
