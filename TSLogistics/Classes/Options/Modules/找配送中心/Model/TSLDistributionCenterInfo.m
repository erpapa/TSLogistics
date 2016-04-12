//
//  TSLDistributionCenterInfo.m
//  TSLogistics
//
//  Created by erpapa on 15/12/30.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLDistributionCenterInfo.h"
#import "TSLTool.h"

@implementation TSLDistributionCenterInfo

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
 *  公司名
 */
- (void)setCompanyName:(NSString *)CompanyName
{
    if (CompanyName.length) {
        _CompanyName = [CompanyName copy];
    } else {
        _CompanyName = @"个人";
    }
}

/**
 *  类别
 */
- (NSString *)ServerTypeString
{
    return [TSLTool stringWithDistributionCenterType:_ServerType];
}
@end
