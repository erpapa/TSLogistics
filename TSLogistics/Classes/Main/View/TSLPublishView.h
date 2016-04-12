//
//  TSLPublishView.h
//  TSLogistics
//
//  Created by erpapa on 15/11/9.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSLPublishView : UIView
@property (copy, nonatomic) NSString *title;
/** 说话按钮距离底部的距离*/
@property (assign, nonatomic) CGFloat bottom;
/** 不透明度，默认为0.1f */
@property (assign, nonatomic) float opacity;
@end
