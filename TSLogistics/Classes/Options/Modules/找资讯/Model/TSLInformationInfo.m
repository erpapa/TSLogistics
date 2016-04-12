//
//  TSLInformationInfo.m
//  TSLogistics
//
//  Created by erpapa on 15/11/26.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLInformationInfo.h"
#import "Ono.h"

@implementation TSLInformationInfo

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
 *  内容
 */
- (NSString *)ContentString
{
    ONOXMLDocument *document = [ONOXMLDocument HTMLDocumentWithString:_Content encoding:NSUTF8StringEncoding error:NULL];
    ONOXMLElement *element = [document.rootElement firstChildWithTag:@"body"];
    NSString *string = [element stringValue];
    NSString *str = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    if (str.length > 100) str = [str substringToIndex:100];
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return str;
}

@end
