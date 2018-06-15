//
//  YMPoiDetailViewController.h
//  BaiduMap_Demo
//
//  Created by linkiing on 2018/6/15.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKUserLocation.h>
@class YMPoi;

@interface YMPoiDetailViewController : UIViewController

/** poi*/
@property (nonatomic, strong) YMPoi *poi;
/** 当前城市*/
@property (nonatomic, copy) NSString *city;
/** 用户当前位置*/
@property (nonatomic, strong) BMKUserLocation *userLocation;

@end
