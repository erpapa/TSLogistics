//
//  TSLBaseTableViewCell.h
//  TSLogistics
//
//  Created by erpapa on 15/12/15.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kBorder 10 // border
#define kRowHeight 30 // 行高
#define kLineWidth (ScreenW - 2 * kBorder) // 线宽

@interface TSLBaseTableViewCell : UITableViewCell

@property (strong, nonatomic) id info;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
