//
//  TSLOptionButton.h
//  TSLogistics
//
//  Created by erpapa on 15/11/11.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSLOptionButton : UIButton
+ (instancetype)buttonWithTitle:(NSString *)title image:(NSString *)image addTarget:(id)target action:(SEL)action;
@end
