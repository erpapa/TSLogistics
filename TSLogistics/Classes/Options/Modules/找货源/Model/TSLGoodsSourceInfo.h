//
//  TSLGoodsSourceInfo.h
//  TSLogistics
//
//  Created by erpapa on 15/11/17.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSLGoodsSourceInfo : NSObject

/** 消息标识 */
@property (assign, nonatomic) NSInteger Identifier;
/** 发布消息的用户id */
@property (assign, nonatomic) NSInteger User_Id;
/** 货物名称 */
@property (copy, nonatomic) NSString *NameCHN;
@property (assign, nonatomic) NSInteger TheState;
@property (copy, nonatomic) NSString *GoodsDescription;
/** 货物重量（t） */
@property (assign, nonatomic) float GoodsWeight;
/** 车辆类型（carType） */
@property (assign, nonatomic) NSInteger RequirementVehicleType;
@property (copy, nonatomic) NSString *RequirementVehicleDescription;
/** 起始地址 */
@property (copy, nonatomic) NSString *SendAddress;
/** 终点地址 */
@property (copy, nonatomic) NSString *ReceiveAddress;
/** 发货日期 */
@property (copy, nonatomic) NSString *BeginTime;
@property (copy, nonatomic) NSString *EndTime;
/** 备注 */
@property (copy, nonatomic) NSString *OtherRequire;
/** 发布日期 */
@property (copy, nonatomic) NSString *ReleaseTime;
/** 用户名 */
@property (copy, nonatomic) NSString *Person;
/** 联系电话 */
@property (copy, nonatomic) NSString *PersonTel;
@property (copy, nonatomic) NSString *StateName;
@property (copy, nonatomic) NSString *MainPerson;
/** 公司名(""是个人用户) */
@property (copy, nonatomic) NSString *CompanyName;
@property (copy, nonatomic) NSString *PersonId;
@property (assign, nonatomic) NSInteger ApplyNum;
/** 物体体积(立方米) */
@property (assign, nonatomic) float GoodsBulk;
/** 货物类型（goodsType1） */
@property (assign, nonatomic) NSInteger GoodsType;
/** 运输类型(1:整车,2:零担) */
@property (assign, nonatomic) NSInteger TransferType;
/** 期望运价（null则显示电议） */
@property (assign, nonatomic) float Price;
/** 运价单位（jiliangListType） */
@property (assign, nonatomic) NSInteger UnitType;
/** 有效期（天） */
@property (assign, nonatomic) NSInteger IsLongTime;
@property (assign, nonatomic) NSInteger IsLong;
@property (assign, nonatomic) NSInteger FromId;
@property (copy, nonatomic) NSString *MapX;
@property (copy, nonatomic) NSString *MapY;
@property (assign, nonatomic) float FromBegin;
@property (assign, nonatomic) float FromEnd;
@property (copy, nonatomic) NSString *Vtypes;
@property (copy, nonatomic) NSString *Vtypes2;
@property (copy, nonatomic) NSString *Keys;
@property (assign, nonatomic) NSInteger Num1;
@property (assign, nonatomic) NSInteger Num2;
@property (assign, nonatomic) NSInteger Num11;
@property (assign, nonatomic) NSInteger Num12;
@property (copy, nonatomic) NSString *CustomPerson;
@property (copy, nonatomic) NSString *CustomPersonTel;
/** 货物类型（goodsType2） */
@property (assign, nonatomic) NSInteger GoodsType2;
/** 货物类型（goodsType3） */
@property (assign, nonatomic) NSInteger GoodsType3;
/** 车长要求（起） */
@property (assign, nonatomic) float LengthBegin;
/** 车长要求（终） */
@property (assign, nonatomic) float LengthEnd;
/** 省id */
@property (assign, nonatomic) NSInteger proId;
/** 市id */
@property (assign, nonatomic) NSInteger cityId;
/** 区县id */
@property (assign, nonatomic) NSInteger countyId;
/** 起始-城市 */
@property (copy, nonatomic) NSString *CityName;
/** 起始-区县 */
@property (copy, nonatomic) NSString *DistrictName;
/** 省id */
@property (assign, nonatomic) NSInteger proId2;
/** 市id */
@property (assign, nonatomic) NSInteger cityId2;
/** 区县id */
@property (assign, nonatomic) NSInteger countyId2;
/** 终点-城市 */
@property (copy, nonatomic) NSString *CityName2;
/** 终点-区县 */
@property (copy, nonatomic) NSString *DistrictName2;
@property (assign, nonatomic) NSInteger valid;
@property (assign, nonatomic) NSInteger TradeId;
/** 发货频率 */
@property (copy, nonatomic) NSString *frequency;
@property (copy, nonatomic) NSString *Cycbegin;
@property (copy, nonatomic) NSString *Cycend;
@property (assign, nonatomic) NSInteger GoodsForms;
@property (assign, nonatomic) NSInteger PayMode;
@property (copy, nonatomic) NSString *Areamark;
@property (copy, nonatomic) NSString *Areamark2;
@property (copy, nonatomic) NSString *BDPixelX;
@property (copy, nonatomic) NSString *BDPixelY;
@property (copy, nonatomic) NSString *AudioName;
@property (assign, nonatomic) NSInteger AreaLevel;
@property (copy, nonatomic) NSString *iscollected;
@property (assign, nonatomic) NSInteger MatchCount;

/** 车辆类型str */
@property (copy, nonatomic) NSString *RequirementVehicleTypeString;
/** 货物类型str */
@property (copy, nonatomic) NSString *GoodsTypeString;
/** 运输类型str */
@property (copy, nonatomic) NSString *TransferTypeString;
/** 期望运价 */
@property (copy, nonatomic) NSString *PriceString;
/** 重量/体积 */
@property (copy, nonatomic) NSString *goodsWeightOrBulk;
/** 车长 */
@property (copy, nonatomic) NSString *LengthString;
/** 姓名 */
@property (copy, nonatomic) NSString *PersonString;
/** 电话 */
@property (copy, nonatomic) NSString *PersonTelString;
@end
