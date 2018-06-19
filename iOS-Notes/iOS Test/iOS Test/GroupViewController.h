//
//  GroupViewController.h
//  iOS Test
//
//  Created by linkiing on 2018/6/19.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import <UIKit/UIKit.h>

//通知传值
#define GROUPNOTIFICATION @"GROUPNOTIFICATION"
//Block传值
typedef void (^ReturnBlock)(NSString *blockString);

@protocol GroupResponseDelegate <NSObject>
//代理传值
- (void)getGroupResponseFunction:(NSString *)delegateString;
@end

@interface GroupViewController : UIViewController

@property (nonatomic) ReturnBlock returnBlock;
@property (nonatomic, weak)id<GroupResponseDelegate>delegate;
//Block做为参数传值
- (void)request:(NSString *)title andBlock:(void(^)(BOOL isBlock))completion;

@end
