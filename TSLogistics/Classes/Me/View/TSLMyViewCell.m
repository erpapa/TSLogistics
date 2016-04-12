//
//  TSLMeViewCell.m
//  TSLogistics
//
//  Created by erpapa on 15/11/11.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLMyViewCell.h"

@interface TSLMyViewCell ()
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *bgView;
@end

@implementation TSLMyViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    // static修饰局部变量:可以保证局部变量只分配一次存储空间(只初始化一次)
    static NSString *ID = @"Cell";
    // 1.通过一个标识去缓存池中寻找可循环利用的cell
    // dequeue : 出列 (查找)
    TSLMyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 2.如果没有可循环利用的cell
    if (cell == nil){
        cell = [[TSLMyViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectedBackgroundView = [UIView new];
        self.backgroundColor = [UIColor clearColor];
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
        self.bgView = [[UIImageView alloc] init];
        UIView *view = [[UIView alloc] init];
        [view addSubview:self.bgView];
        self.backgroundView = view;
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 5;
    [super setFrame:frame];
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    self.titleLabel.text = title;
}

- (void)setImage:(NSString *)image
{
    _image = [image copy];
    UIImage *img = [UIImage imageNamed:image];
    self.bgView.image = [img stretchableImageWithLeftCapWidth:100 topCapHeight:47];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(50, 0, 70, self.frame.size.height);
    self.bgView.frame = CGRectMake(-8, 0, ScreenW + 16, self.frame.size.height);
}
@end
