//
//  TSLWarehouseInfo.m
//  TSLogistics
//
//  Created by erpapa on 15/11/20.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLWarehouseInfo.h"

@implementation TSLWarehouseInfo
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

/**
 *  电话号码
 */
- (void)setPersonTel:(NSString *)PersonTel
{
    _PersonTel = [PersonTel componentsSeparatedByString:@"/"][0];
}
/**
 *  公司名
 */
- (void)setCompanyName:(NSString *)CompanyName
{
    if (CompanyName.length) {
        _CompanyName = [CompanyName copy];
    } else {
        _CompanyName = @"个人仓库";
    }
}

/**
 * 仓库类型
 */
- (NSString *)WHTypeString
{
    return [TSLTool stringWithWarehouseType:_WHType];
}
/**
 * 价格
 */
- (NSString *)PriceString
{
    if (_Price) {
        return [NSString stringWithFormat:@"%g%@", _Price, [TSLTool stringWithUnitType:_UnitType]];
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
