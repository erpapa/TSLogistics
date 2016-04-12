//
//  TSLVehicleSourceInfo.m
//  TSLogistics
//
//  Created by erpapa on 15/11/18.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLVehicleSourceInfo.h"

@implementation TSLVehicleSourceInfo

/**
 *  发车日期
 *
 */
- (void)setBeginTime:(NSString *)BeginTime
{
    if (BeginTime.length) {
        _BeginTime = [BeginTime componentsSeparatedByString:@"T"][0];
    } else {
        _BeginTime = @"";
    }
}
/**
 *  发布日期
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

/**
 *  公司名
 */
- (void)setCompanyName:(NSString *)CompanyName
{
    if (CompanyName.length) {
        _CompanyName = [CompanyName copy];
    } else {
        _CompanyName = @"个人车主";
    }
}
/**
 *  电话号码
 */
- (void)setPersonTel:(NSString *)PersonTel
{
    _PersonTel = [PersonTel componentsSeparatedByString:@"/"][0];
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
 *  车辆类型
 */
- (NSString *)VehicleTypeString
{
    return [TSLTool stringWithVehicleType:_VehicleType];
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

- (NSString *)PersonString
{
    return _Person.length?_Person:_CustomPerson;
}

- (NSString *)PersonTelString
{
    return _PersonTel.length?_PersonTel:_CustomPersonTel;
}

@end
