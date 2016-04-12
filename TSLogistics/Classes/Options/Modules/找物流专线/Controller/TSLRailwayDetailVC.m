//
//  TSLRailwayDetailVC.m
//  TSLogistics
//
//  Created by erpapa on 15/12/30.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLRailwayDetailVC.h"
#import "TSLRailwayInfo.h"

@interface TSLRailwayDetailVC ()
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIButton *SendAddress;
@property (strong, nonatomic) TSLCollectView *collectView;
@property (strong, nonatomic) UIButton *ReceiveAddress;
@property (strong, nonatomic) UILabel *DSType;
@property (strong, nonatomic) UILabel *PriceType;
@property (strong, nonatomic) UILabel *TransGoodsType;
@property (strong, nonatomic) UILabel *Price;
@property (strong, nonatomic) UILabel *Length;
@property (strong, nonatomic) UILabel *Weight;
@property (strong, nonatomic) UILabel *VehicleType;
@property (strong, nonatomic) UILabel *CompanyName;
@property (strong, nonatomic) UILabel *Person;
@property (strong, nonatomic) UILabel *PersonTel;
@property (strong, nonatomic) UILabel *ReleaseTime;
@property (strong, nonatomic) UILabel *OtherRequire;
@property (strong, nonatomic) UIView *requireView;
@property (strong, nonatomic) TSLTelphoneView *telphoneView;
@end

