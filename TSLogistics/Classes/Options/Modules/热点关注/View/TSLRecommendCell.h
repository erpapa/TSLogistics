//
//  TSLOptionViewCell.h
//  TSLogistics
//
//  Created by erpapa on 15/11/11.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSLRecommendInfo.h"
#define RecommendCellHeight 70
@interface TSLRecommendCell : UITableViewCell
@property (strong, nonatomic) TSLRecommendInfo *info;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
