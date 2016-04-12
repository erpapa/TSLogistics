//
//  TSLVehicleSourceInfo.h
//  TSLogistics
//
//  Created by erpapa on 15/11/18.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSLVehicleSourceInfo : NSObject

/** 消息标识 */
@property (assign, nonatomic) NSInteger Identifier;
/** 发布消息的用户id */
@property (assign, nonatomic) NSInteger User_Id;
/** 车牌号 */
@property (copy, nonatomic) NSString *NameCHN;
@property (assign, nonatomic) NSInteger TheState;
/** 车辆类型（carType） */
@property (assign, nonatomic) NSInteger VehicleType;
@property (copy, nonatomic) NSString *VehicleDescription;
@property (copy, nonatomic) NSString *Master;
/** 发车日期 */
@property (copy, nonatomic) NSString *BeginTime;
@property (copy, nonatomic) NSString *EndTime;
/** 车辆载重  */
@property (assign, nonatomic) float Weight;
/** 剩余载重  */
@property (assign, nonatomic) float WeightRemaind;
/** 车长  */
@property (assign, nonatomic) float Length;
/** 起始地址  */
@property (copy, nonatomic) NSString *DepartureAddress;
/** 终点地址  */
@property (copy, nonatomic) NSString *DestinationAddress;
/** 备注  */
@property (copy, nonatomic) NSString *OtherRequire;
/** 发布日期  */
@property (copy, nonatomic) NSString *ReleaseTime;
/** 车主  */
@property (copy, nonatomic) NSString *Person;
/** 电话号码  */
@property (copy, nonatomic) NSString *PersonTel;
@property (copy, nonatomic) NSString *StateName;
@property (copy, nonatomic) NSString *MainPerson;
/** 公司名  */
@property (copy, nonatomic) NSString *CompanyName;
/** 公司信息  */
@property (copy, nonatomic) NSString *CompanyInfo;
@property (assign, nonatomic) NSInteger PersonId;
/** 运输价格  */
@property (assign, nonatomic) float Price;
/** 运输类型(1:整车,2:零担) */
@property (assign, nonatomic) NSInteger PriceType;
/** 运价单位（jiliangListType） */
@property (assign, nonatomic) NSInteger PriceUnit;
@property (copy, nonatomic) NSString *MapX;
@property (copy, nonatomic) NSString *MapY;
@property (assign, nonatomic) NSInteger ApplyNum;
@property (assign, nonatomic) NSInteger FromId;
@property (assign, nonatomic) float FromBegin;
@property (assign, nonatomic) float FromEnd;
@property (copy, nonatomic) NSString *VTypes;
@property (copy, nonatomic) NSString *Keys;
@property (copy, nonatomic) NSString *CustomPerson;
@property (copy, nonatomic) NSString *CustomPersonTel;
/** 货物类型(1:重货,2:泡货)  */
@property (assign, nonatomic) NSInteger TransGoodsType;
@property (copy, nonatomic) NSString *TransGoodsTypeName;
@property (assign, nonatomic) NSInteger proId;
@property (assign, nonatomic) NSInteger cityId;
@property (assign, nonatomic) NSInteger countyId;
@property (copy, nonatomic) NSString *CityName;
@property (copy, nonatomic) NSString *DistrictName;
@property (assign, nonatomic) NSInteger proId2;
@property (assign, nonatomic) NSInteger cityId2;
@property (assign, nonatomic) NSInteger countyId2;
@property (copy, nonatomic) NSString *CityName2;
@property (copy, nonatomic) NSString *DistrictName2;
@property (assign, nonatomic) NSInteger TradeId;
@property (assign, nonatomic) NSInteger VehicleId;
/** Vip  */
@property (assign, nonatomic) NSInteger Isvip;
@property (assign, nonatomic) NSInteger VehicleBrand;
@property (copy, nonatomic) NSString *Areamark;
@property (copy, nonatomic) NSString *Areamark2;
@property (copy, nonatomic) NSString *fromdate;
@property (copy, nonatomic) NSString *enddate;
@property (copy, nonatomic) NSString *AudioName;
@property (assign, nonatomic) NSInteger AreaLevel;
@property (copy, nonatomic) NSString *iscollected;
@property (assign, nonatomic) NSInteger MatchCount;


/** 车辆类型str */
@property (copy, nonatomic) NSString *VehicleTypeString;
/** 货物类型str */
@property (copy, nonatomic) NSString *TransGoodsTypeString;
/** 运输类型str */
@property (copy, nonatomic) NSString *PriceTypeString;
/** 运输价格 */
@property (copy, nonatomic) NSString *PriceString;
/** 姓名 */
@property (copy, nonatomic) NSString *PersonString;
/** 电话 */
@property (copy, nonatomic) NSString *PersonTelString;
@end
