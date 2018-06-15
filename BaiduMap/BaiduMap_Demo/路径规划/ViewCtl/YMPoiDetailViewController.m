//
//  YMPoiDetailViewController.m
//  BaiduMap_Demo
//
//  Created by linkiing on 2018/6/15.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import "YMPoiDetailViewController.h"
#import "YMRouteAnnotationController.h"
#import "UIImageView+WebCache.h"
#import "YMPoi.h"

@interface YMPoiDetailViewController ()

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *areaNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageview;

@end

@implementation YMPoiDetailViewController

#pragma mark - Initialize
- (void)InitializeData{
    self.navigationItem.title = @"店铺详情";
    self.nameLabel.text = self.poi.name;
    self.areaNameLabel.text = self.poi.areaName;
    if (_poi.frontImg.length) {
        NSArray *componentsArray = [_poi.frontImg componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"/"]];
        NSMutableString *imageUrl = [[NSMutableString alloc] initWithCapacity:0];
        for (NSInteger i=0; i<componentsArray.count; i++) {
            NSString *componentsString = [componentsArray objectAtIndex:i];
            if ([componentsString isEqualToString:@"w.h"]) {
                [imageUrl appendFormat:@"%@/",@"200.200"];
            } else {
                if (i == componentsArray.count-1) {
                    [imageUrl appendFormat:@"%@",componentsString];
                } else {
                    [imageUrl appendFormat:@"%@/",componentsString];
                }
            }
        }
        [_imageview sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self InitializeData];
}
#pragma mark - UIButton
- (IBAction)buttonClick:(UIButton *)sender {
    YMRouteAnnotationController *routationVC = [[YMRouteAnnotationController alloc] init];
    routationVC.poi = self.poi;
    routationVC.city = self.city;
    routationVC.userLocation = self.userLocation;
    [self presentViewController:routationVC animated:YES completion:nil];
}

@end
