//
//  TSLWarehouseInfo.h
//  TSLogistics
//
//  Created by erpapa on 15/11/20.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSLWarehouseInfo : NSObject

/**  标识  */
@property (assign, nonatomic) NSInteger Identifier;
/** 发布消息的用户id */
@property (assign, nonatomic) NSInteger User_Id;
/**  仓库名  */
@property (copy, nonatomic) NSString *NameCHN;
@property (assign, nonatomic) NSInteger TheState;
/**  仓库地址  */
@property (copy, nonatomic) NSString *WHAddress;
/**  仓库面积  */
@property (assign, nonatomic) float WHArea;
/**  仓库剩余面积  */
@property (assign, nonatomic) float WHAreaRemaind;
/**  起租面积  */
@property (assign, nonatomic) float WHArealeast;
@property (assign, nonatomic) NSInteger WHRegion;
/** 仓库类型 */
@property (assign, nonatomic) NSInteger WHType;
@property (assign, nonatomic) NSInteger WHWeight;
@property (assign, nonatomic) NSInteger WHWeightRemaind;
/**  仓库介绍  */
@property (copy, nonatomic) NSString *Description;
/**  价格  */
@property (assign, nonatomic) float Price;
/** 价格单位 */
@property (assign, nonatomic) NSInteger UnitType;
/**  发布日期  */
@property (copy, nonatomic) NSString *ReleaseTime;
@property (copy, nonatomic) NSString *MapX;
@property (copy, nonatomic) NSString *MapY;
/**  仓库地理位置，县/区  */
@property (copy, nonatomic) NSString *DistrictName;
/**  企业照片  */
@property (copy, nonatomic) NSString *WhImg;
/**  联系人  */
@property (copy, nonatomic) NSString *Person;
/**  联系人电话  */
@property (copy, nonatomic) NSString *PersonTel;
/**  信息状态  */
@property (copy, nonatomic) NSString *StateName;
@property (copy, nonatomic) NSString *MainPerson;
@property (copy, nonatomic) NSString *RegionName;
/**  公司名称  */
@property (copy, nonatomic) NSString *CompanyName;
/**  公司信息  */
@property (copy, nonatomic) NSString *CompanyInfo;
/**  联系人ID  */
@property (assign, nonatomic) NSInteger PersonId;
@property (copy, nonatomic) NSString *ApplyNum;
@property (assign, nonatomic) NSInteger ValidityDay;
@property (assign, nonatomic) NSInteger FromId;
@property (assign, nonatomic) float FromBegin;
@property (assign, nonatomic) float FromEnd;
@property (copy, nonatomic) NSString *VTypes;
@property (copy, nonatomic) NSString *Keys;
/**  公司联系人  */
@property (copy, nonatomic) NSString *CustomPerson;
/**  联系人电话  */
@property (copy, nonatomic) NSString *CustomPersonTel;
@property (assign, nonatomic) NSInteger Typewc;
@property (assign, nonatomic) NSInteger Num1;
@property (assign, nonatomic) NSInteger Num2;
@property (assign, nonatomic) NSInteger Num11;
@property (assign, nonatomic) NSInteger Num12;
@property (assign, nonatomic) NSInteger cityId;
@property (assign, nonatomic) NSInteger countyId;
@property (assign, nonatomic) NSInteger proId;
@property (copy, nonatomic) NSString *ProvinceName;
@property (copy, nonatomic) NSString *CityName;
@property (copy, nonatomic) NSString *Areamark;
@property (copy, nonatomic) NSString *Areamark2;
@property (copy, nonatomic) NSString *BDPixelX;
@property (copy, nonatomic) NSString *BDPixelY;
@property (copy, nonatomic) NSString *iscollected;

/** 仓库类型 */
@property (copy, nonatomic) NSString *WHTypeString;
/** 价格 */
@property (copy, nonatomic) NSString *PriceString;
/** 姓名 */
@property (copy, nonatomic) NSString *PersonString;
/** 电话 */
@property (copy, nonatomic) NSString *PersonTelString;
@end
