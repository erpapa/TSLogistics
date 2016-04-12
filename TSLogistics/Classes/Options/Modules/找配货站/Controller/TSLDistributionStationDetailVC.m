//
//  TSLDistributionStationDetailVC.m
//  TSLogistics
//
//  Created by erpapa on 15/12/15.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLDistributionStationDetailVC.h"
#import "TSLDistributionStationInfo.h"
#import "UIView+MJExtension.h"

@interface TSLDistributionStationDetailVC ()
@property (strong, nonatomic) UIButton *NameCHN;
@property (strong, nonatomic) UILabel *WHAddress;
@property (strong, nonatomic) UILabel *WHArea;
@property (strong, nonatomic) UILabel *Person;
@property (strong, nonatomic) UILabel *PersonTel;
@property (strong, nonatomic) UILabel *ReleaseTime;
@property (strong, nonatomic) TSLTelphoneView *telphoneView;
@end

@implementation TSLDistributionStationDetailVC

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

    // 0.scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = TSLBackgroundColor;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    // 1.1.公司名
    self.NameCHN = [self buttonWithTitle:@"" image:@"dian"];
    self.NameCHN.frame = CGRectMake(0, 0, lineWidth - kHeight, kHeight);
    // 1.2 收藏
    UIView *bgView1 = [[UIView alloc] initWithFrame:CGRectMake(kBorderX, kBorderHeight, lineWidth, kHeight)];
    bgView1.backgroundColor = [UIColor whiteColor];
    [bgView1 addSubview:self.NameCHN];
    [scrollView addSubview:bgView1];
    
    // 2.1.基本信息
    UIButton *WHInfo = [self buttonWithTitle:@"站点信息" image:@"peihuoImage"];
    // 2.2.分割线
    UIView *line2 = [self lineWithOrigin:CGPointMake(0, kHeight)];
    // 2.3.地址
    UILabel *WHAddressLabel = [self labelWithTitle:@"所在地址:" origin:CGPointMake(leftLabelX, kHeight + 1)];
    WHAddressLabel.mj_h = kHeight * 1.2;
    self.WHAddress = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(WHAddressLabel.frame), CGRectGetMinY(WHAddressLabel.frame), lineWidth - CGRectGetMaxX(WHAddressLabel.frame), kHeight * 1.2)];
    // 2.4.详细地址
    UILabel *WHAreaLabel = [self labelWithTitle:@"所属地区:" origin:CGPointMake(leftLabelX, kHeight * 2 + 1)];
    WHAreaLabel.mj_h = kHeight * 1.2;
    self.WHArea = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(WHAreaLabel.frame), CGRectGetMinY(WHAreaLabel.frame), lineWidth - CGRectGetMaxX(WHAreaLabel.frame), kHeight * 1.2)];
    UIView *bgView2 = [[UIView alloc] initWithFrame:CGRectMake(kBorderX, CGRectGetMaxY(bgView1.frame) + kBorderHeight, lineWidth, CGRectGetMaxY(WHAreaLabel.frame))];
    bgView2.backgroundColor = [UIColor whiteColor];
    [bgView2 addSubview:WHInfo];
    [bgView2 addSubview:line2];
    [bgView2 addSubview:WHAddressLabel];
    [bgView2 addSubview:self.WHAddress];
    [bgView2 addSubview:WHAreaLabel];
    [bgView2 addSubview:self.WHArea];
    [scrollView addSubview:bgView2];
    
    // 4.1.联系方式
    UIButton *contact = [self buttonWithTitle:@"联系方式" image:@"ruzhu2"];
    // 4.2.分割线
    UIView *line3 = [self lineWithOrigin:CGPointMake(0, kHeight)];
    // 4.4.人名
    self.Person = [[UILabel alloc] initWithFrame:CGRectMake(leftLabelX, kHeight * + 1, lineWidth * 0.5, kHeight)];
    // 4.5.联系电话
    self.PersonTel = [[UILabel alloc] initWithFrame:CGRectMake(lineWidth * 0.6 - leftLabelX, kHeight * + 1, lineWidth * 0.4, kHeight)];
    self.PersonTel.textAlignment = NSTextAlignmentRight;
    
    UIView *bgView3 = [[UIView alloc] initWithFrame:CGRectMake(kBorderX, CGRectGetMaxY(bgView2.frame) + kBorderHeight, lineWidth, kHeight * 2 + 1)];
    bgView3.backgroundColor = [UIColor whiteColor];
    [bgView3 addSubview:contact];
    [bgView3 addSubview:line3];
    [bgView3 addSubview:self.Person];
    [bgView3 addSubview:self.PersonTel];
    [scrollView addSubview:bgView3];
    
    // 5.1.时间
    UIButton *time = [self buttonWithTitle:@"发布日期" image:@"timeImage"];
    self.ReleaseTime = [[UILabel alloc] initWithFrame:CGRectMake(lineWidth * 0.6 - leftLabelX, 0, lineWidth * 0.4, kHeight)];
    self.ReleaseTime.textAlignment = NSTextAlignmentRight;
    
    UIView *bgView4 = [[UIView alloc] initWithFrame:CGRectMake(kBorderX, CGRectGetMaxY(bgView3.frame) + kBorderHeight, lineWidth, kHeight)];
    bgView4.backgroundColor = [UIColor whiteColor];
    [bgView4 addSubview:time];
    [bgView4 addSubview:self.ReleaseTime];
    [scrollView addSubview:bgView4];
    
    // 6.1 通讯录
    self.telphoneView = [[TSLTelphoneView alloc] initWithFrame:CGRectMake(0, ScreenH - 50, ScreenW, 50)];
    self.telphoneView.backgroundColor = TSLBackgroundColor;
    self.telphoneView.delegate = self;
    [self.view addSubview:self.telphoneView];
    scrollView.contentSize = CGSizeMake(ScreenW, CGRectGetMaxY(bgView4.frame) + self.telphoneView.bounds.size.height);
}

/**
 *  加载数据
 */
- (void)loadInfo
{
    // 如果要联网获取
    if (self.Identifier) {
        [self.activityView startAnimating];
        [TSLHttpTool POST:[NSString stringWithFormat:@"%@%@", TSLAPI_PREFIX, TSLAPI_DistributionStation] parameters:@{@"identifier":@(self.Identifier)} success:^(id json) {
            NSArray *infoArray = [TSLDistributionStationInfo objectArrayWithKeyValuesArray:json];
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
- (void)loadInfo:(TSLDistributionStationInfo *)info
{
    [self.NameCHN setTitle:info.Company forState:UIControlStateNormal];
    self.WHAddress.text = info.Address;
    self.WHArea.text = info.DistrictName;
    self.Person.text = info.Compellation;
    self.PersonTel.text = info.PersonTelString;
    self.ReleaseTime.text = info.CreateDate;
    self.telphoneView.telString = info.PersonTelString;
    self.DestinationCoordinate = (CLLocationCoordinate2D){[info.BDPixelY doubleValue], [info.BDPixelX doubleValue]};
}

#pragma mark - TSLTelphoneView delegate

- (TSLCollectionParam *)collectionParam
{
    TSLDistributionStationInfo *info = (TSLDistributionStationInfo *)self.info;
    TSLCollectionParam *param = [[TSLCollectionParam alloc] init];
    param.userId = [TSLUser sharedUser].Identifier;
    param.LogisticsId = info.Identifier;
    param.TheState = 1;
    param.LogisticsType = 2;
    return param;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
