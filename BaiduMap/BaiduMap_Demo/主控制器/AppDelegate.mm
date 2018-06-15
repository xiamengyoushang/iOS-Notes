//
//  AppDelegate.m
//  BaiduMap_Demo
//
//  Created by linkiing on 2018/5/31.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import "AppDelegate.h"
#import <BaiduMapAPI_Base/BMKMapManager.h>

@interface AppDelegate ()

@property (nonatomic, strong) BMKMapManager *mapManager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSString *mapKey = @"x5EHcRvWZm8uzkt3HUpGBQU3";
    _mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [_mapManager start:mapKey generalDelegate:nil];
    if (ret) {
        NSLog(@"百度引擎设置成功！");
    }
    return YES;
}

@end
