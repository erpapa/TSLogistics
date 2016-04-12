//
//  TSLDict.h
//  TSLogistics
//
//  Created by erpapa on 15/11/21.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSLTool : NSObject
/**
 *  货物类型
 */
+ (NSString *)stringWithGoodsType:(NSInteger)goodsType;
/**
 *  车辆类型
 */
+ (NSString *)stringWithVehicleType:(NSInteger)vehicleType;
/**
 *  仓库类型
 */
+ (NSString *)stringWithWarehouseType:(NSInteger)WarehouseType;
/**
 *  期望运价
 */
+ (NSString *)stringWithUnitType:(NSInteger)unitType;
/**
 *  大头针图像
 */
+ (UIImage *)homeImageWithType:(NSInteger)type;
/**
 *  点击大头针的popView跳转的控制器
 */
+ (NSString *)homeClassWithType:(NSInteger)type;
/**
 *  物流园区类型
 */
+ (NSString *)stringWithParkType:(NSInteger)type;
/**
 *  专线类型
 */
+ (NSString *)stringWithRailwayType:(NSInteger)type;
/**
 *  配送中心类型
 */
+ (NSString *)stringWithDistributionCenterType:(NSInteger)type;
/**
 *  快递类型
 */
+ (NSString *)stringWithExpressStationType:(NSInteger)type;
/**
 *  快递-所属公司
 */
+ (NSString *)stringWithESCompanyType:(NSInteger)type;
/**
 *  末端类型
 */
+ (NSString *)stringWithWlTerminalType:(NSInteger)type;

@end
