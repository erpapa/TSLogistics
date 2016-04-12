//
//  TSLCollectionParam.h
//  TSLogistics
//
//  Created by erpapa on 15/12/1.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSLCollectionParam : NSObject
@property (assign, nonatomic) NSInteger LogisticsId;
@property (assign, nonatomic) NSInteger userId;
@property (assign, nonatomic) NSInteger LogisticsType;
@property (assign, nonatomic) NSInteger TheState;
/** 1:添加到通讯录 2:添加到收藏夹 */
@property (assign, nonatomic) NSInteger savetype;
@end
