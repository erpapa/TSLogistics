//
//  TSLChooseView.h
//  TSLogistics
//
//  Created by erpapa on 15/11/29.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <UIKit/UIKit.h>
#define TSLChooseViewCellHeight 35

@class TSLChooseView;
@protocol TSLChooseViewDelegate <NSObject>
@optional
- (void)chooseView:(TSLChooseView *)chooseView didSelectedRowWithType:(NSInteger)type;
@end

@interface TSLChooseView : UIView
@property (assign, nonatomic) id <TSLChooseViewDelegate> delegate;
@end
