//
//  TSLViewController.m
//  TSLogistics
//
//  Created by erpapa on 15/11/11.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLOptionController.h"
#import "TSLOptionButton.h"
#import "TSLCollectionViewCell.h"
#import "TSLGoodsSourceVC.h"
#import "TSLVehicleSourceVC.h"
#import "TSLWarehouseVC.h"
#import "TSLInformationRecommendVC.h"
#import "TSLInformationRecommendDetailVC.h"
#import "TSLRecommendCell.h"
#import "TSLPublishView.h"
#import "TSLHttpTool.h"
#import "MJExtension.h"

static NSString *reuseID = @"Collection";
@interface TSLOptionController ()<UICollectionViewDataSource, UICollectionViewDelegate,UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *modules;
@property (strong, nonatomic) NSArray *recommendArray;
@end

@implementation TSLOptionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.backgroundColor = TSLBackgroundColor;
    [self.view addSubview:self.scrollView];
    [self setupTopView];
    [self setupCollectionView];
    [self setupTableView];
    self.scrollView.contentSize = CGSizeMake(ScreenW, CGRectGetMaxY(self.tableView.frame));
}

- (void)setupTopView
{
    self.topView = [[UIView alloc] init];
    CGFloat x = 15;
    CGFloat y = 0;
    CGFloat width = (ScreenW - x * 2) / 3;
    CGFloat height = width + 20;
    TSLOptionButton *button0 = [TSLOptionButton buttonWithTitle:@"找货源" image:@"forGoodsImage" addTarget:self action:@selector(searchGoods:)];
    button0.frame = CGRectMake(x, y, width, height);
    TSLOptionButton *button1 = [TSLOptionButton buttonWithTitle:@"找车源" image:@"forCarImage" addTarget:self action:@selector(searchCar:)];
    button1.frame = CGRectMake(x + width, y, width, height);
    TSLOptionButton *button2 = [TSLOptionButton buttonWithTitle:@"找库源" image:@"forWarehouseImage" addTarget:self action:@selector(searchWarehouse:)];
    button2.frame = CGRectMake(x + width * 2, y, width, height);
    [self.topView addSubview:button0];
    [self.topView addSubview:button1];
    [self.topView addSubview:button2];
    // 添加到scrollView上
    self.topView.backgroundColor = [UIColor whiteColor];
    self.topView.frame = CGRectMake(0, 0, ScreenW, CGRectGetMaxY(button0.frame));
    [self.scrollView addSubview:self.topView];
}

- (void)setupCollectionView
{
    // 标题栏
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame) + 8, ScreenW, 30)];
    view.backgroundColor = [UIColor whiteColor];
    CGFloat labelWidth = ScreenW / 4;
    UILabel *label0 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth, 30)];
    label0.text = @"车辆服务";
    label0.textAlignment = NSTextAlignmentCenter;
    label0.textColor = [UIColor orangeColor];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(labelWidth, 0, labelWidth, 30)];
    label1.text = @"货物服务";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = TSLColor(90, 116, 239);
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(labelWidth * 2, 0, labelWidth, 30)];
    label2.text = @"企业服务";
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor = TSLColor(252, 65, 68);
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(labelWidth * 3, 0, labelWidth, 30)];
    label3.text = @"综合服务";
    label3.textAlignment = NSTextAlignmentCenter;
    label3.textColor = TSLColor(64, 176, 224);
    [view addSubview:label0];
    [view addSubview:label1];
    [view addSubview:label2];
    [view addSubview:label3];
    [self.scrollView addSubview:view];
    
    
    // 1.流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 2.每个cell的尺寸
    layout.itemSize = CGSizeMake(ScreenW / 4, ScreenW / 4);
    // 3.设置cell之间的水平间距
    layout.minimumInteritemSpacing = 0;
    // 4.设置cell之间的垂直间距
    layout.minimumLineSpacing = 0;
    // 5.实例化collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame), ScreenW, ScreenW * 1.25) collectionViewLayout:layout];
    // 6.注册cell(告诉collectionView将来创建怎样的cell)
    [self.collectionView registerClass:[TSLCollectionViewCell class] forCellWithReuseIdentifier:reuseID];
    // 7.设置collectionView的背景色
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.scrollView addSubview:self.collectionView];
}

- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.collectionView.frame) + 8, ScreenW, 380)];
    self.tableView.rowHeight = RecommendCellHeight;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.scrollView addSubview:self.tableView];
    // 热点关注
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 30)];
    UIButton *hotBtn = [[UIButton alloc] initWithFrame:headerView.bounds];
    [hotBtn setTitle:@"热点关注" forState:UIControlStateNormal];
    hotBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    hotBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    hotBtn.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
    [hotBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [hotBtn addTarget:self action:@selector(hotBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW - 22, 8, 14, 14)];
    imgView.image = [UIImage imageNamed:@"arrow"];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(8, 29, ScreenW - 16, 1)];
    line.backgroundColor = [UIColor orangeColor];

    [headerView addSubview:imgView];
    [headerView addSubview:line];
    [headerView addSubview:hotBtn];
    self.tableView.tableHeaderView = headerView;
    
    // 发起GET请求
    [TSLHttpTool GET:[NSString stringWithFormat:@"%@%@", TSLAPI_PREFIX, TSLAPI_RECOMMEND] parameters:@{@"pageSize":@5} success:^(id json) {
        NSArray *array = [TSLRecommendInfo objectArrayWithKeyValuesArray:json];
        if (array.count > 0) {
            self.recommendArray = array;
            [self.tableView reloadData];
            // 归档保存
            [NSKeyedArchiver archiveRootObject:self.recommendArray toFile:TSLRecommendPath];
        }
    } failure:^(NSError *error) {}];
}

#pragma mark - collectionView数据源方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.获得cell
    TSLCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    // 2.传递图片名
    NSDictionary *dict = self.modules[indexPath.item];
    NSString *imageString = [dict objectForKey:@"image"];
    cell.image = imageString;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSDictionary *dict = self.modules[indexPath.item];
    NSString *classString = [dict objectForKey:@"destVC"];
    if (classString.length) {
        UIViewController *destVC = [NSClassFromString(classString) new];
        destVC.title = [dict objectForKey:@"name"];
        [self.navigationController pushViewController:destVC animated:YES];
    }
}



#pragma mark - tableView数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recommendArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSLRecommendCell * cell = [TSLRecommendCell cellWithTableView:tableView];
    cell.info = self.recommendArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TSLInformationRecommendDetailVC *vc = [[TSLInformationRecommendDetailVC alloc] init];
    vc.info = self.recommendArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
/**
 *  搜索
 */
- (IBAction)search:(UIButton *)sender {
    
    
}
- (IBAction)say:(UIBarButtonItem *)sender {
    UIView *view = [self.view viewWithTag:101];
    if (view == nil) {
        TSLPublishView *publish = [[TSLPublishView alloc] initWithFrame:self.view.bounds];
        publish.tag = 101;
        publish.bottom = 64;
        [self.view addSubview:publish];
    } else {
        [view removeFromSuperview];
    }
}

/**
 *  找货源
 */
- (void)searchGoods:(TSLOptionButton *)sender
{
    TSLGoodsSourceVC *goodsSourceVC = [[TSLGoodsSourceVC alloc] init];
    goodsSourceVC.title = sender.currentTitle;
    [self.navigationController pushViewController:goodsSourceVC animated:YES];
}
/**
 *  找车源
 */
- (void)searchCar:(TSLOptionButton *)sender
{
    TSLVehicleSourceVC *vehicleSourceVC = [[TSLVehicleSourceVC alloc] init];
    vehicleSourceVC.title = sender.currentTitle;
    [self.navigationController pushViewController:vehicleSourceVC animated:YES];
}
/**
 *  找库源
 */
