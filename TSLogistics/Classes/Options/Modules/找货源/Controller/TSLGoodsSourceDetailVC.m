//
//  TSLGoodsSourceDetailVC.m
//  TSLogistics
//
//  Created by erpapa on 15/11/17.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLGoodsSourceDetailVC.h"
#import "TSLGoodsSourceInfo.h"
#define textWidth 80    // 宽80

@interface TSLGoodsSourceDetailVC ()
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIButton *SendAddress;
@property (strong, nonatomic) TSLCollectView *collectView;
@property (strong, nonatomic) UIButton *ReceiveAddress;
@property (strong, nonatomic) UILabel *NameCHN;
@property (strong, nonatomic) UILabel *GoodsWeight;
@property (strong, nonatomic) UILabel *GoodsType;
@property (strong, nonatomic) UILabel *TransferType;
@property (strong, nonatomic) UILabel *VehicleType;
@property (strong, nonatomic) UILabel *Length;
@property (strong, nonatomic) UILabel *Price;
@property (strong, nonatomic) UILabel *IsLongTime;
@property (strong, nonatomic) UILabel *frequency;
@property (strong, nonatomic) UILabel *CompanyName;
@property (strong, nonatomic) UILabel *Person;
@property (strong, nonatomic) UILabel *PersonTel;
@property (strong, nonatomic) UILabel *ReleaseTime;
@property (strong, nonatomic) UILabel *BeginTime;
@property (strong, nonatomic) UILabel *OtherRequire;
@property (strong, nonatomic) UIView *requireView;
@property (strong, nonatomic) TSLTelphoneView *telphoneView;
@end

@implementation TSLGoodsSourceDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupContentView];
    [self loadInfo];
}

/**
 *  初始化子控件
 */
