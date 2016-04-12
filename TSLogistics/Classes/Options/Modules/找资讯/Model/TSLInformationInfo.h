//
//  TSLInformationInfo.h
//  TSLogistics
//
//  Created by erpapa on 15/11/26.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSLInformationInfo : NSObject
@property (assign, nonatomic) NSInteger Identifier;
@property (assign, nonatomic) NSInteger User_Id;
/** 消息简介 */
@property (copy, nonatomic) NSString *NameCHN;
@property (assign, nonatomic) NSInteger TheState;
/** 资讯类型 */
@property (assign, nonatomic) NSInteger DIType;
/** 内容 */
@property (copy, nonatomic) NSString *Content;
@property (copy, nonatomic) NSString *Description;
@property (copy, nonatomic) NSString *ReleaseTime;
@property (copy, nonatomic) NSString *DITypeName;
@property (assign, nonatomic) NSInteger Source;
@property (assign, nonatomic) NSInteger DealerID;
@property (copy, nonatomic) NSString *DealerName;
/** 来源 */
@property (copy, nonatomic) NSString *SourceName;
@property (copy, nonatomic) NSString *KeyWords;
@property (assign, nonatomic) NSInteger dateb;
@property (assign, nonatomic) NSInteger datee;
@property (assign, nonatomic) NSInteger ToXH;
@property (copy, nonatomic) NSString *XHNewsClass;
@property (assign, nonatomic) NSInteger Xhid;
@property (assign, nonatomic) NSInteger IsHot;
@property (copy, nonatomic) NSString *Url;
@property (assign, nonatomic) NSInteger DescriptionType;
@property (copy, nonatomic) NSString *Zc_frm;
@property (assign, nonatomic) NSInteger OaId;
@property (assign, nonatomic) NSInteger countField;
@property (assign, nonatomic) NSInteger IsRecommend;
@property (copy, nonatomic) NSString *RecommendPic;
@property (copy, nonatomic) NSString *InfoSource;
@property (copy, nonatomic) NSString *InfoSourceAddress;
@property (copy, nonatomic) NSString *Areamark;
@property (copy, nonatomic) NSString *Areamark2;

@property (copy, nonatomic) NSString *ContentString;

@end
