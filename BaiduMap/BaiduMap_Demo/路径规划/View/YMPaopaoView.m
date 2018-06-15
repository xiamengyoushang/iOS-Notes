//
//  YMPaopaoView.m
//  BaiduMap_Demo
//
//  Created by linkiing on 2018/6/15.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import "YMPaopaoView.h"
#import "UIImageView+WebCache.h"
#import "YMPoi.h"

//user interface里添加xib并指向指定的class
@interface YMPaopaoView()

@property (strong, nonatomic) IBOutlet UIImageView *shopImage;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *areaNameLabel;

@end
@implementation YMPaopaoView

- (void)awakeFromNib{
    [super awakeFromNib];
}
-(void)setPoi:(YMPoi *)poi {
    _poi = poi;
    if (poi.frontImg.length) {
        NSArray *componentsArray = [poi.frontImg componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"/"]];
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
        [self.shopImage sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    }
    self.nameLabel.text = poi.name;
    self.areaNameLabel.text = poi.areaName;
}

#pragma mark - UIButton
- (IBAction)coverButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(paopaoView:coverButtonClickWithPoi:)]) {
        [self.delegate paopaoView:self coverButtonClickWithPoi:self.poi];
    }
}

@end
