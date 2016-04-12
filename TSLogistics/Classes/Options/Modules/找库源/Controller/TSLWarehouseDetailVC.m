//
//  TSLWarehouseDetailVC.m
//  TSLogistics
//
//  Created by erpapa on 15/11/17.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLWarehouseDetailVC.h"
#import "TSLWarehouseInfo.h"

@interface TSLWarehouseDetailVC ()
@property (strong, nonatomic) UIButton *NameCHN;
@property (strong, nonatomic) TSLCollectView *collectView;
@property (strong, nonatomic) UILabel *WHType;
@property (strong, nonatomic) UILabel *WHAddress;
@property (strong, nonatomic) UILabel *WHArea;
@property (strong, nonatomic) UILabel *WHAreaRemaind;
@property (strong, nonatomic) UILabel *WHArealeast;
@property (strong, nonatomic) UILabel *Price;
@property (strong, nonatomic) UILabel *CompanyName;
@property (strong, nonatomic) UILabel *Person;
@property (strong, nonatomic) UILabel *PersonTel;
@property (strong, nonatomic) UILabel *ReleaseTime;
@property (strong, nonatomic) TSLTelphoneView *telphoneView;
@end

@implementation TSLWarehouseDetailVC
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
    [bgView1 addSubview:self.collectView];
    [bgView1 addSubview:self.NameCHN];
    [scrollView addSubview:bgView1];
    
    // 2.1.基本信息
    UIButton *WHInfo = [self buttonWithTitle:@"基本信息" image:@"cangkuImage"];
    // 2.2.分割线
    UIView *line2 = [self lineWithOrigin:CGPointMake(0, kHeight)];
    // 2.3.仓储类型
    UILabel *WHTypeLabel = [self labelWithTitle:@"仓储类型:" origin:CGPointMake(leftLabelX, kHeight + 1)];
    self.WHType = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(WHTypeLabel.frame), kHeight + 1, lineWidth - CGRectGetMaxX(WHTypeLabel.frame), kHeight)];
    // 2.4.详细地址
    UILabel *WHAddressLabel = [self labelWithTitle:@"详细地址:" origin:CGPointMake(leftLabelX, kHeight * 2 + 1)];
    self.WHAddress = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(WHAddressLabel.frame), kHeight * 2 + 1, lineWidth - CGRectGetMaxX(WHAddressLabel.frame), kHeight)];
    UIView *bgView2 = [[UIView alloc] initWithFrame:CGRectMake(kBorderX, CGRectGetMaxY(bgView1.frame) + kBorderHeight, lineWidth, kHeight * 3 + 1)];
    bgView2.backgroundColor = [UIColor whiteColor];
    [bgView2 addSubview:WHInfo];
    [bgView2 addSubview:line2];
    [bgView2 addSubview:WHTypeLabel];
    [bgView2 addSubview:self.WHType];
    [bgView2 addSubview:WHAddressLabel];
    [bgView2 addSubview:self.WHAddress];
    [scrollView addSubview:bgView2];
    
    // 3.1.面积租金
    UIButton *goodsSource = [self buttonWithTitle:@"面积租金" image:@"goodsImage"];
    // 3.2.分割线
    UIView *line3 = [self lineWithOrigin:CGPointMake(0, kHeight)];
    // 3.3.仓储面积
    UILabel *WHAreaLabel = [self labelWithTitle:@"仓储面积:" origin:CGPointMake(leftLabelX,kHeight + 1)];
    self.WHArea = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(WHAreaLabel.frame), kHeight + 1, rightlabelX - CGRectGetMaxX(WHAreaLabel.frame), kHeight)];
    // 3.4.闲置待用
    UILabel *WHAreaRemaindLabel = [self labelWithTitle:@"闲置待用:" origin:CGPointMake(rightlabelX, kHeight + 1)];
    self.WHAreaRemaind = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(WHAreaRemaindLabel.frame), kHeight + 1, lineWidth - CGRectGetMaxX(WHAreaRemaindLabel.frame), kHeight)];
    // 3.5.起租面积
    UILabel *WHArealeastLabel = [self labelWithTitle:@"起租面积:" origin:CGPointMake(leftLabelX, kHeight * 2 + 1)];
    self.WHArealeast = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(WHArealeastLabel.frame), kHeight * 2 + 1, rightlabelX - CGRectGetMaxX(WHArealeastLabel.frame), kHeight)];
    // 3.6.租金价格
    UILabel *PriceLabel = [self labelWithTitle:@"租金价格:" origin:CGPointMake(leftLabelX, kHeight * 3 + 1)];
    self.Price = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(PriceLabel.frame), kHeight * 3 + 1, lineWidth - CGRectGetMaxX(PriceLabel.frame), kHeight)];
    
    
    UIView *bgView3 = [[UIView alloc] initWithFrame:CGRectMake(kBorderX, CGRectGetMaxY(bgView2.frame) + kBorderHeight, lineWidth, kHeight * 4 + 1)];
    bgView3.backgroundColor = [UIColor whiteColor];
    [bgView3 addSubview:goodsSource];
    [bgView3 addSubview:line3];
    [bgView3 addSubview:WHAreaLabel];
    [bgView3 addSubview:self.WHArea];
    [bgView3 addSubview:WHAreaRemaindLabel];
    [bgView3 addSubview:self.WHAreaRemaind];
    [bgView3 addSubview:WHArealeastLabel];
    [bgView3 addSubview:self.WHArealeast];
    [bgView3 addSubview:PriceLabel];
    [bgView3 addSubview:self.Price];
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
    self.PersonTel = [[UILabel alloc] initWithFrame:CGRectMake(lineWidth * 0.6 - leftLabelX, kHeight * 2 + 1, lineWidth * 0.4, kHeight)];
    self.PersonTel.textAlignment = NSTextAlignmentRight;
    
    UIView *bgView4 = [[UIView alloc] initWithFrame:CGRectMake(kBorderX, CGRectGetMaxY(bgView3.frame) + kBorderHeight, lineWidth, kHeight * 3 + 1)];
    bgView4.backgroundColor = [UIColor whiteColor];
    [bgView4 addSubview:contact];
    [bgView4 addSubview:line4];
    [bgView4 addSubview:self.CompanyName];
    [bgView4 addSubview:self.Person];
    [bgView4 addSubview:self.PersonTel];
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
        [TSLHttpTool POST:[NSString stringWithFormat:@"%@%@", TSLAPI_PREFIX, TSLAPI_Warehouse] parameters:param success:^(id json) {
            NSArray *infoArray = [TSLWarehouseInfo objectArrayWithKeyValuesArray:json];
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
- (void)loadInfo:(TSLWarehouseInfo *)info
{
    [self.NameCHN setTitle:info.NameCHN forState:UIControlStateNormal];
    self.collectView.collected = [info.iscollected isEqualToString:@"1"] ? YES : NO;
    self.WHType.text = info.WHTypeString;
    self.WHAddress.text = info.WHAddress;
    self.WHArea.text = [NSString stringWithFormat:@"%gm²",info.WHArea];
    self.WHAreaRemaind.text = [NSString stringWithFormat:@"%gm²",info.WHAreaRemaind];
    self.WHArealeast.text = [NSString stringWithFormat:@"%gm²",info.WHArealeast];
    self.Price.text = info.PriceString;
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
        TSLWarehouseInfo *info = (TSLWarehouseInfo *)self.info;
        info.iscollected = @"1";
    }
}

- (TSLCollectionParam *)collectionParam
{
    TSLWarehouseInfo *info = (TSLWarehouseInfo *)self.info;
    TSLCollectionParam *param = [[TSLCollectionParam alloc] init];
    param.userId = [TSLUser sharedUser].Identifier;
    param.LogisticsId = info.Identifier;
    param.TheState = info.TheState;
    param.LogisticsType = 2;
    return param;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
