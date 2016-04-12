//
//  TSLParkDetailVC.m
//  TSLogistics
//
//  Created by erpapa on 15/12/29.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLParkDetailVC.h"
#import "TSLParkInfo.h"

@interface TSLParkDetailVC ()
@property (strong, nonatomic) UIButton *NameCHN;
@property (strong, nonatomic) TSLCollectView *collectView;
@property (strong, nonatomic) UILabel *DistrictName;
@property (strong, nonatomic) UILabel *LPType;
@property (strong, nonatomic) UILabel *EnterprisesNum;
@property (strong, nonatomic) UILabel *ExistEnterprisesNum;
@property (strong, nonatomic) UILabel *LPArea;
@property (strong, nonatomic) UILabel *LPAreaRemaind;
@property (strong, nonatomic) UILabel *FSrange;
@property (strong, nonatomic) UILabel *xingban;
@property (strong, nonatomic) UILabel *CDArea;
@property (strong, nonatomic) UILabel *CCArea;
@property (strong, nonatomic) UILabel *Description;
@property (strong, nonatomic) UILabel *CompanyName;
@property (strong, nonatomic) UILabel *Person;
@property (strong, nonatomic) UILabel *PersonTel;
@property (strong, nonatomic) UILabel *LPAddress;
@property (strong, nonatomic) UILabel *ReleaseTime;
@property (strong, nonatomic) TSLTelphoneView *telphoneView;
@end

