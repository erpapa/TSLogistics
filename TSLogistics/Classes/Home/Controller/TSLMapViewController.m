//
//  ViewController.m
//  TSLogistics
//
//  Created by erpapa on 15/11/9.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLMapViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import "TSLBaseDetailViewController.h"
#import "TSLPublishView.h"
#import "TSLChooseView.h"
#import "TSLMapInfo.h"
#import "TSLPointAnnotation.h"
#import "TSLUtil.h"
#import "TSLTool.h"

@interface TSLMapViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate, TSLChooseViewDelegate>
@property (strong, nonatomic) BMKMapView *mapView;
@property (strong, nonatomic) BMKLocationService *locService;
@property (strong, nonatomic) TSLChooseView *chooseView;
@property (strong, nonatomic) NSArray *annotations;
@property (assign, nonatomic) CLLocationCoordinate2D userCoordinate;
@property (assign, nonatomic) CLLocationCoordinate2D currentCoordinate;
@property (assign, nonatomic) NSInteger annotationType;
@end

@implementation TSLMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMapView];
    [self setupUtilView];
}

- (IBAction)publish:(UIButton *)sender {
    TSLPublishView *publishView = [[TSLPublishView alloc] initWithFrame:self.view.bounds];
    // publishView.title = @"请按住，发布您的车源\n\n\n例如：13米半挂求路北到北京的货源";
    publishView.bottom = 64;
    [self.view addSubview:publishView];
}

-(void)setupMapView
{
    // 地图
    _mapView = [[BMKMapView alloc] initWithFrame:self.view.bounds];
    _mapView.showMapScaleBar = YES;
    _mapView.zoomLevel = 15.0;
    _mapView.showsUserLocation = YES;//显示定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    [self.view insertSubview:_mapView atIndex:0];
    
    // 定位
    _locService = [[BMKLocationService alloc] init];
}
/**
 *  回到定位点按钮以及左侧栏
 */
- (void)setupUtilView
{
    UIImage *image = [UIImage imageNamed:@"backCenter"];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 50, 94, image.size.width, image.size.height)];
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backToCenter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    self.chooseView = [[TSLChooseView alloc] initWithFrame:CGRectMake(-115, 94, 115, TSLChooseViewCellHeight * 10 + 2)];
    self.chooseView.delegate = self;
    [self.view addSubview:self.chooseView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
    self.locService.delegate = self;
    NSArray *annos = self.mapView.annotations;
    [self.mapView removeAnnotations:annos];// 清空标注
    [self.mapView addAnnotations:annos];// 添加标注
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil;
    self.locService.delegate = nil;
}
#pragma mark - TSLChooseViewDelegate
- (void)chooseView:(TSLChooseView *)chooseView didSelectedRowWithType:(NSInteger)type
{
    self.annotationType = type;
    NSMutableArray *annos = [NSMutableArray array];
    for (TSLPointAnnotation *anno in self.annotations) {
        if (type == 0) { // 如果为0；则是全部类型
            [annos addObjectsFromArray:self.annotations];
            break;// 结束循环
        } else if ([anno.MType integerValue] == type) {
            [annos addObject:anno];
        }
    }
    // 清空标注
    [self.mapView removeAnnotations:self.mapView.annotations];
    // 添加标注
    [self.mapView addAnnotations:annos];
}

#pragma mark - BMKLocationServiceDelegate
/**
 *  处理位置坐标更新
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    self.userCoordinate = userLocation.location.coordinate;
    // 地图显示定位信息
    [self.mapView updateLocationData:userLocation];
    [self.mapView setCenterCoordinate:self.userCoordinate animated:YES];
    [self GetAnnotationsWithCoordinate:self.userCoordinate];// 联网获得标注
    [self.locService stopUserLocationService];// 关闭定位服务
}
/**
 *  获取坐标失败
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    if (error.code == 1) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"定位服务已被禁用" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"立即启用" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark - BMKMapViewDelegate
/**
 *  地图初始化完毕时会调用此接口
 */
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView
{
    [self.locService startUserLocationService];// 开始定位
}
/**
 *  根据anntation生成对应的View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    static NSString *reuseIdentifier = @"AnnotationView";
    BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    }
    annotationView.animatesDrop = YES;// 设置该标注点动画显示
    TSLPointAnnotation *anno = (TSLPointAnnotation *)annotation;
    annotationView.image = [TSLTool homeImageWithType:[anno.MType integerValue]];
    return annotationView;
}
/**
 *  当点击annotation view弹出的泡泡时，调用此接口
 */
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view
{
    if ([view.annotation isKindOfClass:[TSLPointAnnotation class]]) {
        TSLPointAnnotation *annotation = (TSLPointAnnotation *)view.annotation;
        // 得到MType, 就可以得到跳转的controller
        NSString *classString = [TSLTool homeClassWithType:[annotation.MType integerValue]];
        if (classString.length) {
            TSLBaseDetailViewController *destVc = [NSClassFromString(classString) new];
            destVc.Identifier = annotation.Identifier;
            [self.navigationController pushViewController:destVc animated:YES];
        }
    }
}

