//
//  YYImageDisplayExample.m
//  YYKitDemo
//
//  Created by linkiing on 2018/5/28.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import "YYImageDisplayExample.h"
#import "YYImageExampleHelper.h"

@interface YYImageDisplayExample ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation YYImageDisplayExample

#pragma mark - Initialize
- (void)InitializeData{
    self.view.backgroundColor = [UIColor colorWithWhite:0.863 alpha:1.000];
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:_scrollView];
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.size = CGSizeMake(SCREEN_WIDTH, 60);
    label.top = 20;
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.text = @"点击图片暂停/播放\n 左右滑动图片前进/后退";
    [_scrollView addSubview:label];
    
    [self addImageWithName:@"niconiconi" text:@"Animated GIF"];
    [self addImageWithName:@"wall-e" text:@"Animated WebP"];
    [self addImageWithName:@"pia" text:@"Animated PNG (APNG)"];
    [self addFrameImageWithText:@"Frame Animation"];
    [self addSpriteSheetImageWithText:@"Sprite Sheet Animation"];
    
    _scrollView.panGestureRecognizer.cancelsTouchesInView = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self InitializeData];
}
#pragma mark - addImageWithName
- (void)addImageWithName:(NSString *)name text:(NSString *)text {
    //普通动画
    YYImage *image = [YYImage imageNamed:name];
    [self addImage:image size:CGSizeZero text:text];
}
#pragma mark - addFrameImageWithText
- (void)addFrameImageWithText:(NSString *)text {
    //帧动画
    NSString *basePath = [[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:@"EmoticonWeibo.bundle/com.sina.default"];
    NSMutableArray *paths = [NSMutableArray new];
    [paths addObject:[basePath stringByAppendingPathComponent:@"d_aini@3x.png"]];
    [paths addObject:[basePath stringByAppendingPathComponent:@"d_baibai@3x.png"]];
    [paths addObject:[basePath stringByAppendingPathComponent:@"d_chanzui@3x.png"]];
    [paths addObject:[basePath stringByAppendingPathComponent:@"d_chijing@3x.png"]];
    [paths addObject:[basePath stringByAppendingPathComponent:@"d_dahaqi@3x.png"]];
    [paths addObject:[basePath stringByAppendingPathComponent:@"d_guzhang@3x.png"]];
    [paths addObject:[basePath stringByAppendingPathComponent:@"d_haha@2x.png"]];
    [paths addObject:[basePath stringByAppendingPathComponent:@"d_haixiu@3x.png"]];
    UIImage *image = [[YYFrameImage alloc] initWithImagePaths:paths oneFrameDuration:0.1 loopCount:0];
    [self addImage:image size:CGSizeZero text:text];
}
#pragma mark - addSpriteSheetImageWithText
- (void)addSpriteSheetImageWithText:(NSString *)text {
    //雪碧图/精灵表单
    NSString *path = [[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:@"ResourceTwitter.bundle/fav02l-sheet@2x.png"];
    UIImage *sheet = [[UIImage alloc] initWithData:[NSData dataWithContentsOfFile:path] scale:2];
    NSMutableArray *contentRects = [NSMutableArray new];
    NSMutableArray *durations = [NSMutableArray new];
    
    //每张雪碧图里有8 * 12个精灵
    CGSize size = CGSizeMake(sheet.size.width / 8, sheet.size.height / 12);
    for (int j = 0; j < 12; j++) {
        for (int i = 0; i < 8; i++) {
            CGRect rect;
            rect.size = size;
            rect.origin.x = sheet.size.width / 8 * i;
            rect.origin.y = sheet.size.height / 12 * j;
            [contentRects addObject:[NSValue valueWithCGRect:rect]];
            [durations addObject:@(1 / 60.0)];
        }
    }
    YYSpriteSheetImage *sprite;
    sprite = [[YYSpriteSheetImage alloc] initWithSpriteSheetImage:sheet
                                                     contentRects:contentRects
                                                   frameDurations:durations
                                                        loopCount:0];
    [self addImage:sprite size:size text:text];
}
- (void)addImage:(UIImage *)image size:(CGSize)size text:(NSString *)text {
    YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
    
    if (size.width > 0 && size.height > 0) imageView.size = size;
    imageView.centerX = SCREEN_WIDTH / 2;
    imageView.top = [(UIView *)[_scrollView.subviews lastObject] bottom] + 30;
    [_scrollView addSubview:imageView];
    
    [YYImageExampleHelper addTapControlToAnimatedImageView:imageView];
    [YYImageExampleHelper addPanControlToAnimatedImageView:imageView];
    for (UIGestureRecognizer *g in imageView.gestureRecognizers) {
        g.delegate = self;
    }
    
    UILabel *imageLabel = [UILabel new];
    imageLabel.backgroundColor = [UIColor clearColor];
    imageLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH, 20);
    imageLabel.top = imageView.bottom + 10;
    imageLabel.textAlignment = NSTextAlignmentCenter;
    imageLabel.text = text;
    [_scrollView addSubview:imageLabel];
    
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, imageLabel.bottom + 20);
}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    //是否支持多手势触发，返回YES，则可以多个手势一起触发方法，返回NO则为互斥
    return YES;
}

@end
