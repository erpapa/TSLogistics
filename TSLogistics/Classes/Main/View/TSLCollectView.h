//
//  TSLTelphoneView.h
//  TSLogistics
//
//  Created by erpapa on 15/12/1.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSLCollectionParam.h"

@class TSLCollectView, TSLTelphoneView;
@protocol TSLTelphoneViewDelegate <NSObject>
@optional
/**
 *  收藏成功/失败
 */
- (void)collectView:(TSLCollectView *)collectView didCollected:(BOOL)success;
/**
 *  添加通讯录成功/失败
 */
- (void)telphoneView:(TSLTelphoneView *)telphoneView didCollected:(BOOL)success;
/**
 *  请求参数
 */
- (TSLCollectionParam *)collectionParam;
@end


@interface TSLTelphoneView : UIView
@property (copy, nonatomic) NSString *telString;
@property (assign, nonatomic) id <TSLTelphoneViewDelegate> delegate;
@end

@interface TSLCollectView : UIView
@property (assign, nonatomic, getter=isCollected) BOOL collected;
@property (assign, nonatomic) id <TSLTelphoneViewDelegate> delegate;
@end
