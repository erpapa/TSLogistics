//
//  TSLCollectInfo.m
//  TSLogistics
//
//  Created by erpapa on 15/12/8.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLCollectInfo.h"

@implementation TSLCollectInfo
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
- (void)setMobilePhone:(NSString *)MobilePhone
{
    if (MobilePhone.length) {
        _MobilePhone = [[MobilePhone componentsSeparatedByString:@","] lastObject];
    } else {
        _MobilePhone = @"";
    }
}
@end
