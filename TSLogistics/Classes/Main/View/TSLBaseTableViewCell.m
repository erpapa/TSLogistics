//
//  TSLBaseTableViewCell.m
//  TSLogistics
//
//  Created by erpapa on 15/12/15.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLBaseTableViewCell.h"

@implementation TSLBaseTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"TSLBaseTableViewCell";
    TSLBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil){
        cell = [[TSLBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -=5;
    [super setFrame:frame];
}

@end
