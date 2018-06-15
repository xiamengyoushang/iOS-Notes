//
//  YMPaopaoView.h
//  BaiduMap_Demo
//
//  Created by linkiing on 2018/6/15.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YMPoi,YMPaopaoView;

@protocol YMPaopaoViewDelagate <NSObject>

-(void)paopaoView:(YMPaopaoView *)paopapView coverButtonClickWithPoi:(YMPoi *)poi;

@end

@interface YMPaopaoView : UIView

/** poi*/
@property (nonatomic, strong) YMPoi *poi;

/** YMPaopaoViewDelagate*/
@property (nonatomic, weak) id<YMPaopaoViewDelagate> delegate;

@end
