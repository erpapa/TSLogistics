//
//  TSLWlTerminalDetailVC.m
//  TSLogistics
//
//  Created by erpapa on 15/12/31.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLWlTerminalDetailVC.h"
#import "TSLWlTerminalInfo.h"

@interface TSLWlTerminalDetailVC ()
@property (strong, nonatomic) UIButton *NameCHN;
@property (strong, nonatomic) TSLCollectView *collectView;
@property (strong, nonatomic) UILabel *TypeId;
@property (strong, nonatomic) UILabel *TdRegionName;
@property (strong, nonatomic) UILabel *TdScope;
@property (strong, nonatomic) UILabel *TdAddress;
@property (strong, nonatomic) UILabel *CompanyName;
@property (strong, nonatomic) UILabel *Person;
@property (strong, nonatomic) UILabel *PersonTel;
@property (strong, nonatomic) UILabel *ReleaseTime;
@property (strong, nonatomic) UILabel *OtherRequire;
@property (strong, nonatomic) TSLTelphoneView *telphoneView;
@end

@implementation TSLWlTerminalDetailVC

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
    CGFloat rightlabelX = lineWidth * 0.5 + 24;

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
    UIButton *WHInfo = [self buttonWithTitle:@"末端网点信息" image:@"moduan"];
    // 2.2.分割线
    UIView *line2 = [self lineWithOrigin:CGPointMake(0, kHeight)];
    // 2.3.网点类型
    UILabel *TypeIdLabel = [self labelWithTitle:@"上门取件:" origin:CGPointMake(leftLabelX, kHeight + 1)];
    self.TypeId = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(TypeIdLabel.frame), kHeight + 1, rightlabelX - CGRectGetMaxX(TypeIdLabel.frame), kHeight)];
    // 2.4.所属区域
    UILabel *TdRegionNameLabel = [self labelWithTitle:@"所属区域:" origin:CGPointMake(rightlabelX, kHeight + 1)];
    self.TdRegionName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(TdRegionNameLabel.frame), kHeight + 1, lineWidth - CGRectGetMaxX(TdRegionNameLabel.frame), kHeight)];
    // 2.5.网点地址
    UILabel *TdScopeLabel = [self labelWithTitle:@"服务范围:" origin:CGPointMake(leftLabelX, kHeight * 3 + 1)];
    self.TdScope = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(TdScopeLabel.frame), kHeight * 3 + 1, lineWidth - CGRectGetMaxX(TdScopeLabel.frame), kHeight)];
    // 2.6.服务范围
    UILabel *TdAddressLabel = [self labelWithTitle:@"网点地址:" origin:CGPointMake(leftLabelX, kHeight * 2 + 1)];
    self.TdAddress = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(TdAddressLabel.frame), kHeight * 2 + 1, lineWidth - CGRectGetMaxX(TdAddressLabel.frame), kHeight)];
    
    UIView *bgView2 = [[UIView alloc] initWithFrame:CGRectMake(kBorderX, CGRectGetMaxY(bgView1.frame) + kBorderHeight, lineWidth, kHeight * 4 + 1)];
    bgView2.backgroundColor = [UIColor whiteColor];
    [bgView2 addSubview:WHInfo];
    [bgView2 addSubview:line2];
    [bgView2 addSubview:TypeIdLabel];
    [bgView2 addSubview:self.TypeId];
    [bgView2 addSubview:TdRegionNameLabel];
    [bgView2 addSubview:self.TdRegionName];
    [bgView2 addSubview:TdAddressLabel];
    [bgView2 addSubview:self.TdAddress];
    [bgView2 addSubview:TdScopeLabel];
    [bgView2 addSubview:self.TdScope];
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
    // 6.1.备注
    UIButton *require = [self buttonWithTitle:@"备注" image:@"beizhuImage"];
    UIView *line6 = [self lineWithOrigin:CGPointMake(0, kHeight)];
    self.OtherRequire = [[UILabel alloc] initWithFrame:CGRectMake(leftLabelX, kHeight + 1, lineWidth - 2 * leftLabelX, kHeight)];
    self.OtherRequire.numberOfLines = 0;
    UIView *requireView = [[UIView alloc] initWithFrame:CGRectMake(kBorderX, CGRectGetMaxY(bgView4.frame) + kBorderHeight, lineWidth, kHeight * 2 + 1)];
    requireView.backgroundColor = [UIColor whiteColor];
    [requireView addSubview:require];
    [requireView addSubview:line6];
    [requireView addSubview:self.OtherRequire];
    [scrollView addSubview:requireView];
    
    // 7.1 通讯录
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
        [TSLHttpTool POST:[NSString stringWithFormat:@"%@%@", TSLAPI_PREFIX, TSLAPI_Terminal] parameters:@{@"identifier":@(self.Identifier)} success:^(id json) {
            NSArray *infoArray = [TSLWlTerminalInfo objectArrayWithKeyValuesArray:json];
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
- (void)loadInfo:(TSLWlTerminalInfo *)info
{
    [self.NameCHN setTitle:info.NameCHN forState:UIControlStateNormal];
    self.collectView.collected = [info.iscollected isEqualToString:@"1"] ? YES : NO;
    self.TypeId.text = info.TypeIdString;
    self.TdRegionName.text = info.TdRegionName;
    self.TdAddress.text = info.TdAddress;
    self.TdScope.text = info.TdScope;
    self.CompanyName.text = info.CompanyName;
    self.Person.text = info.PersonString;
    self.PersonTel.text = info.PersonTelString;
    self.ReleaseTime.text = info.ReleaseTime;
    self.OtherRequire.text = info.Description;
    self.telphoneView.telString = info.PersonTelString;
    self.DestinationCoordinate = (CLLocationCoordinate2D){[info.MapY doubleValue], [info.MapX doubleValue]};
}

#pragma mark - TSLTelphoneView delegate

- (TSLCollectionParam *)collectionParam
{
    TSLWlTerminalInfo *info = (TSLWlTerminalInfo *)self.info;
    TSLCollectionParam *param = [[TSLCollectionParam alloc] init];
    param.userId = [TSLUser sharedUser].Identifier;
    param.LogisticsId = info.Identifier;
    param.TheState = info.TheState;
    param.LogisticsType = 25;
    return param;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
