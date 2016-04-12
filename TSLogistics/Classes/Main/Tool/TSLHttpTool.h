//
//  TSLHttpTool.h
//  TSLogistics
//
//  Created by erpapa on 15/11/12.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSLHttpTool : NSObject
/**
 *  GET请求
 *
 *  @param URLString  请求地址
 *  @param parameters 参数
 *  @param success    成功
 *  @param failure    失败
 */
+ (void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
/**
 *  POST请求
 *
 *  @param URLString  请求地址
 *  @param parameters 参数
 *  @param success    成功
 *  @param failure    失败
 */
+ (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
/**
 *  POST 带二进制数据
 *
 *  @param URLString  请求地址
 *  @param parameters 参数
 *  @param success    成功
 *  @param failure    失败
 */
+ (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters formDataArray:(NSArray *)formDataArray success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
@end
