//
//  TSLPointAnnotation.h
//  TSLogistics
//
//  Created by erpapa on 15/11/28.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKPointAnnotation.h>

@interface TSLPointAnnotation : BMKPointAnnotation
@property (assign, nonatomic) NSInteger Identifier;
@property (assign, nonatomic) NSInteger User_Id;
@property (copy, nonatomic) NSString *MType;
@property (assign, nonatomic) NSInteger type;
@property (assign, nonatomic) CGFloat degree;
@end
