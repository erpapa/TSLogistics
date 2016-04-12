//
//  TSLRecommendInfo.m
//  TSLogistics
//
//  Created by erpapa on 15/11/12.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLRecommendInfo.h"
#import "MJExtension.h"
#import "Ono.h"

@implementation TSLRecommendInfo

- (void)setReleaseTime:(NSString *)ReleaseTime
{
    if (ReleaseTime.length) {
        _ReleaseTime = [ReleaseTime componentsSeparatedByString:@"T"][0];
    } else {
        _ReleaseTime = @"";
    }
}

- (void)setNameCHN:(NSString *)NameCHN
{
    //    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[NameCHN dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    ONOXMLDocument *document = [ONOXMLDocument HTMLDocumentWithString:NameCHN encoding:NSUTF8StringEncoding error:NULL];
    ONOXMLElement *element = [document.rootElement firstChildWithTag:@"body"];
    _NameCHN = [element stringValue];
}

//- (void)setNameCHN:(NSString *)NameCHN
//{
//    NSString *msgString = [NSString string];
//    NSArray *array = [NameCHN componentsSeparatedByString:@"</a>"];
//    for (NSInteger index = 0; index < array.count; index++) {
//        NSString *str = [array objectAtIndex:index];
//        NSRange range = [str rangeOfString:@">" options:NSBackwardsSearch];
//        if (range.location != NSNotFound) {
//            NSString *tempStr = [str substringFromIndex:range.location + 1];
//            msgString = [msgString stringByAppendingString:tempStr];
//        } else {
//            msgString = [msgString stringByAppendingString:str];
//        }
//        if (index == 0 && array.count > 1) {
//            msgString = [msgString stringByAppendingString:@"与"];
//        }
//    }
//    _NameCHN = msgString;
//}

MJCodingImplementation
@end
