//
//  TSLInformationTableViewCell.h
//  TSLogistics
//
//  Created by erpapa on 15/11/26.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSLInformationInfo.h"
#define InformationTableViewCellHeight 98
@interface TSLInformationTableViewCell : UITableViewCell
@property (strong, nonatomic) TSLInformationInfo *info;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
