//
//  TSLDestinationViewController.m
//  TSLogistics
//
//  Created by erpapa on 15/12/6.
//  Copyright (c) 2015年 erpapa. All rights reserved.
//

#import "TSLDestinationViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import "TSLPointAnnotation.h"

@interface TSLDestinationViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate, BMKRouteSearchDelegate>
@property (strong, nonatomic) BMKMapView *mapView;
@property (strong, nonatomic) BMKLocationService *locService;
@property (strong, nonatomic) BMKRouteSearch* routesearch;
@property (assign, nonatomic) CLLocationCoordinate2D userCoordinate;
@end

@implementation TSLDestinationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMapView];
    [self setupBackView];
    // self.DestinationCoordinate = (CLLocationCoordinate2D){39.624086, 118.101214};
}

-(void)setupMapView
{
    // 地图
    _mapView = [[BMKMapView alloc] initWithFrame:self.view.bounds];
    _mapView.showMapScaleBar = YES;
    _mapView.zoomLevel = 15.0;
    // _mapView.showsUserLocation = YES;//显示定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    [self.view addSubview:_mapView];
    
    // 定位
    _locService = [[BMKLocationService alloc] init];
    // 检索
    _routesearch = [[BMKRouteSearch alloc] init];
}

- (void)setupBackView
{
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 30, 40, 25)];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageWithColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.6]] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
    self.locService.delegate = self;
    self.routesearch.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil;
    self.locService.delegate = nil;
    self.routesearch.delegate = nil;
}
#pragma mark - BMKMapViewDelegate
/**
 *  地图初始化完毕时会调用此接口
 */
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView
{
    [self.locService startUserLocationService];// 开始定位
}

#pragma mark - BMKLocationServiceDelegate
/**
 *  处理位置坐标更新
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    self.userCoordinate = userLocation.location.coordinate;
    [self driveSearchWithStartPt:self.userCoordinate endPt:self.DestinationCoordinate];
    [self setVisibleRegin];// 调整地图
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
/**
 *  驾乘路线检索
 */
- (void)driveSearchWithStartPt:(CLLocationCoordinate2D)startPt endPt:(CLLocationCoordinate2D)endPt
{
    BMKPlanNode *start = [[BMKPlanNode alloc] init];
    start.pt = startPt;
    BMKPlanNode *end = [[BMKPlanNode alloc] init];
    end.pt = endPt;
    BMKDrivingRoutePlanOption *drivingRouteSearchOption = [[BMKDrivingRoutePlanOption alloc] init];
    drivingRouteSearchOption.from = start;
    drivingRouteSearchOption.to = end;
    [self.routesearch drivingSearch:drivingRouteSearchOption];
}

#pragma mark - BMKRouteSearchDelegate
#pragma mark - 驾车线路检索
- (void)onGetDrivingRouteResult:(BMKRouteSearch*)searcher result:(BMKDrivingRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKWalkingRouteLine* plan = (BMKWalkingRouteLine*)[result.routes objectAtIndex:0];
        NSInteger size = plan.steps.count;
        NSInteger planPointCounts = 0;
        NSMutableArray *annos = [NSMutableArray array];
        for (NSInteger i = 0; i < size; i++) {
            BMKWalkingStep *transitStep = [plan.steps objectAtIndex:i];
            if(i == 0){
                TSLPointAnnotation *item = [[TSLPointAnnotation alloc] init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [annos addObject:item]; // 添加起点标注
            }else if(i == size - 1){
                TSLPointAnnotation* item = [[TSLPointAnnotation alloc] init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [annos addObject:item]; // 添加起点标注
            }
            //添加annotation节点
            TSLPointAnnotation *item = [[TSLPointAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.entraceInstruction;
            item.type = 2;
            // transitStep.direction 正北方向为0，顺时针每增加30度加1,
            item.degree = transitStep.direction * 30;// 设置角度
            [annos addObject:item];
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
            
        } // for循环结束
        [_mapView addAnnotations:annos];// 添加标注数组
        //轨迹点
        BMKMapPoint temppoints[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKWalkingStep *transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0; k < transitStep.pointsCount; k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
        } // for循环结束
        
        // 通过points构建BMKPolyline
        BMKPolyline *polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapView addOverlay:polyLine]; // 添加路线overlay
    }
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
    // annotationView.animatesDrop = YES;// 设置该标注点动画显示
    TSLPointAnnotation *anno = (TSLPointAnnotation *)annotation;
    UIImage *image = [self imageWithType:anno.type];
    if (anno.type == 2) {
        annotationView.image = [image imageRotatedByDegrees:anno.degree];
        annotationView.centerOffset = CGPointMake(0, 3);// 向下偏移
    } else {
        annotationView.image = image;
    }
    return annotationView;
}

/**
 *  根据overlay生成对应的View
 */
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:1];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
    return nil;
}
/**
 *  调整地图显示
 */
- (void)setVisibleRegin
{
    //计算中心点
    CLLocationCoordinate2D centerCoordinate;
    centerCoordinate.latitude = (CLLocationDegrees)((self.userCoordinate.latitude + self.DestinationCoordinate.latitude) * 0.5f);
    centerCoordinate.longitude = (CLLocationDegrees)((self.userCoordinate.longitude + self.DestinationCoordinate.longitude) * 0.5f);
    BMKCoordinateSpan span;
    //计算地理位置的跨度(绝对值)
    span.latitudeDelta = fabs(self.userCoordinate.latitude - self.DestinationCoordinate.latitude);
    span.longitudeDelta = fabs(self.userCoordinate.longitude - self.DestinationCoordinate.longitude);
    //得出数据的坐标区域
    BMKCoordinateRegion region = (BMKCoordinateRegion){centerCoordinate, span};
    //百度地图的坐标范围转换成相对视图的位置
    CGRect fitRect = [self.mapView convertRegion:region toRectToView:self.mapView];
    //将地图视图的位置转换成地图的位置，
    BMKMapRect fitMapRect = [self.mapView convertRect:fitRect toMapRectFromView:self.mapView];
    //设置地图可视范围为数据所在的地图位置
    [self.mapView setVisibleMapRect:fitMapRect edgePadding:UIEdgeInsetsMake(15, 15, 15, 15) animated:YES];
//    [self.mapView setVisibleMapRect:fitMapRect animated:YES];
}

/**
 *  返回相应的图片
 */
- (UIImage *)imageWithType:(NSInteger)type
{
    NSDictionary *imageType = @{
                                @(0):@"icon_nav_start",
                                @(1):@"icon_nav_end",
                                @(2):@"icon_direction"
                                };
    NSString *imageName = [imageType objectForKey:@(type)];
    return [UIImage imageNamed:[@"mapapi.bundle/images" stringByAppendingPathComponent:imageName]];
}
/**
 *  dismiss
 */
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
