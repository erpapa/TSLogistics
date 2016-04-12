//
//  TSLPutAudioView.h
//  TSLogistics
//
//  Created by erpapa on 15/11/16.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSLPutAudioView : UIViewController
@property (copy, nonatomic) NSString *filePath;
@property (assign, nonatomic) BOOL editTelphone;
- (void)show;
@end
