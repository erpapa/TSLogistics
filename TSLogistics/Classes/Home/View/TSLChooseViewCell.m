//
//  TSLChooseViewCell.m
//  TSLogistics
//
//  Created by erpapa on 15/12/15.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLChooseViewCell.h"

@interface TSLChooseViewCell()
@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *titleLable;
@property (strong, nonatomic) UIView *line;

@end

@implementation TSLChooseViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"TSLChooseViewCell";
    TSLChooseViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil){
        cell = [[TSLChooseViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.line = [[UIView alloc] init];
        self.line.backgroundColor = TSLBackgroundColor;
        [self.contentView addSubview:self.line];
        self.iconView = [[UIImageView alloc] init];
        self.iconView.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:self.iconView];
        self.titleLable = [[UILabel alloc] init];
        self.titleLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLable];
        
    }
    return self;
}

- (void)setIcon:(NSString *)icon
{
    _icon = [icon copy];
    self.iconView.image = [UIImage imageNamed:icon];
}

- (void)setText:(NSString *)text
{
    _text = [text copy];
    self.titleLable.text = text;
}

- (void)layoutSubviews
{
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    if (self.isShowLine) {
        self.line.frame = CGRectMake(2, 0, width - 4, 2);
    }
    self.iconView.frame = CGRectMake(0, CGRectGetMaxY(self.line.frame), 32, height);
    self.titleLable.frame = CGRectMake(CGRectGetMaxX(self.iconView.frame), CGRectGetMaxY(self.line.frame), width - height, height);
}
@end
