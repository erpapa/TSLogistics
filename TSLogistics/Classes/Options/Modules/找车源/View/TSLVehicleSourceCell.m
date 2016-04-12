//
//  TSLVehicleSourceCell.m
//  TSLogistics
//
//  Created by erpapa on 15/11/18.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLVehicleSourceCell.h"

@interface TSLVehicleSourceCell()
@property (strong, nonatomic) UIButton *SendAddress;
@property (strong, nonatomic) UIButton *ReceiveAddress;
@property (strong, nonatomic) UILabel *NameCHN;
@property (strong, nonatomic) UILabel *Length;
@property (strong, nonatomic) UILabel *VehicleType;
@property (strong, nonatomic) UILabel *Weight;
@property (strong, nonatomic) UILabel *Person;
@property (strong, nonatomic) UILabel *PersonTel;
@property (strong, nonatomic) UIButton *callBtn;
@property (strong, nonatomic) UILabel *BeginTime;
@property (strong, nonatomic) UIWebView *webView;

@end

@implementation TSLVehicleSourceCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    // static修饰局部变量:可以保证局部变量只分配一次存储空间(只初始化一次)
    static NSString *ID = @"GoodsSourceCell";
    // 1.通过一个标识去缓存池中寻找可循环利用的cell
    // dequeue : 出列 (查找)
    TSLVehicleSourceCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 2.如果没有可循环利用的cell
    if (cell == nil){
        cell = [[TSLVehicleSourceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat nameX = kBorder + 3; // label的x
        CGFloat timeWidth = 65; // 日期宽度w
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
        // 5.货物名称
        self.NameCHN = [[UILabel alloc] initWithFrame:CGRectMake(nameX, (kRowHeight + 1) * 2, kLineWidth * 0.32, kRowHeight)];
        // 6.车长
        self.Length = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.NameCHN.frame), (kRowHeight + 1) * 2, kLineWidth * 0.2, kRowHeight)];
        self.Length.textColor = [UIColor orangeColor];
        // 7.货车类型
        self.VehicleType = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.Length.frame), (kRowHeight + 1) * 2, kLineWidth * 0.2, kRowHeight)];
        self.VehicleType.textColor = [UIColor orangeColor];
        // 8.货物重量
        self.Weight = [[UILabel alloc] initWithFrame:CGRectMake(timeX, (kRowHeight + 1) * 2, 40, kRowHeight)];
        self.Weight.textColor = [UIColor orangeColor];
        self.Weight.textAlignment = NSTextAlignmentCenter;
        
        // 9.分割线
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(kBorder, kRowHeight * 3 + 2, kLineWidth, 1)];
        line2.backgroundColor = TSLBackgroundColor;
        // 10.姓名
        self.Person = [[UILabel alloc] initWithFrame:CGRectMake(nameX, (kRowHeight + 1) * 3, kLineWidth * 0.3, kRowHeight)];
        // 11.电话号码
        self.PersonTel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.Person.frame), (kRowHeight + 1) * 3, kLineWidth * 0.5, kRowHeight)];
        // 12.拨打按钮
        self.callBtn = [[UIButton alloc] initWithFrame:CGRectMake(timeX, (kRowHeight + 1) * 3 + 5, 40, 20)];
        [self.callBtn setImage:[UIImage imageNamed:@"拨打图标"] forState:UIControlStateNormal];
        [self.callBtn addTarget:self action:@selector(callBtnClik) forControlEvents:UIControlEventTouchUpInside];
        // 13.分割线
        UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(kBorder, kRowHeight * 4 + 3, kLineWidth, 1)];
        line3.backgroundColor = TSLBackgroundColor;
        // 14.时间
        self.BeginTime = [[UILabel alloc] initWithFrame:CGRectMake(timeX, (kRowHeight + 1) * 4, timeWidth, kRowHeight)];
        self.BeginTime.font = [UIFont systemFontOfSize:12];
        // 15.添加子控件
        [self.contentView addSubview:self.SendAddress];
        [self.contentView addSubview:line0];
        [self.contentView addSubview:self.ReceiveAddress];
        [self.contentView addSubview:line1];
        [self.contentView addSubview:self.NameCHN];
        [self.contentView addSubview:self.Length];
        [self.contentView addSubview:self.VehicleType];
        [self.contentView addSubview:self.Weight];
        [self.contentView addSubview:line2];
        [self.contentView addSubview:self.Person];
        [self.contentView addSubview:self.PersonTel];
        [self.contentView addSubview:self.callBtn];
        [self.contentView addSubview:line3];
        [self.contentView addSubview:self.BeginTime];
    }
    return self;
}

- (void)setInfo:(TSLVehicleSourceInfo *)info
{
    [super setInfo:info];
    [self.SendAddress setTitle:info.DepartureAddress forState:UIControlStateNormal];
    [self.ReceiveAddress setTitle:info.DestinationAddress forState:UIControlStateNormal];
    self.NameCHN.text = info.NameCHN;
    self.Length.text = [NSString stringWithFormat:@"%gm",info.Length];
    self.VehicleType.text = info.VehicleTypeString;
    self.Weight.text = [NSString stringWithFormat:@"%gt",info.Weight];
    self.Person.text = info.PersonString;
    self.PersonTel.text = info.PersonTelString;
    self.BeginTime.text = info.BeginTime;
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
