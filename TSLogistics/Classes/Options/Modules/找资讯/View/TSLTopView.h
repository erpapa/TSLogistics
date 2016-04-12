//
//  TSLTopView.h
//  TSLogistics
//
//  Created by erpapa on 15/11/27.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TSLTopView;
@protocol TSLTopViewDelegate <NSObject>
@optional
- (void)topView:(TSLTopView *)topView scrollToPage:(NSInteger)page animated:(BOOL)animated;
@end

@interface TSLTopView : UIView
@property (strong, nonatomic) NSArray *titleArray;
@property (assign, nonatomic) CGFloat titleWidth;
@property (strong, nonatomic) UIColor *foregroundColor;
@property (assign, nonatomic) NSInteger page;
@property (nonatomic, assign) id <TSLTopViewDelegate> delegate;

@end