@implementation TSLRailwayDetailVC


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
    CGFloat rightlabelX = lineWidth * 0.5 - leftLabelX;
    
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
    [bgView1 addSubview:self.collectView];
    [bgView1 addSubview:self.SendAddress];
    [bgView1 addSubview:self.ReceiveAddress];
    [self.scrollView addSubview:bgView1];
    
    // 2.1.专线信息
    UIButton *VehicleInfo = [self buttonWithTitle:@"专线信息" image:@"zhuanxianImage"];
    // 2.2.分割线
    UIView *line2 = [self lineWithOrigin:CGPointMake(0, kHeight)];
    // 2.3.物流专线类型
    UILabel *DSTypeLabel = [self labelWithTitle:@"专线类型:" origin:CGPointMake(leftLabelX, kHeight + 1)];
    self.DSType = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(DSTypeLabel.frame), kHeight + 1, rightlabelX - CGRectGetMaxX(DSTypeLabel.frame), kHeight)];
    // 2.4.运输类型
    UILabel *PriceTypeLabel = [self labelWithTitle:@"运输类型:" origin:CGPointMake(rightlabelX, kHeight + 1)];
    self.PriceType = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(PriceTypeLabel.frame), kHeight + 1, lineWidth - CGRectGetMaxX(PriceTypeLabel.frame), kHeight)];
    // 2.5.货物类型
    UILabel *TransGoodsTypeLabel = [self labelWithTitle:@"货物类型:" origin:CGPointMake(leftLabelX,kHeight * 2 + 1)];
    self.TransGoodsType = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(TransGoodsTypeLabel.frame), kHeight * 2 + 1, rightlabelX - CGRectGetMaxX(TransGoodsTypeLabel.frame), kHeight)];
    // 2.6.运输价格
    UILabel *PriceLabel = [self labelWithTitle:@"运输价格:" origin:CGPointMake(rightlabelX, kHeight * 2 + 1)];
    self.Price = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(PriceLabel.frame), kHeight * 2 + 1, ScreenW - CGRectGetMaxX(PriceLabel.frame), kHeight)];

    UIView *bgView2 = [[UIView alloc] initWithFrame:CGRectMake(kBorderX, CGRectGetMaxY(bgView1.frame) + kBorderHeight, lineWidth, kHeight * 3 + 1)];
    bgView2.backgroundColor = [UIColor whiteColor];
    [bgView2 addSubview:VehicleInfo];
    [bgView2 addSubview:line2];
    [bgView2 addSubview:DSTypeLabel];
    [bgView2 addSubview:self.DSType];
    [bgView2 addSubview:PriceTypeLabel];
    [bgView2 addSubview:self.PriceType];
    [bgView2 addSubview:TransGoodsTypeLabel];
    [bgView2 addSubview:self.TransGoodsType];
    [bgView2 addSubview:PriceLabel];
    [bgView2 addSubview:self.Price];
    [self.scrollView addSubview:bgView2];
    
    // 3.1.车辆要求
    UIButton *goodsSource = [self buttonWithTitle:@"车辆要求" image:@"goodsImage"];
    // 3.2.分割线
    UIView *line3 = [self lineWithOrigin:CGPointMake(0, kHeight)];
    // 3.3.车长
    UILabel *LengthLable = [self labelWithTitle:@"车长要求:" origin:CGPointMake(leftLabelX, kHeight + 1)];
    self.Length = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(LengthLable.frame), kHeight + 1, lineWidth - CGRectGetMaxX(LengthLable.frame), kHeight)];
    // 3.4.载重
    UILabel *WeightLabel = [self labelWithTitle:@"车辆载重:" origin:CGPointMake(leftLabelX, kHeight * 2 + 1)];
    self.Weight = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(WeightLabel.frame), kHeight * 2 + 1, rightlabelX - CGRectGetMaxX(WeightLabel.frame), kHeight)];
    // 3.5.车辆类型
    UILabel *VehicleTypeLabel = [self labelWithTitle:@"车辆类型:" origin:CGPointMake(leftLabelX, kHeight * 3 + 1)];
    self.VehicleType = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(VehicleTypeLabel.frame), kHeight * 3 + 1, lineWidth - CGRectGetMaxX(VehicleTypeLabel.frame), kHeight)];
    
    UIView *bgView3 = [[UIView alloc] initWithFrame:CGRectMake(kBorderX, CGRectGetMaxY(bgView2.frame) + kBorderHeight, lineWidth, kHeight * 4 + 1)];
    bgView3.backgroundColor = [UIColor whiteColor];
    [bgView3 addSubview:goodsSource];
    [bgView3 addSubview:line3];
    [bgView3 addSubview:LengthLable];
    [bgView3 addSubview:self.Length];
    [bgView3 addSubview:WeightLabel];
    [bgView3 addSubview:self.Weight];
    [bgView3 addSubview:VehicleTypeLabel];
    [bgView3 addSubview:self.VehicleType];
    [self.scrollView addSubview:bgView3];
    
    // 4.1.联系方式
    UIButton *contact = [self buttonWithTitle:@"联系方式" image:@"ruzhu2"];
    // 4.2.分割线
    UIView *line4 = [self lineWithOrigin:CGPointMake(0, kHeight)];
    // 4.3.公司名
    self.CompanyName = [[UILabel alloc] initWithFrame:CGRectMake(leftLabelX, kHeight + 1, lineWidth - leftLabelX * 2, kHeight)];
    // 4.4.人名
    self.Person = [[UILabel alloc] initWithFrame:CGRectMake(leftLabelX, kHeight * 2 + 1, lineWidth * 0.5, kHeight)];
    // 4.5.联系电话
    self.PersonTel = [[UILabel alloc] initWithFrame:CGRectMake(lineWidth * 0.6 - leftLabelX, kHeight * 2 + 1, lineWidth * 0.4, kHeight)];
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
    UIButton *time = [self buttonWithTitle:@"发布日期" image:@"timeImage"];
    self.ReleaseTime = [[UILabel alloc] initWithFrame:CGRectMake(lineWidth * 0.6 - leftLabelX, 0, lineWidth * 0.4, kHeight)];
    self.ReleaseTime.textAlignment = NSTextAlignmentRight;
    
    UIView *bgView5 = [[UIView alloc] initWithFrame:CGRectMake(kBorderX, CGRectGetMaxY(bgView4.frame) + kBorderHeight, lineWidth, kHeight + 1)];
    bgView5.backgroundColor = [UIColor whiteColor];
    [bgView5 addSubview:time];
    [bgView5 addSubview:self.ReleaseTime];
    [self.scrollView addSubview:bgView5];
    
    // 6.1.备注
    UIButton *require = [self buttonWithTitle:@"备注" image:@"beizhuImage"];
    UIView *line6 = [self lineWithOrigin:CGPointMake(0, kHeight)];
    self.OtherRequire = [[UILabel alloc] initWithFrame:CGRectMake(leftLabelX, kHeight + 1, lineWidth - 2 * leftLabelX, kHeight)];
    self.OtherRequire.numberOfLines = 0;
    self.requireView = [[UIView alloc] initWithFrame:CGRectMake(kBorderX, CGRectGetMaxY(bgView5.frame) + kBorderHeight, lineWidth, kHeight * 2 + 1)];
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
    self.scrollView.contentSize = CGSizeMake(ScreenW, CGRectGetMaxY(self.requireView.frame) + self.telphoneView.bounds.size.height);
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
        [TSLHttpTool POST:[NSString stringWithFormat:@"%@%@", TSLAPI_PREFIX, TSLAPI_Railway] parameters:param success:^(id json) {
            NSArray *infoArray = [TSLRailwayInfo objectArrayWithKeyValuesArray:json];
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
- (void)loadInfo:(TSLRailwayInfo *)info
{
    [self.SendAddress setTitle:info.SendRegionName forState:UIControlStateNormal];
    self.collectView.collected = [info.iscollected isEqualToString:@"1"] ? YES : NO;
    [self.ReceiveAddress setTitle:info.ReceiveRegionName forState:UIControlStateNormal];
    self.DSType.text = info.DSTypeString;
    self.PriceType.text = info.PriceTypeString;
    self.TransGoodsType.text = info.TransGoodsTypeString;
    self.Price.text = info.PriceString;
    self.Length.text = [NSString stringWithFormat:@"%g米", info.Length];
    self.Weight.text = [NSString stringWithFormat:@"%gt", info.Weight];
    self.VehicleType.text = info.VehicleTypeString;
    self.CompanyName.text = info.CompanyName;
    self.Person.text = info.PersonString;
    self.PersonTel.text = info.PersonTelString;
    self.ReleaseTime.text = info.ReleaseTime;
    self.telphoneView.telString = info.PersonTelString;
    self.DestinationCoordinate = (CLLocationCoordinate2D){[info.MapY doubleValue], [info.MapX doubleValue]};
}

#pragma mark - TSLTelphoneView delegate

- (void)collectView:(TSLCollectView *)collectView didCollected:(BOOL)success
{
    if (success) { // 收藏成功，置1
        TSLRailwayInfo *info = (TSLRailwayInfo *)self.info;
        info.iscollected = @"1";
    }
}
- (TSLCollectionParam *)collectionParam
{
    TSLRailwayInfo *info = (TSLRailwayInfo *)self.info;
    TSLCollectionParam *param = [[TSLCollectionParam alloc] init];
    param.userId = [TSLUser sharedUser].Identifier;
    param.LogisticsId = info.Identifier;
    param.TheState = info.TheState;
    param.LogisticsType = 10;
    return param;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
