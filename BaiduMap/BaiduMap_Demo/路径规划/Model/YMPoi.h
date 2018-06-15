//
//  YMPoi.h
//  BaiduMap_Demo
//
//  Created by linkiing on 2018/6/15.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMPoi : NSObject

/** 地区名称*/
@property (nonatomic, copy) NSString *areaName;
/** 平均价格*/
@property (nonatomic, copy) NSString *avgPrice;
/** 评分*/
@property (nonatomic, copy) NSString *avgScore;
/** 标签*/
@property (nonatomic, copy) NSString *campaignTag;
/** 美食名称*/
@property (nonatomic, copy) NSString *cateName;
/** 渠道*/
@property (nonatomic, copy) NSString *channel;
/** 图片*/
@property (nonatomic, copy) NSString *frontImg;
/** 纬度*/
@property (nonatomic, assign) double lat;
/** 经度*/
@property (nonatomic, assign) double lng;
/** 店名*/
@property (nonatomic, copy) NSString *name;

@end
