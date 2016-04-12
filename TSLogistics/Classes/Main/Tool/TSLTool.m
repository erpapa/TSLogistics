//
//  TSLDict.m
//  TSLogistics
//
//  Created by erpapa on 15/11/21.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLTool.h"

@implementation TSLTool

/**
 *  车辆类型
 */
+ (NSString *)stringWithVehicleType:(NSInteger)vehicleType
{
    NSDictionary *carType = @{@(32):@"集装箱车",
                              @(25):@"低栏车",
                              @(33):@"前四后四",
                              @(26):@"平板车",
                              @(19):@"其他",
                              @(34):@"前四后八",
                              @(27):@"半挂",
                              @(12):@"自卸车",
                              @(1):@"大型卡车",
                              @(28):@"全挂",
                              @(20):@"厢式车",
                              @(29):@"加长挂",
                              @(21):@"敞篷车",
                              @(4):@"单车",
                              @(22):@"罐式车",
                              @(30):@"拖挂",
                              @(23):@"高栏车",
                              @(16):@"牵引车",
                              @(31):@"冷藏车",
                              @(24):@"中栏车"
                              };
    return [carType objectForKey:@(vehicleType)];
}
/**
 *  货物类型
 */
+ (NSString *)stringWithGoodsType:(NSInteger)goodsType
{
    NSDictionary *goodsTypes = @{
                                @(3):@"大件货物",
                                @(12):@"木材",
                                @(21):@"工艺礼品",
                                @(4):@"鲜活易腐",
                                @(30):@"日用百货",
                                @(13):@"食品",
                                @(5):@"危险货物",
                                @(22):@"陶瓷",
                                @(6):@"贵重货物",
                                @(31):@"化工产品",
                                @(14):@"果蔬",
                                @(7):@"保温冷藏",
                                @(23):@"危险品",
                                @(32):@"配件",
                                @(15):@"农牧",
                                @(8):@"搬家货物",
                                @(24):@"煤炭",
                                @(9):@"设备",
                                @(33):@"纸类",
                                @(16):@"服装鞋品",
                                @(25):@"钢材",
                                @(34):@"文体用品",
                                @(17):@"药品",
                                @(26):@"五金建材",
                                @(35):@"贵重物品",
                                @(18):@"电子电器",
                                @(27):@"粮油",
                                @(36):@"医疗器械",
                                @(19):@"汽车摩托",
                                @(28):@"饮品",
                                @(37):@"家居用品",
                                @(29):@"农贸",
                                @(38):@"工业材料",
                                @(10):@"矿产",
                                @(1):@"不限",
                                @(11):@"饲料",
                                @(2):@"普通货物",
                                @(20):@"图书音像"
                                };
    return [goodsTypes objectForKey:@(goodsType)];
}
/**
 *  仓库类型
 */
+ (NSString *)stringWithWarehouseType:(NSInteger)WarehouseType
{
    NSDictionary *cangkuType = @{
                                 @(3):@"冷藏仓库",
                                 @(12):@"批发仓库",
                                 @(21):@"流通仓库",
                                 @(4):@"恒温仓库",
                                 @(30):@"钢筋混凝土仓库",
                                 @(13):@"零售仓库",
                                 @(5):@"液体仓库",
                                 @(22):@"平房仓库",
                                 @(6):@"堆场仓库",
                                 @(31):@"钢质仓库",
                                 @(14):@"储备仓库",
                                 @(7):@"保税仓库",
                                 @(23):@"多层仓库",
                                 @(40):@"多层厂房",
                                 @(32):@"砖石仓库",
                                 @(15):@"中转仓库",
                                 @(8):@"危险品仓储",
                                 @(24):@"散装仓库",
                                 @(9):@"出口监管储存",
                                 @(33):@"彩钢仓库",
                                 @(16):@"生产仓库",
                                 @(41):@"独栋厂房",
                                 @(25):@"罐式仓库",
                                 @(42):@"机械加工制造类",
                                 @(34):@"标准厂房",
                                 @(17):@"储藏仓库",
                                 @(43):@"轻纺制造加工类",
                                 @(26):@"简易仓库",
                                 @(35):@"排架厂房",
                                 @(18):@"集配型仓库",
                                 @(44):@"食品化工类",
                                 @(27):@"港口仓库",
                                 @(36):@"框架厂房",
                                 @(19):@"中转分货型仓库",
                                 @(45):@"静电厂房",
                                 @(28):@"内陆仓库",
                                 @(37):@"砖混厂房",
                                 @(46):@"防尘厂房",
                                 @(29):@"枢纽站仓库",
                                 @(38):@"钢构厂房",
                                 @(47):@"高配电厂房",
                                 @(39):@"单层厂房",
                                 @(48):@"科研厂房",
                                 @(49):@"特种厂房",
                                 @(10):@"综合仓储",
                                 @(1):@"普通仓库",
                                 @(11):@"采购供应仓库",
                                 @(2):@"立体仓库",
                                 @(20):@"加工型仓库"
                                 };
    return [cangkuType objectForKey:@(WarehouseType)];
    
}
/**
 *  期望运价
 */
+ (NSString *)stringWithUnitType:(NSInteger)unitType
{
    NSDictionary *jiliangListType = @{
                                      @(10):@"元/立方米/天",
                                      @(2):@"元/公斤",
                                      @(15):@"元/个",
                                      @(3):@"元/立方米",
                                      @(11):@"元/件",
                                      @(4):@"元/车",
                                      @(16):@"元/公里",
                                      @(5):@"元/GP",
                                      @(12):@"元/件",
                                      @(6):@"元/20GP",
                                      @(13):@"元/台",
                                      @(7):@"元/40GP",
                                      @(8):@"元/立方米/年",
                                      @(14):@"元/辆",
                                      @(1):@"元/吨",
                                      @(9):@"元/立方米/月"
                                      };
    return [jiliangListType objectForKey:@(unitType)];
}

