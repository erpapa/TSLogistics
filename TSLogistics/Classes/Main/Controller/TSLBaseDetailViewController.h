//
//  TSLBaseDetailViewController.h
//  TSLogistics
//
//  Created by erpapa on 15/11/29.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "TSLUtil.h"
#import "TSLCollectView.h"
#define kBorderX 5 // 左侧间距5
#define kBorderHeight 12 // 间距12
#define kHeight 36   // 高36

@interface TSLBaseDetailViewController : UIViewController<TSLTelphoneViewDelegate>
/** 指示器 */
@property (strong, nonatomic) UIActivityIndicatorView *activityView;
/** 信息id */
@property (assign, nonatomic) NSInteger Identifier;
/** 模型数据 */
@property (strong, nonatomic) id info;
/** 目的地坐标 */
@property (assign, nonatomic) CLLocationCoordinate2D DestinationCoordinate;
/**
 *  返回一个button
 */
- (UIButton *)buttonWithTitle:(NSString *)title image:(NSString *)image;
/**
 *  返回label
 */
- (UILabel *)labelWithTitle:(NSString *)title origin:(CGPoint)origin;
/**
 *  返回一根下划线
 */
- (UIView *)lineWithOrigin:(CGPoint)origin;
@end
