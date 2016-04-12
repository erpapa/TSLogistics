//
//  TSLParkCell.m
//  TSLogistics
//
//  Created by erpapa on 15/12/15.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLParkCell.h"
#import "UIView+MJExtension.h"
#define KLabelFontSize 17

@interface TSLParkCell()
@property (strong, nonatomic) UIButton *NameCHN;
@property (strong, nonatomic) UILabel *LPArea;
@property (strong, nonatomic) UILabel *LPAreaRemaind;
@property (strong, nonatomic) UILabel *ExistEnterprisesNum;
@property (strong, nonatomic) UILabel *EnterprisesNum;
@property (strong, nonatomic) UILabel *PersonTel;
@property (strong, nonatomic) UILabel *LPAddress;

@end

@implementation TSLParkCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"WarehouseCell";
    TSLParkCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil){
        cell = [[TSLParkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat nameX = kBorder + 3; // 姓名x
        CGFloat centerX = kLineWidth / 2;
        // 1.起始地址
        self.NameCHN = [[UIButton alloc] initWithFrame:CGRectMake(kBorder, 0, kLineWidth, kRowHeight)];
        [self.NameCHN setImage:[UIImage imageNamed:@"dian"] forState:UIControlStateNormal];
        [self.NameCHN setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.NameCHN.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;// 超出显示省略号
        self.NameCHN.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        self.NameCHN.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.NameCHN.userInteractionEnabled = NO;
        // 2.分割线
        UIView *line0 = [[UIView alloc] initWithFrame:CGRectMake(kBorder, kRowHeight, kLineWidth, 1)];
        line0.backgroundColor = TSLBackgroundColor;
        // 3.占地面积
        UILabel *LPAreaLabel = [self labelWithTitle:@"占地面积:" origin:CGPointMake(nameX,kRowHeight + 1)];
        self.LPArea = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(LPAreaLabel.frame), kRowHeight + 1, centerX + KLabelFontSize - CGRectGetMaxX(LPAreaLabel.frame), kRowHeight)];
        // 3.闲置面积
        UILabel *LPAreaRemaindLabel = [self labelWithTitle:@"闲置面积:" origin:CGPointMake(centerX, kRowHeight + 1)];
        LPAreaRemaindLabel.mj_w = [@"可入驻企业:" sizeWithFont:[UIFont systemFontOfSize:KLabelFontSize]].width;
        self.LPAreaRemaind = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(LPAreaRemaindLabel.frame), kRowHeight + 1, kLineWidth - CGRectGetMaxX(LPAreaRemaindLabel.frame) + KLabelFontSize, kRowHeight)];
        // 4.分割线
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(kBorder, kRowHeight * 2 + 1, kRowHeight, 1)];
        line1.backgroundColor = TSLBackgroundColor;
        // 5.入驻企业
        UILabel *ExistEnterprisesNumLabel = [self labelWithTitle:@"入驻企业:" origin:CGPointMake(nameX,(kRowHeight + 1) * 2)];
        self.ExistEnterprisesNum = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(ExistEnterprisesNumLabel.frame), (kRowHeight + 1) * 2, centerX - CGRectGetMaxX(ExistEnterprisesNumLabel.frame), kRowHeight)];
        // 6.可入驻企业
        UILabel *EnterprisesNumLabel = [self labelWithTitle:@"可入驻企业:" origin:CGPointMake(centerX, (kRowHeight + 1) * 2)];
        self.EnterprisesNum = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(EnterprisesNumLabel.frame), (kRowHeight + 1) * 2, kLineWidth - CGRectGetMaxX(EnterprisesNumLabel.frame), kRowHeight)];
        // 7.分割线
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(kBorder, kRowHeight * 3 + 2, kLineWidth, 1)];
        line2.backgroundColor = TSLBackgroundColor;
        // 8.地址
        UILabel *LPAddressLabel = [self labelWithTitle:@"地址:" origin:CGPointMake(nameX, (kRowHeight + 1) * 3)];
        self.LPAddress = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(LPAddressLabel.frame), (kRowHeight + 1) * 3, kLineWidth - CGRectGetMaxX(LPAddressLabel.frame), kRowHeight)];
        
        [self.contentView addSubview:self.NameCHN];
        [self.contentView addSubview:line0];
        [self.contentView addSubview:LPAreaLabel];
        [self.contentView addSubview:self.LPArea];
        [self.contentView addSubview:LPAreaRemaindLabel];
        [self.contentView addSubview:self.LPAreaRemaind];
        [self.contentView addSubview:line1];
        [self.contentView addSubview:ExistEnterprisesNumLabel];
        [self.contentView addSubview:self.ExistEnterprisesNum];
        [self.contentView addSubview:EnterprisesNumLabel];
        [self.contentView addSubview:self.EnterprisesNum];
        [self.contentView addSubview:line2];
        [self.contentView addSubview:LPAddressLabel];
        [self.contentView addSubview:self.LPAddress];
        
    }
    return self;
}

- (void)setInfo:(TSLParkInfo *)info
{
    [super setInfo:info];
    [self.NameCHN setTitle:info.NameCHN forState:UIControlStateNormal];
    self.LPArea.text = [NSString stringWithFormat:@"%g亩", info.LPArea];
    self.LPAreaRemaind.text = [NSString stringWithFormat:@"%g亩", info.LPAreaRemaind];
    self.ExistEnterprisesNum.text = [NSString stringWithFormat:@"%ld家", info.ExistEnterprisesNum];
    self.EnterprisesNum.text = [NSString stringWithFormat:@"%ld家", info.EnterprisesNum];
    self.LPAddress.text = info.LPAddress;
}

- (UILabel *)labelWithTitle:(NSString *)title origin:(CGPoint)origin
{
    CGFloat labelWidth = [title sizeWithFont:[UIFont systemFontOfSize:17]].width;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(origin.x, origin.y, labelWidth, kRowHeight)];
    label.text = title;
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentRight;
    return label;
}

@end
