//
//  TSLDistributionStationInfo.h
//  TSLogistics
//
//  Created by erpapa on 15/12/15.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSLDistributionStationInfo : NSObject
@property (assign, nonatomic) NSInteger Identifier;
@property (copy, nonatomic) NSString *LogisticsDescription;
@property (assign, nonatomic) NSInteger LogisticsType;
@property (copy, nonatomic) NSString *UserName;
@property (copy, nonatomic) NSString *Password;
@property (assign, nonatomic) NSInteger UserType;
@property (copy, nonatomic) NSString *AreaName;
/** 公司名 */
@property (copy, nonatomic) NSString *Company;
/** 地址 */
@property (copy, nonatomic) NSString *Address;
@property (copy, nonatomic) NSString *WebSite;
@property (copy, nonatomic) NSString *PixelX;
@property (copy, nonatomic) NSString *PixelY;
@property (copy, nonatomic) NSString *RoleID;
@property (copy, nonatomic) NSString *CompanyInfo;
@property (copy, nonatomic) NSString *MSN;
/** 电话号码，选其一 */
@property (copy, nonatomic) NSString *MobilePhone;
@property (copy, nonatomic) NSString *Telephone;
@property (copy, nonatomic) NSString *QQ;
@property (copy, nonatomic) NSString *Email;
@property (copy, nonatomic) NSString *Fax;
/** 联系人 */
@property (copy, nonatomic) NSString *Compellation;
@property (copy, nonatomic) NSString *TailState;
@property (copy, nonatomic) NSString *TailDate;
@property (copy, nonatomic) NSString *CreateDate;
@property (copy, nonatomic) NSString *PasswordDES;
@property (copy, nonatomic) NSString *Keys;
@property (assign, nonatomic) BOOL Ispersonal;
@property (assign, nonatomic) BOOL IsRecommendCompany;
@property (assign, nonatomic) BOOL IsVisible;
@property (assign, nonatomic) NSInteger DealerID;
@property (assign, nonatomic) NSInteger DealerName;
@property (assign, nonatomic) NSInteger FromDate;
@property (assign, nonatomic) NSInteger EndDate;
@property (copy, nonatomic) NSString *LogoFilePath;
@property (assign, nonatomic) NSInteger ProductionCompany;
@property (copy, nonatomic) NSString *OpenIdQQ;
@property (assign, nonatomic) BOOL IsMapPoint;
@property (copy, nonatomic) NSString *AreaArray;
@property (copy, nonatomic) NSString *WbId;
@property (assign, nonatomic) NSInteger proId;
@property (assign, nonatomic) NSInteger cityId;
@property (assign, nonatomic) NSInteger countyId;
@property (copy, nonatomic) NSString *CityName;
/*** 所属地区 ***/
@property (copy, nonatomic) NSString *DistrictName;
@property (copy, nonatomic) NSString *TailDateSearch;
@property (assign, nonatomic) NSInteger Memberlevel;
@property (copy, nonatomic) NSString *vnumber;
/*** 分割 ***/
@property (assign, nonatomic) BOOL TailAvailable;
@property (copy, nonatomic) NSString *PicStyle;
@property (copy, nonatomic) NSString *MailAddress;
@property (assign, nonatomic) NSInteger AuthenState;
@property (assign, nonatomic) NSInteger TypeOfCompany;
@property (copy, nonatomic) NSString *RegisterNo;
@property (copy, nonatomic) NSString *legalPerson;
@property (copy, nonatomic) NSString *RegisterDate;
@property (copy, nonatomic) NSString *RegisterCapital;
@property (copy, nonatomic) NSString *PostCode;
@property (copy, nonatomic) NSString *Areamark;
@property (copy, nonatomic) NSString *Areamark2;
@property (copy, nonatomic) NSString *Photos;
@property (copy, nonatomic) NSString *BDPixelX;
@property (copy, nonatomic) NSString *BDPixelY;
@property (copy, nonatomic) NSString *LogisticsTypeList;

/*
 "vtype": null,
 "vweight": null,
 "vlength": null,
 "bpro": null,
 "bcity": null,
 "bcounty": null,
 "epro": null,
 "ecity": null,
 "ecounty": null,
 "wayOftrans": "",
 "Transtype": null,
 "Goodstype": null,
 "PackagingType": null,
 "VehicleType": null,
 "Payment": null,
 "Protectment": null,
 "UpDown": null,
 "UpDownType": null,
 */
/** 电话 */
@property (copy, nonatomic) NSString *PersonTelString;

@end
