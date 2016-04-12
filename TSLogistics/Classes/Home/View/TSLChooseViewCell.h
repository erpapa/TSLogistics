//
//  TSLChooseViewCell.h
//  TSLogistics
//
//  Created by erpapa on 15/12/15.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSLChooseViewCell : UITableViewCell
@property (strong, nonatomic) NSString *icon;
@property (strong, nonatomic) NSString *text;
@property (assign, nonatomic, getter=isShowLine) BOOL showLine;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
