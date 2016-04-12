//
//  TSLExpressStationInfo.m
//  TSLogistics
//
//  Created by erpapa on 15/12/31.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLExpressStationInfo.h"
#import "TSLTool.h"

@implementation TSLExpressStationInfo
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

- (NSString *)ESTypeString
{
    return [TSLTool stringWithExpressStationType:_ESType];
}
- (NSString *)ESCompanyString
{
    return [TSLTool stringWithESCompanyType:_ESCompany];
}
@end
