//
//  YYImageProgressiveExample.m
//  YYKitDemo
//
//  Created by linkiing on 2018/5/28.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import "YYImageProgressiveExample.h"
#import "Constant.h"

@interface YYImageProgressiveExample ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UISegmentedControl *seg0;
@property (nonatomic, strong) UISegmentedControl *seg1;
@property (nonatomic, strong) UISlider *slider0;
@property (nonatomic, strong) UISlider *slider1;

@end

@implementation YYImageProgressiveExample

#pragma mark - Initialize
- (void)InitializeData{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _imageView = [UIImageView new];
    _imageView.size = CGSizeMake(300, 300);
    _imageView.backgroundColor = [UIColor colorWithWhite:0.790 alpha:1.000];
    _imageView.centerX = SCREEN_WIDTH / 2;
    
    _seg0 = [[UISegmentedControl alloc] initWithItems:@[@"底线",@"逐行/隔行"]];
    _seg0.selectedSegmentIndex = 0;
    _seg0.size = CGSizeMake(_imageView.width, 30);
    _seg0.centerX = SCREEN_WIDTH / 2;
    
    _seg1 = [[UISegmentedControl alloc] initWithItems:@[@"JPEG", @"PNG", @"GIF"]];
    _seg1.frame = _seg0.frame;
    _seg1.selectedSegmentIndex = 0;
    
    _slider0 = [UISlider new];
    _slider0.width = _seg0.width;
    [_slider0 sizeToFit];
    if (kSystemVersion < 7) _slider0.height = 20;
    _slider0.minimumValue = 0;
    _slider0.maximumValue = 1.05;
    _slider0.value = 0;
    _slider0.centerX = SCREEN_WIDTH / 2;
    
    _slider1 = [UISlider new];
    _slider1.frame = _slider0.frame;
    _slider1.minimumValue = 0;
    _slider1.maximumValue = 20;
    _slider1.value = 0;
    
    _imageView.top = (kiOS7Later ? 64 : 0) + 20;
    _seg0.top = _imageView.bottom + (kiOS7Later ? 10 : 0);
    _seg1.top = _seg0.bottom + (kiOS7Later ? 10 : 0);
    _slider0.top = _seg1.bottom + 10;
    _slider1.top = _slider0.bottom + (kiOS7Later ? 10 : 20);
    
    [self.view addSubview:_imageView];
    [self.view addSubview:_seg0];
    [self.view addSubview:_seg1];
    [self.view addSubview:_slider0];
    [self.view addSubview:_slider1];
    
    __weak typeof(self) _self = self;
    [_seg0 addBlockForControlEvents:UIControlEventValueChanged block:^(id sender) {
        [_self changedCurrentEvent];
    }];
    [_seg1 addBlockForControlEvents:UIControlEventValueChanged block:^(id sender) {
        [_self changedCurrentEvent];
    }];
    [_slider0 addBlockForControlEvents:UIControlEventValueChanged block:^(id sender) {
        [_self changedCurrentEvent];
    }];
    [_slider1 addBlockForControlEvents:UIControlEventValueChanged block:^(id sender) {
        [_self changedCurrentEvent];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self InitializeData];
}
- (void)changedCurrentEvent{
    NSString *name = nil;
    if (_seg0.selectedSegmentIndex == 0) {
        if (_seg1.selectedSegmentIndex == 0) {
            name = @"mew_baseline.jpg";
        } else if (_seg1.selectedSegmentIndex == 1) {
            name = @"mew_baseline.png";
        } else {
            name = @"mew_baseline.gif";
        }
    } else {
        if (_seg1.selectedSegmentIndex == 0) {
            name = @"mew_progressive.jpg";
        } else if (_seg1.selectedSegmentIndex == 1) {
            name = @"mew_interlaced.png";
        } else {
            name = @"mew_interlaced.gif";
        }
    }
    
    NSData *data = [NSData dataNamed:name];
    float progress = _slider0.value;
    if (progress > 1) progress = 1;
    NSData *subData = [data subdataWithRange:NSMakeRange(0, data.length * progress)];
    
    YYImageDecoder *decoder = [[YYImageDecoder alloc] initWithScale:[UIScreen mainScreen].scale];
    [decoder updateData:subData final:NO];
    YYImageFrame *frame = [decoder frameAtIndex:0 decodeForDisplay:YES];
    
    //高斯模糊
    UIImage *image = [frame.image imageByBlurRadius:_slider1.value tintColor:nil tintMode:0 saturation:1 maskImage:nil];
    _imageView.image = image;
}


@end
