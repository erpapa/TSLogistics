//
//  TSLExpressStationDetailVC.m
//  TSLogistics
//
//  Created by erpapa on 15/12/31.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLExpressStationDetailVC.h"
#import "TSLExpressStationInfo.h"

@interface TSLExpressStationDetailVC ()
@property (strong, nonatomic) UIButton *NameCHN;
@property (strong, nonatomic) TSLCollectView *collectView;
@property (strong, nonatomic) UILabel *ShangMen;
@property (strong, nonatomic) UILabel *ESRegionName;
@property (strong, nonatomic) UILabel *ESType;
@property (strong, nonatomic) UILabel *ESCompany;
@property (strong, nonatomic) UILabel *ESScope;
@property (strong, nonatomic) UILabel *ESAddress;
@property (strong, nonatomic) UILabel *CompanyName;
@property (strong, nonatomic) UILabel *Person;
@property (strong, nonatomic) UILabel *PersonTel;
@property (strong, nonatomic) UILabel *ReleaseTime;
@property (strong, nonatomic) TSLTelphoneView *telphoneView;
@end

@implementation TSLExpressStationDetailVC

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
    CGFloat rightlabelX = lineWidth * 0.5 + leftLabelX;

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
    UIButton *WHInfo = [self buttonWithTitle:@"快递网点信息" image:@"kuaidiImage"];
    // 2.2.分割线
    UIView *line2 = [self lineWithOrigin:CGPointMake(0, kHeight)];
    // 2.3.上门取件
    UILabel *ShangMenLabel = [self labelWithTitle:@"上门取件:" origin:CGPointMake(leftLabelX, kHeight + 1)];
    self.ShangMen = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(ShangMenLabel.frame), kHeight + 1, rightlabelX - CGRectGetMaxX(ShangMenLabel.frame), kHeight)];
    // 2.4.所属区域
    UILabel *ESRegionNameLabel = [self labelWithTitle:@"所属区域:" origin:CGPointMake(rightlabelX, kHeight + 1)];
    self.ESRegionName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(ESRegionNameLabel.frame), kHeight + 1, lineWidth - CGRectGetMaxX(ESRegionNameLabel.frame), kHeight)];
    // 2.5.网点类别
    UILabel *ESTypeLabel = [self labelWithTitle:@"网点类别:" origin:CGPointMake(leftLabelX, kHeight * 2 + 1)];
    self.ESType = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(ESTypeLabel.frame), kHeight * 2 + 1, rightlabelX - CGRectGetMaxX(ESTypeLabel.frame), kHeight)];
    // 2.6.所属公司
    UILabel *ESCompanyLabel = [self labelWithTitle:@"所属公司:" origin:CGPointMake(rightlabelX, kHeight * 2 + 1)];
    self.ESCompany = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(ESCompanyLabel.frame), kHeight * 2 + 1, lineWidth - CGRectGetMaxX(ESCompanyLabel.frame), kHeight)];
    // 2.7.服务范围
    UILabel *ESScopeLabel = [self labelWithTitle:@"服务范围:" origin:CGPointMake(leftLabelX, kHeight * 3 + 1)];
    self.ESScope = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(ESScopeLabel.frame), kHeight * 3 + 1, lineWidth - CGRectGetMaxX(ESScopeLabel.frame), kHeight)];
    // 2.8.网点地址
    UILabel *ESAddressLabel = [self labelWithTitle:@"网点地址:" origin:CGPointMake(leftLabelX, kHeight * 4 + 1)];
    self.ESAddress = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(ESAddressLabel.frame), kHeight * 4 + 1, lineWidth - CGRectGetMaxX(ESAddressLabel.frame), kHeight)];
    
    UIView *bgView2 = [[UIView alloc] initWithFrame:CGRectMake(kBorderX, CGRectGetMaxY(bgView1.frame) + kBorderHeight, lineWidth, kHeight * 5 + 1)];
    bgView2.backgroundColor = [UIColor whiteColor];
    [bgView2 addSubview:WHInfo];
    [bgView2 addSubview:line2];
    [bgView2 addSubview:ShangMenLabel];
    [bgView2 addSubview:self.ShangMen];
    [bgView2 addSubview:ESRegionNameLabel];
    [bgView2 addSubview:self.ESRegionName];
    [bgView2 addSubview:ESTypeLabel];
    [bgView2 addSubview:self.ESType];
    [bgView2 addSubview:ESCompanyLabel];
    [bgView2 addSubview:self.ESCompany];
    [bgView2 addSubview:ESScopeLabel];
    [bgView2 addSubview:self.ESScope];
    [bgView2 addSubview:ESAddressLabel];
    [bgView2 addSubview:self.ESAddress];
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
    self.PersonTel = [[UILabel alloc] initWithFrame:CGRectMake(leftLabelX, kHeight * 3 + 1, lineWidth * 0.5, kHeight)];

    UIView *bgView3 = [[UIView alloc] initWithFrame:CGRectMake(kBorderX, CGRectGetMaxY(bgView2.frame) + kBorderHeight, lineWidth, kHeight * 4 + 1)];
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
        [TSLHttpTool POST:[NSString stringWithFormat:@"%@%@", TSLAPI_PREFIX, TSLAPI_ExpressStation] parameters:@{@"identifier":@(self.Identifier)} success:^(id json) {
            NSArray *infoArray = [TSLExpressStationInfo objectArrayWithKeyValuesArray:json];
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
- (void)loadInfo:(TSLExpressStationInfo *)info
{
    [self.NameCHN setTitle:info.NameCHN forState:UIControlStateNormal];
    self.collectView.collected = [info.iscollected isEqualToString:@"1"] ? YES : NO;
    self.ShangMen.text = info.IsShangMen ? @"是" : @"否";
    self.ESRegionName.text = info.ESRegionName;
    self.ESType.text = info.ESTypeString;
    self.ESCompany.text = info.ESCompanyString;
    self.ESScope.text = info.ESScope;
    self.ESAddress.text = info.ESAddress;
    self.CompanyName.text = info.CompanyName;
    self.Person.text = info.PersonString;
    self.PersonTel.text = info.PersonTelString;
    self.ReleaseTime.text = info.ReleaseTime;
    self.telphoneView.telString = info.PersonTelString;
    self.DestinationCoordinate = (CLLocationCoordinate2D){[info.BDPixelY doubleValue], [info.BDPixelX doubleValue]};
}

#pragma mark - TSLTelphoneView delegate

- (TSLCollectionParam *)collectionParam
{
    TSLExpressStationInfo *info = (TSLExpressStationInfo *)self.info;
    TSLCollectionParam *param = [[TSLCollectionParam alloc] init];
    param.userId = [TSLUser sharedUser].Identifier;
    param.LogisticsId = info.Identifier;
    param.TheState = info.TheState;
    param.LogisticsType = 4;
    return param;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
