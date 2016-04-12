//
//  TSLParkInfo.m
//  TSLogistics
//
//  Created by erpapa on 15/12/15.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLParkInfo.h"
#import "TSLTool.h"
#import "Ono.h"

@implementation TSLParkInfo
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

- (NSString *)LPTypeString
{
    return [TSLTool stringWithParkType:_LPType];
}

- (NSString *)Description
{
    ONOXMLDocument *document = [ONOXMLDocument HTMLDocumentWithString:_Description encoding:NSUTF8StringEncoding error:NULL];
    ONOXMLElement *element = [document.rootElement firstChildWithTag:@"body"];
    NSString *string = [element stringValue];
    return string;
}

- (void)setFSrange:(NSString *)FSrange
{
    NSDictionary *dict = @{
                           @"1":@"区域物流园区",
                           @"2":@"城市物流园区",
                           @"3":@"国际物流园区"
                           };
    _FSrange = [dict objectForKey:FSrange];
}

- (void)setXingban:(NSString *)xingban
{
    NSDictionary *dict = @{
                           @"1":@"企业自办专业型",
                           @"2":@"市场自发形成",
                           @"3":@"政府规划",
                           @"4":@"企业运作型",
                           @"5":@"政府引导型"
                           };
    _xingban = [dict objectForKey:xingban];
    
}
@end