+ (UIImage *)homeImageWithType:(NSInteger)type
{
    NSDictionary *imageType = @{
                                @(8):@"icon_zhaohuoyuan",//货源
                                @(9):@"icon_zhaocheyuan",//车源
                                @(3):@"icon_zhaocangku",//库源
                                @(6):@"icon_zhaoyuanqu",//园区
                                @(10):@"icon_zhaozhuanxian",//专线
                                @(2):@"icon_zhaopeihuozhan",//配货站点
                                @(11):@"icon_peisong",//配送中心
                                @(4):@"icon_zhaokuaidi",//快递网点
                                @(25):@"icon_zhaomoduan"//末端网点
                                };
    return [UIImage imageNamed:[imageType objectForKey:@(type)]];
}
+ (NSString *)homeClassWithType:(NSInteger)type
{
    NSDictionary *imageType = @{
                                @(8):@"TSLGoodsSourceDetailVC",//货源
                                @(9):@"TSLVehicleSourceDetailVC",//车源
                                @(3):@"TSLWarehouseDetailVC",//库源
                                @(6):@"TSLParkDetailVC",//园区
                                @(10):@"TSLRailwayDetailVC",//专线
                                @(2):@"TSLDistributionStationDetailVC",//配货站点
                                @(11):@"TSLDistributionCenterDetailVC",//配送中心
                                @(4):@"TSLExpressStationDetailVC",//快递网点
                                @(25):@"TSLWlTerminalDetailVC"//末端网点
                                };
    return [imageType objectForKey:@(type)];
}

+ (NSString *)stringWithParkType:(NSInteger)type
{
    NSDictionary *parkType = @{
                               @(1):@"储配送型物流园区",
                               @(2):@"流通加工型物流园区",
                               @(3):@"转运型物流园区",
                               @(4):@"综合型物流园区"
                               };
    return [parkType objectForKey:@(type)];
}

+ (NSString *)stringWithRailwayType:(NSInteger)type
{
    NSDictionary *railwayType = @{
                                  @(1):@"陆运",
                                  @(2):@"海运",
                                  @(3):@"铁运"
                                  };
    return [railwayType objectForKey:@(type)];
}

+ (NSString *)stringWithDistributionCenterType:(NSInteger)type
{
    NSDictionary *distributionCenterType = @{
                                             @(10):@"清洁用品",
                                             @(2):@"服饰鞋包",
                                             @(15):@"耐火材料",
                                             @(3):@"家电/数码",
                                             @(11):@"劳保五金",
                                             @(4):@"家居用品",
                                             @(16):@"其他",
                                             @(5):@"图书/音像制品",
                                             @(12):@"家禽牲畜",
                                             @(6):@"花卉植物",
                                             @(13):@"瓜果蔬菜",
                                             @(7):@"医药药品",
                                             @(8):@"汽车车辆",
                                             @(14):@"家具建材",
                                             @(1):@"食品酒水",
                                             @(9):@"钢铁机械"
                                             };
    return [distributionCenterType objectForKey:@(type)];
}

+ (NSString *)stringWithExpressStationType:(NSInteger)type
{
    NSDictionary *expressStationType = @{
                                         @(1):@"国内快递",
                                         @(2):@"国际快递",
                                         @(3):@"同城快递"
                                         };
    return [expressStationType objectForKey:@(type)];
}

+ (NSString *)stringWithESCompanyType:(NSInteger)type
{
    NSDictionary *ESCompanyType = @{
                                    @(18):@"邦德物流",
                                    @(20):@"快捷快递",
                                    @(19):@"EMS快递",
                                    @(11):@"汇强快递",
                                    @(12):@"国通快递",
                                    @(1):@"圆通快递",
                                    @(20):@"飞马快递",
                                    @(2):@"中通快递",
                                    @(13):@"天天快递",
                                    @(3):@"顺丰快递",
                                    @(21):@"其他快递",
                                    @(14):@"源伟丰快递",
                                    @(4):@"不限",
                                    @(5):@"申通快递",
                                    @(15):@"FedEx联邦中国",
                                    @(6):@"汇通快递",
                                    @(16):@"佳吉快递",
                                    @(7):@"韵达快递",
                                    @(8):@"优速快递",
                                    @(17):@"能达速递",
                                    @(9):@"全峰快递"
                                    };
    return [ESCompanyType objectForKey:@(type)];
}

+ (NSString *)stringWithWlTerminalType:(NSInteger)type
{
    NSDictionary *WlTerminalType = @{
                                    @(25):@"电脑/数码维修店",
                                    @(18):@"书店/报刊亭",
                                    @(10):@"烟酒零售店",
                                    @(19):@"开锁公司",
                                    @(11):@"小商品批发部",
                                    @(12):@"皮具护理/擦鞋吧",
                                    @(1):@"便利店",
                                    @(20):@"旅行社",
                                    @(2):@"超市",
                                    @(13):@"宠物用品店",
                                    @(3):@"礼品/饰品店",
                                    @(21):@"照相馆",
                                    @(14):@"宠物诊所",
                                    @(4):@"干洗店",
                                    @(5):@"水果店",
                                    @(15):@"鲜花店",
                                    @(22):@"美容美发店",
                                    @(6):@"蛋糕店",
                                    @(23):@"美甲店",
                                    @(16):@"打印/复印店",
                                    @(7):@"小吃店",
                                    @(8):@"婚庆/节日用品店",
                                    @(24):@"福利/体育彩票零售店",
                                    @(17):@"药店/诊所",
                                    @(9):@"体育/文化用品店",
                                    };
    return [WlTerminalType objectForKey:@(type)];
}
@end
