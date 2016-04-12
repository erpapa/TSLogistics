//
//  TSLDistributionCenterDetailVC.m
//  TSLogistics
//
//  Created by erpapa on 15/12/30.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLDistributionCenterDetailVC.h"
#import "TSLDistributionCenterInfo.h"

@interface TSLDistributionCenterDetailVC ()
@property (strong, nonatomic) UIButton *NameCHN;
@property (strong, nonatomic) TSLCollectView *collectView;
@property (strong, nonatomic) UILabel *DCRegionName;
@property (strong, nonatomic) UILabel *ServerType;
@property (strong, nonatomic) UILabel *KehuCount;
@property (strong, nonatomic) UILabel *ServerRegion;
@property (strong, nonatomic) UILabel *DCAddress;
@property (strong, nonatomic) UILabel *CompanyName;
@property (strong, nonatomic) UILabel *Person;
@property (strong, nonatomic) UILabel *PersonTel;
@property (strong, nonatomic) UILabel *ReleaseTime;
@property (strong, nonatomic) TSLTelphoneView *telphoneView;
@end

@implementation TSLDistributionCenterDetailVC

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
    self.collectView = [[TSLCollectView alloc] initWithFrame:CGRectMake(lineWidth - kHeight, 0, kHeight, kHeight)];
    self.collectView.delegate = self;
    UIView *bgView1 = [[UIView alloc] initWithFrame:CGRectMake(kBorderX, kBorderHeight, lineWidth, kHeight)];
    bgView1.backgroundColor = [UIColor whiteColor];
    [bgView1 addSubview:self.NameCHN];
    [bgView1 addSubview:self.collectView];
    [scrollView addSubview:bgView1];
    
    // 2.1.配送信息
    UIButton *WHInfo = [self buttonWithTitle:@"配送信息" image:@"peisongImage"];
    // 2.2.分割线
    UIView *line2 = [self lineWithOrigin:CGPointMake(0, kHeight)];
    // 2.3.所属区域
    UILabel *DCRegionNameLabel = [self labelWithTitle:@"所属区域:" origin:CGPointMake(leftLabelX, kHeight + 1)];
    self.DCRegionName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(DCRegionNameLabel.frame), CGRectGetMinY(DCRegionNameLabel.frame), lineWidth * 0.5 - CGRectGetMaxX(DCRegionNameLabel.frame), kHeight)];
    // 2.4.类别
    UILabel *ServerTypeLabel = [self labelWithTitle:@"类别:" origin:CGPointMake(lineWidth * 0.5, kHeight + 1)];
    self.ServerType = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(ServerTypeLabel.frame), CGRectGetMinY(ServerTypeLabel.frame), lineWidth - CGRectGetMaxX(ServerTypeLabel.frame), kHeight)];
    // 2.5.客户数量
    UILabel *KehuCountLabel = [self labelWithTitle:@"客户数量:" origin:CGPointMake(leftLabelX, kHeight * 2 + 1)];
    self.KehuCount = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(KehuCountLabel.frame), CGRectGetMinY(KehuCountLabel.frame), lineWidth - CGRectGetMaxX(KehuCountLabel.frame), kHeight)];
    // 2.6.服务区域
    UILabel *ServerRegionLabel = [self labelWithTitle:@"服务区域:" origin:CGPointMake(leftLabelX, kHeight * 3 + 1)];
    self.ServerRegion = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(ServerRegionLabel.frame), CGRectGetMinY(ServerRegionLabel.frame), lineWidth - CGRectGetMaxX(ServerRegionLabel.frame), kHeight)];
    // 2.7.详细地址
    UILabel *DCAddressLabel = [self labelWithTitle:@"详细地址:" origin:CGPointMake(leftLabelX, kHeight * 4 + 1)];
    self.DCAddress = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(DCAddressLabel.frame), CGRectGetMinY(DCAddressLabel.frame), lineWidth - CGRectGetMaxX(DCAddressLabel.frame), kHeight)];
    
    UIView *bgView2 = [[UIView alloc] initWithFrame:CGRectMake(kBorderX, CGRectGetMaxY(bgView1.frame) + kBorderHeight, lineWidth, CGRectGetMaxY(DCAddressLabel.frame))];
    bgView2.backgroundColor = [UIColor whiteColor];
    [bgView2 addSubview:WHInfo];
    [bgView2 addSubview:line2];
    [bgView2 addSubview:DCRegionNameLabel];
    [bgView2 addSubview:self.DCRegionName];
    [bgView2 addSubview:ServerTypeLabel];
    [bgView2 addSubview:self.ServerType];
    [bgView2 addSubview:KehuCountLabel];
    [bgView2 addSubview:self.KehuCount];
    [bgView2 addSubview:ServerRegionLabel];
    [bgView2 addSubview:self.ServerRegion];
    [bgView2 addSubview:DCAddressLabel];
    [bgView2 addSubview:self.DCAddress];
    [scrollView addSubview:bgView2];
    
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
    
    UIView *bgView3 = [[UIView alloc] initWithFrame:CGRectMake(kBorderX, CGRectGetMaxY(bgView2.frame) + kBorderHeight, lineWidth, kHeight * 3 + 1)];
    bgView3.backgroundColor = [UIColor whiteColor];
    [bgView3 addSubview:contact];
    [bgView3 addSubview:line4];
    [bgView3 addSubview:self.CompanyName];
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
        [TSLHttpTool POST:[NSString stringWithFormat:@"%@%@", TSLAPI_PREFIX, TSLAPI_DistributionCenter] parameters:@{@"identifier":@(self.Identifier)} success:^(id json) {
            NSArray *infoArray = [TSLDistributionCenterInfo objectArrayWithKeyValuesArray:json];
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
- (void)loadInfo:(TSLDistributionCenterInfo *)info
{
    [self.NameCHN setTitle:info.NameCHN forState:UIControlStateNormal];
    self.collectView.collected = [info.iscollected isEqualToString:@"1"] ? YES : NO;
    self.DCRegionName.text = info.DCRegionName;
    self.ServerType.text = info.ServerTypeString;
    self.KehuCount.text = [NSString stringWithFormat:@"%ld", info.KehuCount];
    self.ServerRegion.text = info.ServerRegion;
    self.DCAddress.text = info.DCAddress;
    self.CompanyName.text = info.CompanyName;
    self.Person.text = info.PersonString;
    self.PersonTel.text = info.PersonTelString;
    self.ReleaseTime.text = info.ReleaseTime;
    self.telphoneView.telString = info.PersonTelString;
    self.DestinationCoordinate = (CLLocationCoordinate2D){[info.MapY doubleValue], [info.MapX doubleValue]};
}

#pragma mark - TSLTelphoneView delegate

- (TSLCollectionParam *)collectionParam
{
    TSLDistributionCenterInfo *info = (TSLDistributionCenterInfo *)self.info;
    TSLCollectionParam *param = [[TSLCollectionParam alloc] init];
    param.userId = [TSLUser sharedUser].Identifier;
    param.LogisticsId = info.Identifier;
    param.TheState = info.TheState;
    param.LogisticsType = 3;
    return param;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
