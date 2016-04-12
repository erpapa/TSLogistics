//
//  TSLRailwayInfo.m
//  TSLogistics
//
//  Created by erpapa on 15/12/15.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLRailwayInfo.h"
#import "TSLTool.h"

@implementation TSLRailwayInfo
/**
 *  信息生成的日期
 *
 */
- (void)setReleaseTime:(NSString *)ReleaseTime
{
    if (ReleaseTime.length) {
        _ReleaseTime = [ReleaseTime componentsSeparatedByString:@"T"][0];
    } else {
        _ReleaseTime = @"";
    }
}

- (NSString *)PersonString
{
    return _Person.length?_Person:_CustomPerson;
}

- (NSString *)PersonTelString
{
    return _PersonTel.length?_PersonTel:_CustomPersonTel;
}
/**
 *  专线类型
 */
- (NSString *)DSTypeString
{
    return [TSLTool stringWithRailwayType:_DSType];
}
/**
 *  货物类型
 */
- (NSString *)TransGoodsTypeString
{
    switch (_TransGoodsType) {
        case 1:
            return @"重货";
        case 2:
            return @"泡货";
        default:
            return @"";
    }
}
/**
 *  运输类型
 */
- (NSString *)PriceTypeString
{
    switch (_PriceType) {
        case 1:
            return @"整车";
        case 2:
            return @"零担";
        default:
            return @"";
    }
}
/**
 *  运输价格
 */
- (NSString *)PriceString
{
    if (_Price) {
        return [NSString stringWithFormat:@"%g%@", _Price, [TSLTool stringWithUnitType:_PriceUnit] ];
    }
    return @"电议";
}

/**
 *  车辆类型
 */
- (NSString *)VehicleTypeString
{
    return [TSLTool stringWithVehicleType:_VehicleType];
}

@end
