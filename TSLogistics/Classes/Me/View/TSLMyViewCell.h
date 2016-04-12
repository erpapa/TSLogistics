//
//  TSLMeViewCell.h
//  TSLogistics
//
//  Created by erpapa on 15/11/11.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSLMyViewCell : UITableViewCell
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *image;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