/**
 *  地图区域改变完成后会调用此接口
 */
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    BMKMapPoint point1 = BMKMapPointForCoordinate(self.currentCoordinate);
    BMKMapPoint point2 = BMKMapPointForCoordinate(mapView.centerCoordinate);
    CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
    if (distance >= 2750) { // 大于2750米的时候刷新标注
        [self GetAnnotationsWithCoordinate:mapView.centerCoordinate];
    }
}

/**
 *  网络请求获取周边信息
 */
- (void)GetAnnotationsWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    self.currentCoordinate = coordinate;// 当前中心点
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"mMapy"] = @(coordinate.latitude);
    param[@"mMapx"] = @(coordinate.longitude);
    param[@"mtype"] = @(26);
    [TSLHttpTool GET:[NSString stringWithFormat:@"%@%@", TSLAPI_PREFIX, TSLAPI_MAP] parameters:param success:^(id json) {
        NSArray *infoArray = [TSLMapInfo objectArrayWithKeyValuesArray:json];
        NSMutableArray *annotations = [NSMutableArray array];
        for (TSLMapInfo *info in infoArray) {
            TSLPointAnnotation *annotation = [[TSLPointAnnotation alloc] init];
            CLLocationCoordinate2D coor;
            coor.latitude = [info.MMapy doubleValue];// 纬度
            coor.longitude = [info.MMapx doubleValue];// 经度
            annotation.coordinate = coor;
            annotation.title = info.MName;
            annotation.subtitle = info.MAddress;
            annotation.Identifier = info.Identifier;
            annotation.User_Id = info.User_Id;
            annotation.MType = info.MType;
            [annotations addObject:annotation];
        }
        self.annotations = annotations;// 标注数组
        // 主动调用代理方法添加标注
        [self chooseView:nil didSelectedRowWithType:self.annotationType];
//        // 清空标注
//        [self.mapView removeAnnotations:self.mapView.annotations];
//        // 添加标注
//        [self.mapView addAnnotations:annotations];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"网络异常"];
    }];
}
/**
 *  回到以定位为中心的位置
 */
- (void)backToCenter
{
    [self.mapView setCenterCoordinate:self.userCoordinate animated:YES];
}

- (NSArray *)annotations
{
    if (_annotations == nil) {
        _annotations = [NSArray array];
    }
    return _annotations;
}

//-(void)setupMapView
//{
//    //配置用户Key
//    [MAMapServices sharedServices].apiKey = @"49b47e53d08ea25134175c8da8230d1a";
//    
//    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
//    _mapView.delegate = self;
//    _mapView.showsUserLocation = YES;    //YES 为打开定位，NO为关闭定位
//    _mapView.userTrackingMode = MAUserTrackingModeFollow;// 追踪用户的location更新
//    _mapView.showsCompass= NO; // 设置成NO表示关闭指南针；YES表示显示指南针
//    _mapView.showsScale= YES;  //设置成NO表示不显示比例尺；YES表示显示比例尺
//    _mapView.scaleOrigin= CGPointMake(_mapView.scaleOrigin.x, ScreenH - 66);  //设置比例尺位置
//    [_mapView setZoomLevel:13.5 animated:YES];
//    [self.view insertSubview:_mapView atIndex:0];
//    self.firstLocatingUser = YES;
//}
//
//#pragma mark - mapview-delegate
///**
// *  定位成功回调
// */
//- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
//{
//    if (self.firstLocatingUser == YES) {
//        [self setupAnnotations];
//    }
//    self.firstLocatingUser = NO;
//}
//
///**
// *  当mapView新添加annotation views时调用此接口
// */
//- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
//{
//    MAAnnotationView *view = [views firstObject];
//    
//    // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
//    if ([view.annotation isKindOfClass:[MAUserLocation class]])
//    {
//        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
//        [self.mapView updateUserLocationRepresentation:pre];
//    } 
//}
///**
// *  根据anntation(标注)得到对应的View
// */
//- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
//{
//    if ([annotation isKindOfClass:[MAPointAnnotation class]])
//    {
//        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
//        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
//        if (annotationView == nil)
//        {
//            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
//        }
//        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
//        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
//        annotationView.pinColor = MAPinAnnotationColorPurple;
//        return annotationView;
//    }
//    return nil;
//}
///**
// *  标注内容被整体点击时调用此方法
// */
//- (void)mapView:(MAMapView *)mapView didAnnotationViewCalloutTapped:(MAAnnotationView *)view
//{
//    TSLog(@"%@",view);
//}
///**
// *  计算两个经纬度点的距离
// */
//- (double)GetDistanceFromPoint:(CLLocationCoordinate2D)point1 toPoint:(CLLocationCoordinate2D)point2
//{
//    double R = 6370996.81;//地球半径
//    double distance = R * acos(cos(point1.latitude*M_PI/180 )*cos(point2.latitude*M_PI/180)*cos(point1.longitude*M_PI/180 -point2.longitude*M_PI/180)+
//                               sin(point1.latitude*M_PI/180 )*sin(point2.latitude*M_PI/180));
//    return distance;
//}

@end
