//
//  TSLMapInfo.h
//  TSLogistics
//
//  Created by erpapa on 15/11/28.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSLMapInfo : NSObject

@property (assign, nonatomic) NSInteger Identifier;
@property (assign, nonatomic) NSInteger User_Id;
@property (copy, nonatomic) NSString *MName;
@property (copy, nonatomic) NSString *MType;
@property (copy, nonatomic) NSString *MAddress;
@property (copy, nonatomic) NSString *MMapx;
@property (copy, nonatomic) NSString *MMapy;

@end
