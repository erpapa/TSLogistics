//
//  TSLDistributionCenterCell.m
//  TSLogistics
//
//  Created by erpapa on 15/12/30.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLDistributionCenterCell.h"

@interface TSLDistributionCenterCell()

@property (strong, nonatomic) UIButton *NameCHN;
@property (strong, nonatomic) UILabel *ServerType;
@property (strong, nonatomic) UILabel *ServerRegion;
@property (strong, nonatomic) UILabel *DCAddress;
@property (strong, nonatomic) UILabel *Person;
@property (strong, nonatomic) UILabel *PersonTel;
@property (strong, nonatomic) UIButton *callBtn;
@property (strong, nonatomic) UILabel *ReleaseTime;
@property (strong, nonatomic) UIWebView *webView;
@end

@implementation TSLDistributionCenterCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"DistributionCenterCell";
    TSLDistributionCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil){
        cell = [[TSLDistributionCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
        // 3.类型
        self.ServerType = [[UILabel alloc] initWithFrame:CGRectMake(nameX, kRowHeight + 1, kLineWidth * 0.5, kRowHeight)];
        // 4.服务区域
        UILabel *ServerRegionLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLineWidth * 0.5, kRowHeight + 1, 17 * 4.5, kRowHeight)];
        ServerRegionLabel.text = @"服务区域:";
        ServerRegionLabel.textColor = [UIColor grayColor];
        self.ServerRegion = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(ServerRegionLabel.frame), kRowHeight + 1, ScreenW - CGRectGetMaxX(ServerRegionLabel.frame), kRowHeight)];
        // 5.分割线
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(kBorder, kRowHeight * 2 + 1, kLineWidth, 1)];
        line1.backgroundColor = TSLBackgroundColor;
        // 6.地址
        self.DCAddress = [[UILabel alloc] initWithFrame:CGRectMake(nameX, (kRowHeight + 1) * 2, kLineWidth, kRowHeight)];
        self.DCAddress.textColor = [UIColor orangeColor];
        // 7.分割线
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(kBorder, kRowHeight * 3 + 2, kLineWidth, 1)];
        line2.backgroundColor = TSLBackgroundColor;
        // 8.姓名
        self.Person = [[UILabel alloc] initWithFrame:CGRectMake(nameX, (kRowHeight + 1) * 3, kLineWidth * 0.3, kRowHeight)];
        // 9.电话号码
        self.PersonTel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.Person.frame), (kRowHeight + 1) * 3, kLineWidth * 0.5, kRowHeight)];
        // 10.拨打按钮
        self.callBtn = [[UIButton alloc] initWithFrame:CGRectMake(timeX, (kRowHeight + 1) * 3 + 5, 40, 20)];
        [self.callBtn setImage:[UIImage imageNamed:@"拨打图标"] forState:UIControlStateNormal];
        [self.callBtn addTarget:self action:@selector(callBtnClik) forControlEvents:UIControlEventTouchUpInside];
        // 11.分割线
        UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(kBorder, kRowHeight * 4 + 3, kLineWidth, 1)];
        line3.backgroundColor = TSLBackgroundColor;
        // 12.时间
        self.ReleaseTime = [[UILabel alloc] initWithFrame:CGRectMake(timeX, (kRowHeight + 1) * 4, timeWidth, kRowHeight)];
        self.ReleaseTime.font = [UIFont systemFontOfSize:12];
        // 13.添加子控件
        [self.contentView addSubview:self.NameCHN];
        [self.contentView addSubview:line0];
        [self.contentView addSubview:self.ServerType];
        [self.contentView addSubview:ServerRegionLabel];
        [self.contentView addSubview:self.ServerRegion];
        [self.contentView addSubview:line1];
        [self.contentView addSubview:self.DCAddress];
        [self.contentView addSubview:line2];
        [self.contentView addSubview:self.Person];
        [self.contentView addSubview:self.PersonTel];
        [self.contentView addSubview:self.callBtn];
        [self.contentView addSubview:line3];
        [self.contentView addSubview:self.ReleaseTime];
    }
    return self;
}

- (void)setInfo:(TSLDistributionCenterInfo *)info
{
    [super setInfo:info];
    [self.NameCHN setTitle:info.NameCHN forState:UIControlStateNormal];
    self.ServerType.text = info.ServerTypeString;
    self.ServerRegion.text = info.ServerRegion;
    self.DCAddress.text = info.DCAddress;
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
