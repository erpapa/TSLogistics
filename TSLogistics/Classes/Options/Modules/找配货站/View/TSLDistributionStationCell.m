//
//  TSLDistributionStationCell.m
//  TSLogistics
//
//  Created by erpapa on 15/12/15.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLDistributionStationCell.h"

@interface TSLDistributionStationCell()
@property (strong, nonatomic) UIButton *NameCHN;
@property (strong, nonatomic) UILabel *WHAddress;
@property (strong, nonatomic) UILabel *Person;
@property (strong, nonatomic) UILabel *PersonTel;
@property (strong, nonatomic) UIButton *callBtn;
@property (strong, nonatomic) UILabel *ReleaseTime;
@property (strong, nonatomic) UIWebView *webView;

@end

@implementation TSLDistributionStationCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"TSLDistributionStationCell";
    TSLDistributionStationCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil){
        cell = [[TSLDistributionStationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat nameX = kBorder + 3; // 姓名x
        CGFloat timeWidth = 65; // 日期w
        CGFloat timeX = ScreenW - timeWidth - kBorder; // 日期x
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
        // 3.公司地址
        self.WHAddress = [[UILabel alloc] initWithFrame:CGRectMake(nameX, kRowHeight + 1, kLineWidth, kRowHeight)];
        self.WHAddress.textColor = [UIColor orangeColor];
        // 4.分割线
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(kBorder, kRowHeight * 2 + 1, kLineWidth, 1)];
        line1.backgroundColor = TSLBackgroundColor;
        // 5.姓名
        self.Person = [[UILabel alloc] initWithFrame:CGRectMake(nameX, (kRowHeight + 1) * 2, kLineWidth * 0.3, kRowHeight)];
        // 6.电话号码
        self.PersonTel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.Person.frame), (kRowHeight + 1) * 2, kLineWidth * 0.5, kRowHeight)];
        // 7.拨打按钮
        self.callBtn = [[UIButton alloc] initWithFrame:CGRectMake(timeX, (kRowHeight + 1) * 2 + 5, 40, 20)];
        [self.callBtn setImage:[UIImage imageNamed:@"拨打图标"] forState:UIControlStateNormal];
        [self.callBtn addTarget:self action:@selector(callBtnClik) forControlEvents:UIControlEventTouchUpInside];
        // 8.分割线
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(kBorder, kRowHeight * 3 + 2, kLineWidth, 1)];
        line2.backgroundColor = TSLBackgroundColor;
        // 9.时间
        self.ReleaseTime = [[UILabel alloc] initWithFrame:CGRectMake(timeX, (kRowHeight + 1) * 3, timeWidth, kRowHeight)];
        self.ReleaseTime.font = [UIFont systemFontOfSize:12];
        // 10.添加子控件
        [self.contentView addSubview:self.NameCHN];
        [self.contentView addSubview:line0];
        [self.contentView addSubview:self.WHAddress];
        [self.contentView addSubview:line1];
        [self.contentView addSubview:self.Person];
        [self.contentView addSubview:self.PersonTel];
        [self.contentView addSubview:self.callBtn];
        [self.contentView addSubview:line2];
        [self.contentView addSubview:self.ReleaseTime];
    }
    return self;
}

- (void)setInfo:(TSLDistributionStationInfo *)info
{
    [super setInfo:info];
    [self.NameCHN setTitle:info.Company forState:UIControlStateNormal];
    self.WHAddress.text = [NSString stringWithFormat:@"%@", info.Address];
    self.Person.text = info.Compellation;
    self.PersonTel.text = info.PersonTelString;
    self.ReleaseTime.text = info.CreateDate;
}

- (void)callBtnClik
{
    
    if (self.PersonTel.text.length) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.PersonTel.text]];
        if (self.webView == nil) {
            self.webView = [[UIWebView alloc] init];
        }
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    }
}

@end