- (void)setupContentView
{
    CGFloat leftLabelX = 8;
    CGFloat lineWidth = ScreenW - 2 * kBorderX;
    CGFloat leftInfoX = textWidth;
    CGFloat rightInfoX = lineWidth * 0.5 + textWidth;
    CGFloat infoWidth = lineWidth * 0.5 + leftLabelX - textWidth;
    
    // 0.scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.backgroundColor = TSLBackgroundColor;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];

    // 1.1.起始地址
    self.SendAddress = [self buttonWithTitle:@"" image:@"icon_start"];
    self.SendAddress.frame = CGRectMake(0, 0, lineWidth - kHeight, kHeight);
    // 1.2 收藏
    self.collectView = [[TSLCollectView alloc] initWithFrame:CGRectMake(lineWidth - kHeight, 0, kHeight, kHeight)];
    self.collectView.delegate = self;
    // 1.3.终点地址
    self.ReceiveAddress = [self buttonWithTitle:@"" image:@"icon_end"];
    self.ReceiveAddress.frame = CGRectMake(0, kHeight, lineWidth, kHeight);
    UIView *bgView1 = [[UIView alloc] initWithFrame:CGRectMake(kBorderX, kBorderHeight, lineWidth, kHeight * 2)];
    bgView1.backgroundColor = [UIColor whiteColor];
    [bgView1 addSubview:self.SendAddress];
    [bgView1 addSubview:self.collectView];
    [bgView1 addSubview:self.ReceiveAddress];
    [self.scrollView addSubview:bgView1];
    
    // 2.1.货物信息
    UIButton *goodsInfo = [self buttonWithTitle:@"货物信息" image:@"huoyuanImage"];
    // 2.2.分割线
    UIView *line2 = [self lineWithOrigin:CGPointMake(0, kHeight)];
    // 2.3.货物名称
    UILabel *NameCHNLabel = [self labelWithTitle:@"货物名称:" origin:CGPointMake(0, kHeight + 1)];
    self.NameCHN = [[UILabel alloc] initWithFrame:CGRectMake(leftInfoX, kHeight + 1, lineWidth - leftInfoX, kHeight)];
    // 2.4.货物重量
    UILabel *GoodsWeightLabel = [self labelWithTitle:@"货物重量:" origin:CGPointMake(0, kHeight * 2 + 1)];
    self.GoodsWeight = [[UILabel alloc] initWithFrame:CGRectMake(leftInfoX, kHeight * 2 + 1, infoWidth, kHeight)];
    // 2.5.货物类型
    UILabel *GoodsTypeLabel = [self labelWithTitle:@"货物类型:" origin:CGPointMake(lineWidth * 0.5, kHeight * 2 + 1)];
    self.GoodsType = [[UILabel alloc] initWithFrame:CGRectMake(rightInfoX, kHeight * 2 + 1, infoWidth, kHeight)];
    UIView *bgView2 = [[UIView alloc] initWithFrame:CGRectMake(kBorderX, CGRectGetMaxY(bgView1.frame) + kBorderHeight, lineWidth, kHeight * 3 + 1)];
    bgView2.backgroundColor = [UIColor whiteColor];
    [bgView2 addSubview:goodsInfo];
    [bgView2 addSubview:line2];
    [bgView2 addSubview:NameCHNLabel];
    [bgView2 addSubview:self.NameCHN];
    [bgView2 addSubview:GoodsWeightLabel];
    [bgView2 addSubview:self.GoodsWeight];
    [bgView2 addSubview:GoodsTypeLabel];
    [bgView2 addSubview:self.GoodsType];
    [self.scrollView addSubview:bgView2];
    
    // 3.1.货源信息
    UIButton *goodsSource = [self buttonWithTitle:@"货源信息" image:@"goodsImage"];
    // 3.2.分割线
    UIView *line3 = [self lineWithOrigin:CGPointMake(0, kHeight)];
    // 3.3.运输类型
    UILabel *TransferTypeLabel = [self labelWithTitle:@"运输类型:" origin:CGPointMake(0,kHeight + 1)];
    self.TransferType = [[UILabel alloc] initWithFrame:CGRectMake(leftInfoX, kHeight + 1, infoWidth, kHeight)];
    // 3.4.车辆类型
    UILabel *VehicleTypeLabel = [self labelWithTitle:@"车辆类型:" origin:CGPointMake(lineWidth * 0.5, kHeight + 1)];
    self.VehicleType = [[UILabel alloc] initWithFrame:CGRectMake(rightInfoX, kHeight + 1, infoWidth, kHeight)];
    // 3.5.车长要求
    UILabel *LengthLable = [self labelWithTitle:@"车长要求:" origin:CGPointMake(0, kHeight * 2 + 1)];
    self.Length = [[UILabel alloc] initWithFrame:CGRectMake(leftInfoX, kHeight * 2 + 1, infoWidth, kHeight)];
    // 3.6.期望运价
    UILabel *PriceLabel = [self labelWithTitle:@"期望运价:" origin:CGPointMake(lineWidth * 0.5, kHeight * 2 + 1)];
    self.Price = [[UILabel alloc] initWithFrame:CGRectMake(rightInfoX, kHeight * 2 + 1, infoWidth, kHeight)];
    // 3.7.有效期
    UILabel *IsLongTime = [self labelWithTitle:@"有效期:" origin:CGPointMake(0, kHeight * 3 + 1)];
    self.IsLongTime = [[UILabel alloc] initWithFrame:CGRectMake(leftInfoX, kHeight * 3 + 1, infoWidth, kHeight)];
    // 3.8.发货频率
    UILabel *frequencyLabel = [self labelWithTitle:@"发货频率:" origin:CGPointMake(lineWidth * 0.5, kHeight * 3 + 1)];
    self.frequency = [[UILabel alloc] initWithFrame:CGRectMake(rightInfoX, kHeight * 3 + 1, infoWidth, kHeight)];
    
    UIView *bgView3 = [[UIView alloc] initWithFrame:CGRectMake(kBorderX, CGRectGetMaxY(bgView2.frame) + kBorderHeight, lineWidth, kHeight * 4 + 1)];
    bgView3.backgroundColor = [UIColor whiteColor];
    [bgView3 addSubview:goodsSource];
    [bgView3 addSubview:line3];
    [bgView3 addSubview:TransferTypeLabel];
    [bgView3 addSubview:self.TransferType];
    [bgView3 addSubview:VehicleTypeLabel];
    [bgView3 addSubview:self.VehicleType];
    [bgView3 addSubview:LengthLable];
    [bgView3 addSubview:self.Length];
    [bgView3 addSubview:PriceLabel];
    [bgView3 addSubview:self.Price];
    [bgView3 addSubview:IsLongTime];
    [bgView3 addSubview:self.IsLongTime];
    [bgView3 addSubview:frequencyLabel];
    [bgView3 addSubview:self.frequency];
    [self.scrollView addSubview:bgView3];
    
    // 4.1.联系方式
    UIButton *contact = [self buttonWithTitle:@"联系方式" image:@"ruzhu2"];
    // 4.2.分割线
    UIView *line4 = [self lineWithOrigin:CGPointMake(0, kHeight)];
    // 4.3.公司名
    self.CompanyName = [[UILabel alloc] initWithFrame:CGRectMake(leftLabelX, kHeight + 1, lineWidth - 5, kHeight)];
    // 4.4.人名
    self.Person = [[UILabel alloc] initWithFrame:CGRectMake(leftLabelX, kHeight * 2 + 1, lineWidth * 0.5, kHeight)];
    // 4.5.联系电话
    self.PersonTel = [[UILabel alloc] initWithFrame:CGRectMake(lineWidth * 0.6 - 2 * kBorderX, kHeight * 2 + 1, lineWidth * 0.4, kHeight)];
    self.PersonTel.textAlignment = NSTextAlignmentRight;
    
    UIView *bgView4 = [[UIView alloc] initWithFrame:CGRectMake(kBorderX, CGRectGetMaxY(bgView3.frame) + kBorderHeight, lineWidth, kHeight * 3 + 1)];
    bgView4.backgroundColor = [UIColor whiteColor];
    [bgView4 addSubview:contact];
    [bgView4 addSubview:line4];
    [bgView4 addSubview:self.CompanyName];
    [bgView4 addSubview:self.Person];
    [bgView4 addSubview:self.PersonTel];
    [self.scrollView addSubview:bgView4];
    
    // 5.1.时间
    UIButton *time = [self buttonWithTitle:@"时间" image:@"timeImage"];
    // 5.2.分割线
    UIView *line5 = [self lineWithOrigin:CGPointMake(0, kHeight)];
    
    UILabel *ReleaseTimeLabel = [self labelWithTitle:@"发布日期" origin:CGPointMake(-leftLabelX, kHeight + 1)];
    self.ReleaseTime = [[UILabel alloc] initWithFrame:CGRectMake(lineWidth * 0.6 - leftLabelX, kHeight + 1, lineWidth * 0.4, kHeight)];
    self.ReleaseTime.textAlignment = NSTextAlignmentRight;
    
    UILabel *BeginTimeLabel = [self labelWithTitle:@"发货日期" origin:CGPointMake(-leftLabelX, kHeight * 2 + 1)];
    self.BeginTime = [[UILabel alloc] initWithFrame:CGRectMake(lineWidth * 0.6 - leftLabelX, kHeight * 2 + 1, lineWidth * 0.4, kHeight)];
    self.BeginTime.textAlignment = NSTextAlignmentRight;
    
    UIView *bgView5 = [[UIView alloc] initWithFrame:CGRectMake(kBorderX, CGRectGetMaxY(bgView4.frame) + kBorderHeight, lineWidth, kHeight * 3 + 1)];
    bgView5.backgroundColor = [UIColor whiteColor];
    [bgView5 addSubview:time];
    [bgView5 addSubview:line5];
    [bgView5 addSubview:ReleaseTimeLabel];
    [bgView5 addSubview:self.ReleaseTime];
    [bgView5 addSubview:BeginTimeLabel];
    [bgView5 addSubview:self.BeginTime];
    [self.scrollView addSubview:bgView5];
    
    // 6.1.备注
    UIButton *require = [self buttonWithTitle:@"备注" image:@"beizhuImage"];
    UIView *line6 = [self lineWithOrigin:CGPointMake(0, kHeight)];
    self.OtherRequire = [[UILabel alloc] initWithFrame:CGRectMake(leftLabelX, kHeight + 1, lineWidth - 2 * leftLabelX, kHeight)];
    self.OtherRequire.numberOfLines = 0;
    self.requireView = [[UIView alloc] initWithFrame:CGRectMake(kBorderX, CGRectGetMaxY(bgView5.frame) + kBorderHeight, lineWidth, kHeight + 1)];
    self.requireView.backgroundColor = [UIColor whiteColor];
    [self.requireView addSubview:require];
    [self.requireView addSubview:line6];
    [self.requireView addSubview:self.OtherRequire];
    [self.scrollView addSubview:self.requireView];

    // 7.1 通讯录
    self.telphoneView = [[TSLTelphoneView alloc] initWithFrame:CGRectMake(0, ScreenH - 50, ScreenW, 50)];
    self.telphoneView.backgroundColor = TSLBackgroundColor;
    self.telphoneView.delegate = self;
    [self.view addSubview:self.telphoneView];
    self.scrollView.contentSize = CGSizeMake(ScreenW, CGRectGetMaxY(self.requireView.frame));
}

