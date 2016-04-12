//
//  TSLWarehouseParam.h
//  TSLogistics
//
//  Created by erpapa on 15/11/23.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSLWarehouseParam : NSObject
/** 返回的数据中iscollected = "1"表示已收藏 */
@property (assign, nonatomic) NSInteger collectid;
/** 消息标识 */
@property (assign, nonatomic) NSInteger identifier;
@property (assign, nonatomic) NSInteger userId;
@end