@implementation TSLParkDetailVC
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
    
    // 1.1.园区名
    self.NameCHN = [self buttonWithTitle:@"" image:@"dian"];
    self.NameCHN.frame = CGRectMake(0, 0, lineWidth - kHeight, kHeight);
    // 1.2 收藏
    self.collectView = [[TSLCollectView alloc] initWithFrame:CGRectMake(lineWidth - kHeight, 0, kHeight, kHeight)];
    self.collectView.delegate = self;
    UIView *bgView1 = [[UIView alloc] initWithFrame:CGRectMake(kBorderX, kBorderHeight, lineWidth, kHeight)];
    bgView1.backgroundColor = [UIColor whiteColor];
    [bgView1 addSubview:self.collectView];
    [bgView1 addSubview:self.NameCHN];
    [scrollView addSubview:bgView1];
    
    // 2.1.园区信息
    UIButton *WHInfo = [self buttonWithTitle:@"园区信息" image:@"yuanquImage"];
    // 2.2.分割线
    UIView *line2 = [self lineWithOrigin:CGPointMake(0, kHeight)];
    // 2.3.所属区域
    UILabel *DistrictNameLabel = [self labelWithTitle:@"所属区域:" origin:CGPointMake(leftLabelX, kHeight + 1)];
    self.DistrictName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(DistrictNameLabel.frame), kHeight + 1, lineWidth - CGRectGetMaxX(DistrictNameLabel.frame), kHeight)];
    // 2.4.功能类型
    UILabel *LPTypeLabel = [self labelWithTitle:@"功能类型:" origin:CGPointMake(leftLabelX, kHeight * 2 + 1)];
    self.LPType = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(LPTypeLabel.frame), kHeight * 2 + 1, lineWidth - CGRectGetMaxX(LPTypeLabel.frame), kHeight)];
    // 2.5.可入驻
    UILabel *EnterprisesNumLabel = [self labelWithTitle:@"可入驻:" origin:CGPointMake(leftLabelX, kHeight * 3 + 1)];
    self.EnterprisesNum = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(EnterprisesNumLabel.frame), kHeight * 3 + 1, lineWidth - CGRectGetMaxX(EnterprisesNumLabel.frame), kHeight)];
    // 2.6.已入驻
    UILabel *ExistEnterprisesNumLabel = [self labelWithTitle:@"已入驻:" origin:CGPointMake(leftLabelX, kHeight * 4 + 1)];
    self.ExistEnterprisesNum = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(ExistEnterprisesNumLabel.frame), kHeight * 4 + 1, lineWidth - CGRectGetMaxX(ExistEnterprisesNumLabel.frame), kHeight)];
    // 2.7.占地面积
    UILabel *LPAreaLabel = [self labelWithTitle:@"占地面积:" origin:CGPointMake(leftLabelX, kHeight * 5 + 1)];
    self.LPArea = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(LPAreaLabel.frame), kHeight * 5 + 1, rightlabelX - CGRectGetMaxX(LPAreaLabel.frame), kHeight)];
    // 2.8.闲置面积
    UILabel *LPAreaRemaindLabel = [self labelWithTitle:@"闲置面积:" origin:CGPointMake(rightlabelX, kHeight * 5 + 1)];
    self.LPAreaRemaind = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(LPAreaRemaindLabel.frame), kHeight * 5 + 1, lineWidth - CGRectGetMaxX(LPAreaRemaindLabel.frame), kHeight)];
    // 2.9.辐射范围
    UILabel *FSrangeLabel = [self labelWithTitle:@"辐射范围:" origin:CGPointMake(leftLabelX, kHeight * 6 + 1)];
    self.FSrange = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(FSrangeLabel.frame), kHeight * 6 + 1, lineWidth - CGRectGetMaxX(FSrangeLabel.frame), kHeight)];
    // 2.10.兴办主体
    UILabel *xingbanLabel = [self labelWithTitle:@"兴办主体:" origin:CGPointMake(leftLabelX, kHeight * 7 + 1)];
    self.xingban = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(xingbanLabel.frame), kHeight * 7 + 1, lineWidth - CGRectGetMaxX(xingbanLabel.frame), kHeight)];
    // 2.11.场地面积
    UILabel *CDAreaLabel = [self labelWithTitle:@"场地面积:" origin:CGPointMake(leftLabelX, kHeight * 8 + 1)];
    self.CDArea = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(CDAreaLabel.frame), kHeight * 8 + 1, rightlabelX - CGRectGetMaxX(CDAreaLabel.frame), kHeight)];
    // 2.12.仓储面积
    UILabel *CCAreaLabel = [self labelWithTitle:@"仓储面积:" origin:CGPointMake(rightlabelX, kHeight * 8 + 1)];
    self.CCArea = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(CCAreaLabel.frame), kHeight * 8 + 1, lineWidth - CGRectGetMaxX(CCAreaLabel.frame), kHeight)];
    
    UIView *bgView2 = [[UIView alloc] initWithFrame:CGRectMake(kBorderX, CGRectGetMaxY(bgView1.frame) + kBorderHeight, lineWidth, kHeight * 9 + 1)];
    bgView2.backgroundColor = [UIColor whiteColor];
    [bgView2 addSubview:WHInfo];
    [bgView2 addSubview:line2];
    [bgView2 addSubview:DistrictNameLabel];
    [bgView2 addSubview:self.DistrictName];
    [bgView2 addSubview:LPTypeLabel];
    [bgView2 addSubview:self.LPType];
    [bgView2 addSubview:LPTypeLabel];
    [bgView2 addSubview:self.LPType];
    [bgView2 addSubview:EnterprisesNumLabel];
    [bgView2 addSubview:self.EnterprisesNum];
    [bgView2 addSubview:ExistEnterprisesNumLabel];
    [bgView2 addSubview:self.ExistEnterprisesNum];
    [bgView2 addSubview:LPAreaLabel];
    [bgView2 addSubview:self.LPArea];
    [bgView2 addSubview:LPAreaRemaindLabel];
    [bgView2 addSubview:self.LPAreaRemaind];
    [bgView2 addSubview:FSrangeLabel];
    [bgView2 addSubview:self.FSrange];
    [bgView2 addSubview:xingbanLabel];
    [bgView2 addSubview:self.xingban];
    [bgView2 addSubview:CDAreaLabel];
    [bgView2 addSubview:self.CDArea];
    [bgView2 addSubview:CCAreaLabel];
    [bgView2 addSubview:self.CCArea];
    [scrollView addSubview:bgView2];
    
    // 3.1.园区描述
    UIButton *DescriptionButton = [self buttonWithTitle:@"园区描述" image:@"goodsImage"];
    // 3.2.分割线
    UIView *line3 = [self lineWithOrigin:CGPointMake(0, kHeight)];
    self.Description = [[UILabel alloc] initWithFrame:CGRectMake(leftLabelX, kHeight + 1, lineWidth - leftLabelX * 2, kHeight * 3.5)];
    self.Description.numberOfLines = 0;
    UIView *bgView3 = [[UIView alloc] initWithFrame:CGRectMake(kBorderX, CGRectGetMaxY(bgView2.frame) + kBorderHeight, lineWidth, kHeight * 4.5 + 1)];
    bgView3.backgroundColor = [UIColor whiteColor];
    [bgView3 addSubview:DescriptionButton];
    [bgView3 addSubview:line3];
    [bgView3 addSubview:self.Description];
    [scrollView addSubview:bgView3];
    
    // 4.1.联系方式
    UIButton *contact = [self buttonWithTitle:@"联系方式" image:@"ruzhu2"];
    // 4.2.分割线
    UIView *line4 = [self lineWithOrigin:CGPointMake(0, kHeight)];
    // 4.3.公司名
    self.CompanyName = [[UILabel alloc] initWithFrame:CGRectMake(leftLabelX, kHeight + 1, lineWidth - leftLabelX * 2, kHeight)];
    // 4.4.人名
    self.Person = [[UILabel alloc] initWithFrame:CGRectMake(leftLabelX, kHeight * 2 + 1, lineWidth * 0.5, kHeight)];
    // 4.5.联系电话
    self.PersonTel = [[UILabel alloc] initWithFrame:CGRectMake(rightlabelX, kHeight * 2 + 1, lineWidth - rightlabelX, kHeight)];
    // 4.6 地址
    UILabel *LPAddresssLabel = [self labelWithTitle:@"地址:" origin:CGPointMake(leftLabelX, kHeight * 3 + 1)];
    LPAddresssLabel.textColor = [UIColor blackColor];
    self.LPAddress = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(LPAddresssLabel.frame), kHeight * 3 + 1, lineWidth - CGRectGetMaxX(LPAddresssLabel.frame), kHeight)];
    UIView *bgView4 = [[UIView alloc] initWithFrame:CGRectMake(kBorderX, CGRectGetMaxY(bgView3.frame) + kBorderHeight, lineWidth, kHeight * 4 + 1)];
    bgView4.backgroundColor = [UIColor whiteColor];
    [bgView4 addSubview:contact];
    [bgView4 addSubview:line4];
    [bgView4 addSubview:self.CompanyName];
    [bgView4 addSubview:self.Person];
    [bgView4 addSubview:self.PersonTel];
    [bgView4 addSubview:LPAddresssLabel];
    [bgView4 addSubview:self.LPAddress];
    [scrollView addSubview:bgView4];
    
    // 5.1.时间
    UIButton *time = [self buttonWithTitle:@"发布日期" image:@"timeImage"];
    self.ReleaseTime = [[UILabel alloc] initWithFrame:CGRectMake(lineWidth * 0.6 - leftLabelX, 0, lineWidth * 0.4, kHeight)];
    self.ReleaseTime.textAlignment = NSTextAlignmentRight;
    
    UIView *bgView5 = [[UIView alloc] initWithFrame:CGRectMake(kBorderX, CGRectGetMaxY(bgView4.frame) + kBorderHeight, lineWidth, kHeight)];
    bgView5.backgroundColor = [UIColor whiteColor];
    [bgView5 addSubview:time];
    [bgView5 addSubview:self.ReleaseTime];
    [scrollView addSubview:bgView5];

    // 6.1 通讯录
    self.telphoneView = [[TSLTelphoneView alloc] initWithFrame:CGRectMake(0, ScreenH - 50, ScreenW, 50)];
    self.telphoneView.backgroundColor = TSLBackgroundColor;
    self.telphoneView.delegate = self;
    [self.view addSubview:self.telphoneView];
    scrollView.contentSize = CGSizeMake(ScreenW, CGRectGetMaxY(bgView5.frame) + self.telphoneView.bounds.size.height);
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
        [TSLHttpTool POST:[NSString stringWithFormat:@"%@%@", TSLAPI_PREFIX, TSLAPI_Park] parameters:param success:^(id json) {
            NSArray *infoArray = [TSLParkInfo objectArrayWithKeyValuesArray:json];
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
- (void)loadInfo:(TSLParkInfo *)info
{
    [self.NameCHN setTitle:info.NameCHN forState:UIControlStateNormal];
    self.collectView.collected = [info.iscollected isEqualToString:@"1"] ? YES : NO;
    self.DistrictName.text = info.DistrictName;
    self.LPType.text = info.LPTypeString;
    self.EnterprisesNum.text = [NSString stringWithFormat:@"%ld家",info.EnterprisesNum];
    self.ExistEnterprisesNum.text = [NSString stringWithFormat:@"%ld家",info.ExistEnterprisesNum];
    self.LPArea.text = [NSString stringWithFormat:@"%g亩", info.LPArea];
    self.LPAreaRemaind.text = [NSString stringWithFormat:@"%g亩", info.LPAreaRemaind];
    self.FSrange.text = info.FSrange;
    self.xingban.text = info.xingban;
    self.CDArea.text = [NSString stringWithFormat:@"%g亩", info.CDArea];
    self.CCArea.text = [NSString stringWithFormat:@"%gm²", info.CCArea];
    self.Description.text = info.Description;
    self.CompanyName.text = info.CompanyName;
    self.Person.text = info.PersonString;
    self.PersonTel.text = info.PersonTelString;
    self.LPAddress.text = info.LPAddress;
    self.ReleaseTime.text = info.ReleaseTime;
    self.telphoneView.telString = info.PersonTelString;
    self.DestinationCoordinate = (CLLocationCoordinate2D){[info.MapY doubleValue], [info.MapX doubleValue]};
}

#pragma mark - TSLTelphoneView delegate

- (void)collectView:(TSLCollectView *)collectView didCollected:(BOOL)success
{
    if (success) { // 收藏成功，置1
        TSLParkInfo *info = (TSLParkInfo *)self.info;
        info.iscollected = @"1";
    }
}

- (TSLCollectionParam *)collectionParam
{
    TSLParkInfo *info = (TSLParkInfo *)self.info;
    TSLCollectionParam *param = [[TSLCollectionParam alloc] init];
    param.userId = [TSLUser sharedUser].Identifier;
    param.LogisticsId = info.Identifier;
    param.TheState = info.TheState;
    param.LogisticsType = 6;
    return param;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