/**
 *  加载数据
 */
- (void)loadInfo
{
    // 如果要联网获取
    if (self.Identifier) {
        [self.activityView startAnimating];
        TSLUser *user = [TSLUser sharedUser];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"identifier"] = @(self.Identifier);
        param[@"collectid"] = user.Identifier ? @(user.Identifier) : [NSNull null];
        [TSLHttpTool POST:[NSString stringWithFormat:@"%@%@", TSLAPI_PREFIX, TSLAPI_GoodsSource] parameters:param success:^(id json) {
            NSArray *infoArray = [TSLGoodsSourceInfo objectArrayWithKeyValuesArray:json];
            self.info = [infoArray firstObject];
            [self loadInfo:self.info];
            [self.activityView stopAnimating];
        } failure:^(NSError *error) {
            [self.activityView stopAnimating];
        }];
    } else {
        [self loadInfo:self.info];
    }
}

/**
 *  赋值
 */
- (void)loadInfo:(TSLGoodsSourceInfo *)info
{
    [self.SendAddress setTitle:info.SendAddress forState:UIControlStateNormal];
    self.collectView.collected = [info.iscollected isEqualToString:@"1"] ? YES : NO;
    [self.ReceiveAddress setTitle:info.ReceiveAddress forState:UIControlStateNormal];
    self.NameCHN.text = info.NameCHN;
    self.GoodsWeight.text = info.goodsWeightOrBulk;
    self.GoodsType.text = info.GoodsTypeString;
    self.TransferType.text = info.TransferTypeString;
    self.VehicleType.text = info.RequirementVehicleTypeString;
    self.Length.text = info.LengthString;
    self.Price.text = info.PriceString;
    NSString *isLongTime = [NSString stringWithFormat:@"%ld天", info.IsLongTime];
    self.IsLongTime.text = info.IsLongTime > 100 ? @"长期":isLongTime;
    self.frequency.text = info.frequency;
    self.CompanyName.text = info.CompanyName;
    self.Person.text = info.PersonString;
    self.PersonTel.text = info.PersonTelString;
    self.ReleaseTime.text = info.ReleaseTime;
    self.BeginTime.text = info.BeginTime;
    if (info.OtherRequire.length) {
        self.OtherRequire.text = info.OtherRequire;
        CGSize requireSize = [info.OtherRequire sizeWithFont:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(ScreenW - (8 + kBorderX) * 2, MAXFLOAT)];
        self.OtherRequire.mj_h = requireSize.height > kHeight ? requireSize.height : kHeight;
        self.requireView.mj_h += self.OtherRequire.mj_h;
        self.scrollView.contentSize = CGSizeMake(ScreenW, CGRectGetMaxY(self.requireView.frame) + self.telphoneView.mj_h);
    } else {
        self.requireView.hidden = YES;
        self.scrollView.contentSize = CGSizeMake(ScreenW, CGRectGetMaxY(self.ReleaseTime.superview.frame) + self.telphoneView.mj_h);
    }
    self.telphoneView.telString = info.PersonTelString;
    self.DestinationCoordinate = (CLLocationCoordinate2D){[info.MapY doubleValue], [info.MapX doubleValue]};
}
/**
 *  重写,返回固定长度的label
 */
- (UILabel *)labelWithTitle:(NSString *)title origin:(CGPoint)origin
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(origin.x, origin.y, textWidth, kHeight)];
    label.text = title;
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentRight;
    return label;
}

#pragma mark - TSLTelphoneView delegate
- (void)collectView:(TSLCollectView *)collectView didCollected:(BOOL)success
{
    if (success) { // 收藏成功，置1
        TSLGoodsSourceInfo *info = (TSLGoodsSourceInfo *)self.info;
        info.iscollected = @"1";
    }
}

- (TSLCollectionParam *)collectionParam
{
    TSLGoodsSourceInfo *info = (TSLGoodsSourceInfo *)self.info;
    TSLCollectionParam *param = [[TSLCollectionParam alloc] init];
    param.userId = [TSLUser sharedUser].Identifier;
    param.LogisticsId = info.Identifier;
    param.TheState = info.TheState;
    param.LogisticsType = 8;
    return param;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
