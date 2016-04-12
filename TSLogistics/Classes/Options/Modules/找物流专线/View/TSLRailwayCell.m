//
//  TSLRailwayCell.m
//  TSLogistics
//
//  Created by erpapa on 15/12/15.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLRailwayCell.h"

@interface TSLRailwayCell()
@property (strong, nonatomic) UIButton *SendAddress;
@property (strong, nonatomic) UIButton *ReceiveAddress;
@property (strong, nonatomic) UILabel *NameCHN;
@property (strong, nonatomic) UILabel *DSAddress;
@property (strong, nonatomic) UILabel *Person;
@property (strong, nonatomic) UILabel *PersonTel;
@property (strong, nonatomic) UIButton *callBtn;
@property (strong, nonatomic) UILabel *ReleaseTime;
@property (strong, nonatomic) UIWebView *webView;

@end

@implementation TSLRailwayCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"GoodsSourceCell";
    TSLRailwayCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil){
        cell = [[TSLRailwayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
        self.SendAddress = [[UIButton alloc] initWithFrame:CGRectMake(kBorder, 0, kLineWidth, kRowHeight)];
        [self.SendAddress setImage:[UIImage imageNamed:@"icon_start"] forState:UIControlStateNormal];
        [self.SendAddress setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.SendAddress.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;// 超出显示省略号
        self.SendAddress.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        self.SendAddress.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.SendAddress.userInteractionEnabled = NO;
        // 2.分割线
        UIView *line0 = [[UIView alloc] initWithFrame:CGRectMake(kBorder, kRowHeight, kLineWidth, 1)];
        line0.backgroundColor = TSLBackgroundColor;
        // 3.终点地址
        self.ReceiveAddress = [[UIButton alloc] initWithFrame:CGRectMake(kBorder, kRowHeight + 1, kLineWidth, kRowHeight)];
        [self.ReceiveAddress setImage:[UIImage imageNamed:@"icon_end"] forState:UIControlStateNormal];
        [self.ReceiveAddress setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.ReceiveAddress.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;// 超出显示省略号
        self.ReceiveAddress.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        self.ReceiveAddress.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.ReceiveAddress.userInteractionEnabled = NO;
        // 4.分割线
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(kBorder, kRowHeight * 2 + 1, kLineWidth, 1)];
        line1.backgroundColor = TSLBackgroundColor;
        // 5.公司名
        self.NameCHN = [[UILabel alloc] initWithFrame:CGRectMake(nameX, (kRowHeight + 1) * 2, kLineWidth - nameX, kRowHeight)];
        // 6.分割线
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(kBorder, kRowHeight * 3 + 2, kLineWidth, 1)];
        line2.backgroundColor = TSLBackgroundColor;
        // 7.公司地址
        self.DSAddress = [[UILabel alloc] initWithFrame:CGRectMake(nameX, (kRowHeight + 1) * 3, kLineWidth - nameX, kRowHeight)];
        self.DSAddress.textColor = [UIColor orangeColor];
        // 8.分割线
        UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(kBorder, kRowHeight * 4 + 3, kLineWidth, 1)];
        line3.backgroundColor = TSLBackgroundColor;
        // 9.姓名
        self.Person = [[UILabel alloc] initWithFrame:CGRectMake(nameX, (kRowHeight + 1) * 4, kLineWidth * 0.3, kRowHeight)];
        // 10.电话号码
        self.PersonTel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.Person.frame), (kRowHeight + 1) * 4, kLineWidth * 0.5, kRowHeight)];
        // 11.拨打按钮
        self.callBtn = [[UIButton alloc] initWithFrame:CGRectMake(timeX, (kRowHeight + 1) * 4 + 5, 40, 20)];
        [self.callBtn setImage:[UIImage imageNamed:@"拨打图标"] forState:UIControlStateNormal];
        [self.callBtn addTarget:self action:@selector(callBtnClik) forControlEvents:UIControlEventTouchUpInside];
        // 12.分割线
        UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(kBorder, kRowHeight * 5 + 4, kLineWidth, 1)];
        line4.backgroundColor = TSLBackgroundColor;
        // 13.时间
        self.ReleaseTime = [[UILabel alloc] initWithFrame:CGRectMake(timeX, (kRowHeight + 1) * 5, timeWidth, kRowHeight)];
        self.ReleaseTime.font = [UIFont systemFontOfSize:12];
        // 14.添加子控件
        [self.contentView addSubview:self.SendAddress];
        [self.contentView addSubview:line0];
        [self.contentView addSubview:self.ReceiveAddress];
        [self.contentView addSubview:line1];
        [self.contentView addSubview:self.NameCHN];
        [self.contentView addSubview:line2];
        [self.contentView addSubview:self.DSAddress];
        [self.contentView addSubview:line3];
        [self.contentView addSubview:self.Person];
        [self.contentView addSubview:self.PersonTel];
        [self.contentView addSubview:self.callBtn];
        [self.contentView addSubview:line4];
        [self.contentView addSubview:self.ReleaseTime];
    }
    return self;
}

- (void)setInfo:(TSLRailwayInfo *)info
{
    [super setInfo:info];
    [self.SendAddress setTitle:info.SendRegionName forState:UIControlStateNormal];
    [self.ReceiveAddress setTitle:info.ReceiveRegionName forState:UIControlStateNormal];
    self.NameCHN.text = info.CompanyName;
    self.DSAddress.text = info.DSAddress;
    self.Person.text = info.PersonString;
    self.PersonTel.text = info.PersonTelString;
    self.ReleaseTime.text = info.ReleaseTime;
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
