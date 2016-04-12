//
//  TSLRecommendInfo.h
//  TSLogistics
//
//  Created by erpapa on 15/11/12.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSLRecommendInfo : NSObject
/**
 *  标识
 */
@property (assign, nonatomic) NSInteger Identifier;
/**
 *  消息标题
 */
@property (copy, nonatomic) NSString *NameCHN;
/**
 *  消息来源
 */
@property (copy, nonatomic) NSString *SourceName;
/**
 *  消息发布时间
 */
@property (copy, nonatomic) NSString *ReleaseTime;
/**
 *  图片
 */
@property (copy, nonatomic) NSString *RecommendPic;

/**
 *  Content 内容
 */
@property (copy, nonatomic) NSString *Content;
@end
