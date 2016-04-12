//
//  TSLGoodsSourceParam.h
//  TSLogistics
//
//  Created by erpapa on 15/11/17.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSLGoodsSourceParam : NSObject
/** 返回的数据中iscollected = "1"表示已收藏 */
@property (assign, nonatomic) NSInteger collectid;
/** 消息标识 */
@property (assign, nonatomic) NSInteger identifier;
@property (assign, nonatomic) NSInteger userId;
@property (assign, nonatomic) NSInteger gtype;
@property (assign, nonatomic) NSInteger vtype;
@property (assign, nonatomic) NSInteger page;
@property (assign, nonatomic) NSInteger num1;
@property (assign, nonatomic) NSInteger num2;
@property (assign, nonatomic) NSInteger num11;
@property (assign, nonatomic) NSInteger num12;
@end
