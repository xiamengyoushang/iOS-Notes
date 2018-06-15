//
//  YMAnnotationView.h
//  BaiduMap_Demo
//
//  Created by linkiing on 2018/6/15.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKMapView.h>

@interface YMAnnotationView : BMKAnnotationView

/**
 *  创建方法
 *  @param mapView 地图
 *  @return 大头针
 */
+ (instancetype)annotationViewWithMap:(BMKMapView *)mapView withAnnotation:(id <BMKAnnotation>)annotation;

@end
