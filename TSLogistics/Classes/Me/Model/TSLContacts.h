//
//  TSLContacts.h
//  TSLogistics
//
//  Created by erpapa on 15/12/8.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSLCollectInfo.h"

@interface TSLContacts : NSObject
@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) NSMutableArray *infoArray;
@end
