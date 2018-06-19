//
//  GroupViewController.m
//  iOS Test
//
//  Created by linkiing on 2018/6/19.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import "GroupViewController.h"

@interface GroupViewController ()

@end

@implementation GroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] postNotificationName:GROUPNOTIFICATION object:@"通知传值"];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    _returnBlock(@"Block传值");
    if (_delegate&&[_delegate respondsToSelector:@selector(getGroupResponseFunction:)]) {
        [_delegate getGroupResponseFunction:@"Delegate代理传值"];
    }
}
- (void)request:(NSString *)title andBlock:(void(^)(BOOL isBlock))completion{
    NSLog(@"%@",title);
    completion(YES);
}

@end
