//
//  TSLGoodsSourceInfo.m
//  TSLogistics
//
//  Created by erpapa on 15/11/17.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLGoodsSourceInfo.h"

@implementation TSLGoodsSourceInfo
/**
 *  发货日期
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
 *  公司名
 */
- (void)setCompanyName:(NSString *)CompanyName
{
    if (CompanyName.length) {
        _CompanyName = [CompanyName copy];
    } else {
        _CompanyName = @"个人用户";
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
 *  运输类型
 */
- (NSString *)TransferTypeString
{
    switch (_TransferType) {
        case 1:
            return @"整车";
        case 2:
            return @"零担";
        default:
            return @"";
    }
}

/**
 *  物体重量/体积
 */
- (NSString *)goodsWeightOrBulk
{
    if (_GoodsWeight) {
        return [NSString stringWithFormat:@"%gt", _GoodsWeight];
    }
    return [NSString stringWithFormat:@"%gm³",_GoodsBulk];
}

/**
 *  车辆类型
 */
- (NSString *)RequirementVehicleTypeString
{
    return [TSLTool stringWithVehicleType:_RequirementVehicleType];
}
/**
 *  货物类型
 */
- (NSString *)GoodsTypeString
{
    return [TSLTool stringWithGoodsType:_GoodsType];
}

/**
 *  期望运价
 */
- (NSString *)PriceString
{
    if (_Price) {
        return [NSString stringWithFormat:@"%g%@", _Price, [TSLTool stringWithUnitType:_UnitType]];
    }
    return @"电议";
}
/**
 *  车长
 */
- (NSString *)LengthString
{
    NSString *length = @"0米—";
    if (_LengthEnd > 0) {
        length = [NSString stringWithFormat:@"%g米-%g米", _LengthBegin, _LengthEnd];
    } else {
        length = [NSString stringWithFormat:@"%g米—", _LengthBegin];
    }
    return length;
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
