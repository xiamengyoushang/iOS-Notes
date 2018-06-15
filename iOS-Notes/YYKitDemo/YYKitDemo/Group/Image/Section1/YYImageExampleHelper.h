//
//  YYImageExampleHelper.h
//  YYKitDemo
//
//  Created by linkiing on 2018/5/28.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constant.h"

@interface YYImageExampleHelper : NSObject

//点按即可播放/暂停
+ (void)addTapControlToAnimatedImageView:(YYAnimatedImageView *)view;

//幻灯片向前/倒带
+ (void)addPanControlToAnimatedImageView:(YYAnimatedImageView *)view;

@end
