//
//  TSLOptionViewCell.m
//  TSLogistics
//
//  Created by erpapa on 15/11/11.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLRecommendCell.h"
#import "UIImageView+WebCache.h"

@interface TSLRecommendCell()
@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UILabel *msgLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UIImageView *timeView;
@end

@implementation TSLRecommendCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    // static修饰局部变量:可以保证局部变量只分配一次存储空间(只初始化一次)
    static NSString *ID = @"Cell";
    // 1.通过一个标识去缓存池中寻找可循环利用的cell
    // dequeue : 出列 (查找)
    TSLRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 2.如果没有可循环利用的cell
    if (cell == nil){
        cell = [[TSLRecommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imgView = [[UIImageView alloc] init];
        self.msgLabel = [[UILabel alloc] init];
        self.msgLabel.font = [UIFont systemFontOfSize:14];
        self.msgLabel.numberOfLines = 2;// 允许换行
        self.timeView = [[UIImageView alloc] init];
        self.timeView.image = [UIImage imageNamed:@"hotTime"];
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        self.timeLabel.font = [UIFont systemFontOfSize:15];
        self.timeLabel.textColor = [UIColor grayColor];
        
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.msgLabel];
        [self.contentView addSubview:self.timeView];
        [self.contentView addSubview:self.timeLabel];
        
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = TSLBackgroundColor;
        self.selectedBackgroundView = bgView;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imgView.frame = CGRectMake(8, 5, 60, 60);
    self.msgLabel.frame = CGRectMake(76, 10, ScreenW - 82, 34);
    self.timeLabel.frame = CGRectMake(ScreenW - 96, 45, 88, 20);
    self.timeView.frame = CGRectMake(ScreenW - 96 - 20, 45, 20, 20);
}


- (void)setInfo:(TSLRecommendInfo *)info
{
    _info = info;
    NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TSLAPI_IMAGES, info.RecommendPic]];
    [self.imgView sd_setImageWithURL:imageURL];
    self.msgLabel.text = info.NameCHN;
    self.timeLabel.text = info.ReleaseTime;
    self.timeView.hidden = !self.timeLabel.text;
}

@end
