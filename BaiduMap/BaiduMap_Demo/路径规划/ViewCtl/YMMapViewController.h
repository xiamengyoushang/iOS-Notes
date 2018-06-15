//
//  YMMapViewController.h
//  BaiduMap_Demo
//
//  Created by linkiing on 2018/6/15.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Map/BMKAnnotationView.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Utils/BMKGeometry.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>

#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <SVProgressHUD/SVProgressHUD.h>

#import "YMPoi.h"
#import "YMPointAnnotation.h"
#import "YMAnnotationView.h"
#import "YMPaopaoView.h"

#import "YMPoiDetailViewController.h"

#define SCREENW [UIScreen mainScreen].bounds.size.width
#define SCREENH [UIScreen mainScreen].bounds.size.height

#define MEITUAN_URL @"http://api.meituan.com/meishi/filter/v4/deal/select/city/1/area/14/cate/1?__skua=58c45e3fe9ccacce6400c5a736b76480&userid=267752722&__vhost=api.meishi.meituan.com&movieBundleVersion=100&wifi-mac=8c%3Af2%3A28%3Afc%3A41%3A92&utm_term=6.5.1&limit=25&ci=1&__skcy=jyDTYwzfsbzflQbUtxRRR1RK2Ag%3D&__skts=1466298960.130064&sort=defaults&__skno=5210AD02-055C-47B7-BD23-A26EB36E2A20&wifi-name=MERCURY_4192&uuid=E158E8C43627D4B0B2BA94FC17DD78F08B7148D4A037A9933F3180FC1E550587&utm_content=E158E8C43627D4B0B2BA94FC17DD78F08B7148D4A037A9933F3180FC1E550587&utm_source=AppStore&version_name=6.5.1&mypos=38.300178%2C116.909954&utm_medium=iphone&wifi-strength=&wifi-cur=0&offset=0&poiFields=cityId%2Clng%2CfrontImg%2CavgPrice%2CavgScore%2Cname%2Clat%2CcateName%2CareaName%2CcampaignTag%2Cabstracts%2Crecommendation%2CpayInfo%2CpayAbstracts%2CqueueStatus&hasGroup=true&utm_campaign=AgroupBgroupD200Ghomepage_category1_1__a1&__skck=3c0cf64e4b039997339ed8fec4cddf05&msid=AE66B26D-47FB-4959-B3F3-FE25606FF0CB2016-06-19-09-1327"

@interface YMMapViewController : UIViewController

@end
