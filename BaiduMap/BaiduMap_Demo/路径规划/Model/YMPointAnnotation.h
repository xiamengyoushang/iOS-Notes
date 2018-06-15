//
//  YMPointAnnotation.h
//  BaiduMap_Demo
//
//  Created by linkiing on 2018/6/15.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
@class YMPoi;

@interface YMPointAnnotation : BMKPointAnnotation

/** poi*/
@property (nonatomic, strong) YMPoi *poi;
/** 标注点的protocol，提供了标注类的基本信息函数*/
@property (nonatomic, weak) id<BMKAnnotation> delegate;

@end
