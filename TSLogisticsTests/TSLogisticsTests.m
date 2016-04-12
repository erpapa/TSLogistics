//
//  TSLogisticsTests.m
//  TSLogisticsTests
//
//  Created by erpapa on 15/11/9.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Ono.h"

@interface TSLogisticsTests : XCTestCase

@end

@implementation TSLogisticsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testXML
{
    NSError *error = nil;
    NSString *XMLFilePath = [[NSBundle mainBundle] pathForResource:@"nutrition" ofType:@"xml"];;
    ONOXMLDocument *document = [ONOXMLDocument XMLDocumentWithData:[NSData dataWithContentsOfFile:XMLFilePath] error:&error];
    if (error) {
        NSLog(@"[Error] %@", error);
        return;
    }
    
    /**
     *  1.Root Element(根节点)
     */
    NSLog(@"Root Element: %@", document.rootElement.tag);
    NSLog(@"\n");
    /**
     *  2.firstChildWithTag (第一个节点)
     */
    NSLog(@"Daily Values:");
    for (ONOXMLElement *dailyValueElement in [[document.rootElement firstChildWithTag:@"daily-values"] children]) {
        /**
         *  2.1标签
         */
        NSString *nutrient = dailyValueElement.tag;
        /**
         *  2.2值
         */
        NSNumber *amount = [dailyValueElement numberValue];
        /**
         *  2.3获取units的值
         */
        NSString *unit = dailyValueElement[@"units"];
        NSLog(@"- %@%@ %@ ", amount, unit, nutrient);
    }
    NSLog(@"\n");
    /**
     *  3.查找指定节点food下的所有name标签
     */
    NSString *XPath = @"//food/name";
    NSLog(@"XPath Search: %@", XPath);
    [document enumerateElementsWithXPath:XPath usingBlock:^(ONOXMLElement *element, __unused NSUInteger idx, __unused BOOL *stop) {
        NSLog(@"%@", element);
    }];
    NSLog(@"\n");
    /**
     *  4.枚举foot节点下所有包含有units的serving标签
     */
    NSString *CSS = @"food > serving[units]";
    NSLog(@"CSS Search: %@", CSS);
    [document enumerateElementsWithCSS:CSS usingBlock:^(ONOXMLElement *element, __unused NSUInteger idx, __unused BOOL *stop) {
        NSLog(@"%@", element);
    }];
    NSLog(@"\n");
    /**
     *  5.枚举foot节点下的name标签，打印第1个,(*stop == YES)
     */
    XPath = @"//food/name";
    NSLog(@"XPath Search: %@", XPath);
    __block ONOXMLElement *blockElement = nil;
    [document enumerateElementsWithXPath:XPath usingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *stop) {
        *stop = idx == 1;
        if (*stop) {
            blockElement = element;
        }
    }];
    NSLog(@"Second element: %@", blockElement);
    /**
     *  5.获得foot节点下第一个name标签
     */
    NSLog(@"\n");
    XPath = @"//food/name";
    NSLog(@"XPath Search: %@", XPath);
    ONOXMLElement *firstElement = [document firstChildWithXPath:XPath];
    NSLog(@"First element: %@", firstElement);
}

- (void)testPlist
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"typeList" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSLog(@"%@",dict);
}

@end
