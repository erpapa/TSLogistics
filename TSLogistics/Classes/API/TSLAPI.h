//
//  TSLAPI.h
//  TSLogistics
//
//  Created by erpapa on 15/11/9.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#ifndef TSLogistics_TSLAPI_h
#define TSLogistics_TSLAPI_h
// 找企业-->类型
typedef NS_ENUM(NSUInteger, SearchUserInfoType) {
    ChangCu = 1,            //仓储公司
    WuLiuYuanQu = 18,       //物流园区
    PeiSongZhongXin = 5,    //配送中心
    HuoYunDaiLi = 15,       //货运代理
    PeiHuoZhanDian = 9,     //配货站点
    YunShuGongSi = 4,       //运输公司
    CheDui = 10,            //车队
    ShuiYunWuLiu = 30,      //水运物流
    KongYunWuLiu = 31,      //空运物流
    KuaiDiGongSi = 3,       //快递公司
    GangKouWuLiu = 8,       //港口物流
    LengLianWuLiu = 6,      //冷链物流
    YiYaoWuLiu = 7,         //医药物流
    TeShuWuLiu = 25,        //特殊物流
    QiTaWuLiu = 14,         //其他物流
    MoDuanWangDian = 16,    //末端网点
    WuLiuJinRong = 11,      //物流金融
    WuLiuSheBei = 13,       //物流设备
    // 发货企业：GoodsMasterList2
    JiaYouZhan = 20,        //加油站
    JiaQiZhan = 19,         //加气站
    WeiXiuChang = 21        //汽车维修厂
};

#define TSLAPI_PREFIX @"http://www.560315.com/MobileAPI/"
#define TSLAPI_UPDATE @"versionIOS" //更新
#define TSLAPI_MAP @"getMapPoint"   //地图
#define TSLAPI_SHARE @"shareList"   //分享
#define TSLAPI_LOGIN @"Login"       //登录
#define TSLAPI_REGISTER @"SaveUser" //注册
#define TSLAPI_SAVEPWD @"SavePwd"   //修改密码
#define TSLAPI_RECOMMEND @"InformationRecommend"          //热点关注

#define TSLAPI_GoodsSource @"WlGoodsSourceInfoList"       //货源
#define TSLAPI_VehicleSource @"SearchWlVehicleSourceInfo" //车源
#define TSLAPI_Warehouse @"WarehouseList"                 //库源
// 第1列
#define TSLAPI_DistributionStation @"DistributionStationList"   //配货站
// 找加油站 SearchUserInfo?type=20
// 找加气站 SearchUserInfo?type=19
// 找维修站 SearchUserInfo?type=21
// 第2列
#define TSLAPI_Railway @"LogisticsRailwayList"          //物流专线
// 找物流企业 SearchUserInfo
#define TSLAPI_GoodsMasterList2 @"GoodsMasterList2"     //发货企业
#define TSLAPI_DistributionCenter @"DistributionCenterList"     //配送中心
#define TSLAPI_ExpressStation @"ExpressStationList"             //快递网点
#define TSLAPI_Terminal @"WlTerminalList"                       //末端网点
// 第3列
#define TSLAPI_Park @"LogisticsParkList"                        //园区
#define TSLAPI_shebei @"WlshebeiList"                           //设备
#define TSLAPI_Finance @"LogisticsFinanceList"                  //金融
#define TSLAPI_People @"Hrm_ResumeList"                         //人才
#define TSLAPI_Specialyer @"Specialyer"                         //专家
// 第4列
#define TSLAPI_Information @"SearchInformationList"     //资讯
#define TSLAPI_Price @"SearchLookForPrice"              //运价
// 找统计
#define TSLAPI_Company @"Hrm_CompanyList"               //招聘

#define TSLAPI_AudioAdd @"AudioAdd"             // 音频
#define TSLAPI_FeedBackSave @"FeedBackSave"     // 音频返回提交
#define TSLAPI_CollectionSave @"User_CollectionSave"    // 收藏
#define User_CollectionList @"User_CollectionList"    // 收藏列表
#define TSLAPI_IMAGES @"http://www.560315.com/Content/Web/images/Information/"//图片
#endif
