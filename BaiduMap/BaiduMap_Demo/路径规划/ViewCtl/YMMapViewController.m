//
//  YMMapViewController.m
//  BaiduMap_Demo
//
//  Created by linkiing on 2018/6/15.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import "YMMapViewController.h"

@interface YMMapViewController ()<BMKLocationServiceDelegate, BMKMapViewDelegate, BMKGeoCodeSearchDelegate, YMPaopaoViewDelagate>

@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, strong) BMKLocationService *locService;
@property (nonatomic, strong) BMKGeoCodeSearch *geoSearch;

/** 用户当前位置*/
@property(nonatomic , strong) BMKUserLocation *userLocation;
/** 当前城市*/
@property (nonatomic, copy) NSString *city;

@end

@implementation YMMapViewController

#pragma mark - 设置百度地图
- (void)setupMapViewWithParam{
    self.userLocation = [[BMKUserLocation alloc] init];
    _geoSearch = [[BMKGeoCodeSearch alloc] init];
    _locService = [[BMKLocationService alloc] init];
    _locService.distanceFilter = 200;//设定定位的最小更新距离，这里设置 200m 定位一次，频繁定位会增加耗电量
    _locService.desiredAccuracy = kCLLocationAccuracyHundredMeters;//设定定位精度
    //开启定位服务
    [_locService startUserLocationService];
    //初始化BMKMapView
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 64, SCREENW, SCREENH - 64)];
    
    _mapView.buildingsEnabled = YES;//设定地图是否现显示3D楼块效果
    _mapView.overlookEnabled = YES; //设定地图View能否支持俯仰角
    _mapView.showMapScaleBar = YES; // 设定是否显式比例尺
    //_mapView.overlooking = -45;   // 地图俯视角度，在手机上当前可使用的范围为－45～0度
    
    _mapView.zoomLevel = 12;//设置放大级别
    [self.view addSubview:_mapView];
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    BMKLocationViewDisplayParam *userlocationStyle = [[BMKLocationViewDisplayParam alloc] init];
    userlocationStyle.isRotateAngleValid = YES;
    userlocationStyle.isAccuracyCircleShow = NO;
}
#pragma mark - 加载美团数据
- (void)loadMeituanData{
    NSString *urlString = MEITUAN_URL;
    // 加载进度
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD showWithStatus:@"正在加载..."];
    [[AFHTTPSessionManager manager] GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        NSArray *data = responseObject[@"data"];
        for (NSDictionary *dict in data) {
            NSDictionary *poiDict = dict[@"poi"];
            YMPoi *poi = [YMPoi mj_objectWithKeyValues:poiDict];
            YMPointAnnotation *annotation = [[YMPointAnnotation alloc] init];
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(poi.lat, poi.lng);
            annotation.coordinate = coordinate;
            annotation.poi = poi;
            [self->_mapView addAnnotation:annotation];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMapViewWithParam];
    [self loadMeituanData];
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; //不用时，置nil
    _locService.delegate = nil;
    _geoSearch.delegate = nil;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self; //此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    _geoSearch.delegate = self;
}
#pragma mark - BMKLocationServiceDelegate 用户位置更新后，会调用此函数
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    [_mapView updateLocationData:userLocation];// 动态更新我的位置数据
    self.userLocation = userLocation;
    [_mapView setCenterCoordinate:userLocation.location.coordinate];// 当前地图的中心点
    // geo检索信息类,获取当前城市数据
    BMKReverseGeoCodeOption *reverseGeoCodeOption = [[BMKReverseGeoCodeOption alloc] init];
    reverseGeoCodeOption.reverseGeoPoint = userLocation.location.coordinate;
    [_geoSearch reverseGeoCode:reverseGeoCodeOption];
}

#pragma mark 根据坐标返回反地理编码搜索结果
-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    BMKAddressComponent *addressComponent = result.addressDetail;
    self.city = addressComponent.city;
    NSString *title = [NSString stringWithFormat:@"%@%@%@%@", addressComponent.city, addressComponent.district, addressComponent.streetName, addressComponent.streetNumber];
    NSLog(@"%s -- %@", __func__, title);
}

#pragma mark -BMKMapViewDelegate
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    // 创建大头针
    YMAnnotationView *annotationView = [YMAnnotationView annotationViewWithMap:mapView withAnnotation:annotation];
    YMPaopaoView *paopaoView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([YMPaopaoView class]) owner:nil options:nil] lastObject];
    paopaoView.delegate = self;
    YMPointAnnotation *anno = (YMPointAnnotation *)annotationView.annotation;
    paopaoView.poi = anno.poi;
    annotationView.paopaoView = [[BMKActionPaopaoView alloc] initWithCustomView:paopaoView];
    return annotationView;
}

#pragma mark YMPaopaoViewDelagate
-(void)paopaoView:(YMPaopaoView *)paopapView coverButtonClickWithPoi:(YMPoi *)poi {
    YMPoiDetailViewController *detailVC = [[YMPoiDetailViewController alloc] init];
    detailVC.city = self.city;
    detailVC.poi = poi;
    detailVC.userLocation = self.userLocation;
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