- (void)searchWarehouse:(TSLOptionButton *)sender
{
    TSLWarehouseVC *warehouseVC = [[TSLWarehouseVC alloc] init];
    warehouseVC.title = sender.currentTitle;
    [self.navigationController pushViewController:warehouseVC animated:YES];
}
/**
 *  热点关注
 */
- (void)hotBtnClick
{
    TSLInformationRecommendVC *infoVC = [[TSLInformationRecommendVC alloc] init];
    [self.navigationController pushViewController:infoVC animated:YES];
}

- (NSArray *)modules
{
    if (_modules == nil) {
        _modules = [[NSArray alloc] initWithObjects:
                         @{@"name":@"找配货站",
                           @"image":@"forphzImage",
                           @"destVC":@"TSLDistributionStationVC"
                           },
                         @{@"name":@"找物流专线",
                           @"image":@"forLineImage",
                           @"destVC":@"TSLRailwayVC"
                           },
                         @{@"name":@"找园区",
                           @"image":@"forParkImage",
                           @"destVC":@"TSLParkVC"
                           },
                         @{@"name":@"找资讯",
                           @"image":@"forinformationImage",
                           @"destVC":@"TSLInformationController"
                           },
                         @{@"name":@"找加油站",
                           @"image":@"forGasstation",
                           @"destVC":@"TSLExampleViewController"
                           },
                         @{@"name":@"找物流企业",
                           @"image":@"forenterpriseImage",
                           @"destVC":@"TSLExampleViewController"
                           },
                         @{@"name":@"找设备",
                           @"image":@"forequipmentImage",
                           @"destVC":@"TSLExampleViewController"
                           },
                         @{@"name":@"找运价",
                           @"image":@"forfreightImahe",
                           @"destVC":@"TSLExampleViewController"
                           },
                         @{@"name":@"找加气站",
                           @"image":@"forLPGstationsImage",
                           @"destVC":@"TSLExampleViewController"
                           },
                         @{@"name":@"找配送中心",
                           @"image":@"forDistributionCenterImage",
                           @"destVC":@"TSLDistributionCenterVC"
                           },
                         @{@"name":@"找金融",
                           @"image":@"forfinancialImage",
                           @"destVC":@"TSLExampleViewController"
                           },
                         @{@"name":@"找统计",
                           @"image":@"forstatisticalImage",
                           @"destVC":@"TSLExampleViewController"
                           },
                         @{@"name":@"找维修站",
                           @"image":@"forPitImage",
                           @"destVC":@"TSLExampleViewController"
                           },
                         @{@"name":@"找快递网点",
                           @"image":@"forCourierImage",
                           @"destVC":@"TSLExpressStationVC"
                           },
                         @{@"name":@"找人才",
                           @"image":@"fortalentImage",
                           @"destVC":@"TSLExampleViewController"
                           },
                         @{@"name":@"找招聘",
                           @"image":@"forRecruitmentImage",
                           @"destVC":@"TSLExampleViewController"
                           },
                         @{@"name":@"",@"image":@"---",@"destVC":@""},
                         @{@"name":@"找末端网点",
                           @"image":@"forMDWDImage",
                           @"destVC":@"TSLWlTerminalVC"
                           },
                         @{@"name":@"找专家",
                           @"image":@"forExpertsImage",
                           @"destVC":@"TSLExampleViewController"
                           },
                         @{@"name":@"",@"image":@"---",@"destVC":@""},
                         nil];
    }
    return _modules;
}

- (NSArray *)recommendArray
{
    if (_recommendArray == nil) {
        // 1.从文件中读取联系人数据
        _recommendArray = [NSKeyedUnarchiver unarchiveObjectWithFile:TSLRecommendPath];
        
        // 2.如果数组为nil
        if (_recommendArray == nil) { // 文件不存在
            _recommendArray = [NSArray array];
        }
    }
    return _recommendArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
