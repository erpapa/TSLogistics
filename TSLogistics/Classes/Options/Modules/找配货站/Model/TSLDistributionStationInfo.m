//
//  TSLDistributionStationInfo.m
//  TSLogistics
//
//  Created by erpapa on 15/12/15.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLDistributionStationInfo.h"

@implementation TSLDistributionStationInfo

/**
 *  信息生成的日期
 *
 */
- (void)setCreateDate:(NSString *)CreateDate
{
    if (CreateDate.length) {
        _CreateDate = [CreateDate componentsSeparatedByString:@"T"][0];
    } else {
        _CreateDate = @"";
    }
}

- (NSString *)PersonTelString
{
    return _MobilePhone.length?_MobilePhone:_Telephone;
}
@end
