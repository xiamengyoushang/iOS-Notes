//
//  YYTextAttributeExample.m
//  YYKitDemo
//
//  Created by linkiing on 2018/5/28.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import "YYTextAttributeExample.h"
#import "YYTextExampleHelper.h"

@interface YYTextAttributeExample ()

@end

@implementation YYTextAttributeExample

#pragma mark - Initialize
- (void)InitializeData{
    self.view.backgroundColor = [UIColor whiteColor];
    __weak typeof(self) _self = self;
    [YYTextExampleHelper addDebugOptionToViewController:self];
    
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    {
        //阴影
        NSMutableAttributedString *addtext = [[NSMutableAttributedString alloc] initWithString:@"Shadow"];
        addtext.font = [UIFont boldSystemFontOfSize:30];
        addtext.color = [UIColor whiteColor];
        YYTextShadow *shadow = [YYTextShadow new];
        shadow.color = [UIColor colorWithWhite:0.000 alpha:0.490];
        shadow.offset = CGSizeMake(0, 1);
        shadow.radius = 5;
        addtext.textShadow = shadow;
        [text appendAttributedString:addtext];
        [text appendAttributedString:[self padding]];
    }
    {
        //内阴影
        NSMutableAttributedString *addtext = [[NSMutableAttributedString alloc] initWithString:@"Inner Shadow"];
        addtext.font = [UIFont boldSystemFontOfSize:30];
        addtext.color = [UIColor whiteColor];
        YYTextShadow *shadow = [YYTextShadow new];
        shadow.color = [UIColor colorWithWhite:0.000 alpha:0.40];
        shadow.offset = CGSizeMake(0, 1);
        shadow.radius = 1;
        addtext.textInnerShadow = shadow;
        [text appendAttributedString:addtext];
        [text appendAttributedString:[self padding]];
    }
    {
        //多个阴影
        NSMutableAttributedString *addtext = [[NSMutableAttributedString alloc] initWithString:@"Multiple Shadows"];
        addtext.font = [UIFont boldSystemFontOfSize:30];
        addtext.color = [UIColor colorWithRed:1.000 green:0.795 blue:0.014 alpha:1.000];
        
        YYTextShadow *shadow = [YYTextShadow new];
        shadow.color = [UIColor colorWithWhite:0.000 alpha:0.20];
        shadow.offset = CGSizeMake(0, -1);
        shadow.radius = 1.5;
        YYTextShadow *subShadow = [YYTextShadow new];
        subShadow.color = [UIColor colorWithWhite:1 alpha:0.99];
        subShadow.offset = CGSizeMake(0, 1);
        subShadow.radius = 1.5;
        shadow.subShadow = subShadow;
        addtext.textShadow = shadow;
        
        YYTextShadow *innerShadow = [YYTextShadow new];
        innerShadow.color = [UIColor colorWithRed:0.851 green:0.311 blue:0.000 alpha:0.780];
        innerShadow.offset = CGSizeMake(0, 1);
        innerShadow.radius = 1;
        addtext.textInnerShadow = innerShadow;
        
        [text appendAttributedString:addtext];
        [text appendAttributedString:[self padding]];
    }
    {
        //背景
        NSMutableAttributedString *addtext = [[NSMutableAttributedString alloc] initWithString:@"Background Image"];
        addtext.font = [UIFont boldSystemFontOfSize:30];
        addtext.color = [UIColor colorWithRed:1.000 green:0.795 blue:0.014 alpha:1.000];
        
        CGSize size = CGSizeMake(20, 20);
        UIImage *background = [UIImage imageWithSize:size drawBlock:^(CGContextRef context) {
            UIColor *c0 = [UIColor colorWithRed:0.054 green:0.879 blue:0.000 alpha:1.000];
            UIColor *c1 = [UIColor colorWithRed:0.869 green:1.000 blue:0.030 alpha:1.000];
            [c0 setFill];
            CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
            [c1 setStroke];
            CGContextSetLineWidth(context, 2);
            for (int i = 0; i < size.width * 2; i+= 4) {
                CGContextMoveToPoint(context, i, -2);
                CGContextAddLineToPoint(context, i - size.height, size.height + 2);
            }
            CGContextStrokePath(context);
        }];
        addtext.color = [UIColor colorWithPatternImage:background];
        
        [text appendAttributedString:addtext];
        [text appendAttributedString:[self padding]];
    }
    {
        //边框
        NSMutableAttributedString *addtext = [[NSMutableAttributedString alloc] initWithString:@"Border"];
        addtext.font = [UIFont boldSystemFontOfSize:30];
        addtext.color = [UIColor colorWithRed:1.000 green:0.029 blue:0.651 alpha:1.000];
        
        YYTextBorder *border = [YYTextBorder new];
        border.strokeColor = [UIColor colorWithRed:1.000 green:0.029 blue:0.651 alpha:1.000];
        border.strokeWidth = 3;
        border.lineStyle = YYTextLineStylePatternCircleDot;
        border.cornerRadius = 3;
        border.insets = UIEdgeInsetsMake(0, -4, 0, -4);
        addtext.textBackgroundBorder = border;
        
        [text appendAttributedString:[self padding]];
        [text appendAttributedString:addtext];
        [text appendAttributedString:[self padding]];
        [text appendAttributedString:[self padding]];
        [text appendAttributedString:[self padding]];
        [text appendAttributedString:[self padding]];
    }
    {
        //链接
        NSMutableAttributedString *addtext = [[NSMutableAttributedString alloc] initWithString:@"Link"];
        addtext.font = [UIFont boldSystemFontOfSize:30];
        addtext.underlineStyle = NSUnderlineStyleSingle;
        [addtext setTextHighlightRange:addtext.rangeOfAll
                             color:[UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000]
                   backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                         tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
                             [_self showMessage:[NSString stringWithFormat:@"Tap: %@", [text.string substringWithRange:range]]];
                         }];
        
        [text appendAttributedString:addtext];
        [text appendAttributedString:[self padding]];
    }
    {
        NSMutableAttributedString *addtext = [[NSMutableAttributedString alloc] initWithString:@"Another Link"];
        addtext.font = [UIFont boldSystemFontOfSize:30];
        addtext.color = [UIColor redColor];
        
        YYTextBorder *border = [YYTextBorder new];
        border.cornerRadius = 50;
        border.insets = UIEdgeInsetsMake(0, -10, 0, -10);
        border.strokeWidth = 0.5;
        border.strokeColor = addtext.color;
        border.lineStyle = YYTextLineStyleSingle;
        addtext.textBackgroundBorder = border;
        
        YYTextBorder *highlightBorder = border.copy;
        highlightBorder.strokeWidth = 0;
        highlightBorder.strokeColor = addtext.color;
        highlightBorder.fillColor = addtext.color;
        
        YYTextHighlight *highlight = [YYTextHighlight new];
        [highlight setColor:[UIColor whiteColor]];
        [highlight setBackgroundBorder:highlightBorder];
        highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
            [_self showMessage:[NSString stringWithFormat:@"Tap: %@",[text.string substringWithRange:range]]];
        };
        [addtext setTextHighlight:highlight range:addtext.rangeOfAll];
        
        [text appendAttributedString:addtext];
        [text appendAttributedString:[self padding]];
    }
    {
        NSMutableAttributedString *addtext = [[NSMutableAttributedString alloc] initWithString:@"Yet Another Link"];
        addtext.font = [UIFont boldSystemFontOfSize:30];
        addtext.color = [UIColor whiteColor];
        
        YYTextShadow *shadow = [YYTextShadow new];
        shadow.color = [UIColor colorWithWhite:0.000 alpha:0.490];
        shadow.offset = CGSizeMake(0, 1);
        shadow.radius = 5;
        addtext.textShadow = shadow;
        
        YYTextShadow *shadow0 = [YYTextShadow new];
        shadow0.color = [UIColor colorWithWhite:0.000 alpha:0.20];
        shadow0.offset = CGSizeMake(0, -1);
        shadow0.radius = 1.5;
        YYTextShadow *shadow1 = [YYTextShadow new];
        shadow1.color = [UIColor colorWithWhite:1 alpha:0.99];
        shadow1.offset = CGSizeMake(0, 1);
        shadow1.radius = 1.5;
        shadow0.subShadow = shadow1;
        
        YYTextShadow *innerShadow0 = [YYTextShadow new];
        innerShadow0.color = [UIColor colorWithRed:0.851 green:0.311 blue:0.000 alpha:0.780];
        innerShadow0.offset = CGSizeMake(0, 1);
        innerShadow0.radius = 1;
        
        YYTextHighlight *highlight = [YYTextHighlight new];
        [highlight setColor:[UIColor colorWithRed:1.000 green:0.795 blue:0.014 alpha:1.000]];
        [highlight setShadow:shadow0];
        [highlight setInnerShadow:innerShadow0];
        [addtext setTextHighlight:highlight range:addtext.rangeOfAll];
        
        [text appendAttributedString:addtext];
    }
    
    YYLabel *label = [YYLabel new];
    label.attributedText = text;
    label.width = SCREEN_WIDTH;
    label.height = SCREEN_HEIGHT - (kiOS7Later ? 64 : 44);
    label.top = (kiOS7Later ? 64 : 0);
    label.textAlignment = NSTextAlignmentCenter;
    label.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor colorWithWhite:0.933 alpha:1.000];
    [self.view addSubview:label];
    
    label.highlightTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        [_self showMessage:[NSString stringWithFormat:@"Tap: %@",[text.string substringWithRange:range]]];
    };
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self InitializeData];
}
- (NSAttributedString *)padding {
    NSMutableAttributedString *pad = [[NSMutableAttributedString alloc] initWithString:@"\n\n"];
    pad.font = [UIFont systemFontOfSize:4];
    return pad;
}
- (void)showMessage:(NSString *)msg {
    CGFloat padding = 10;
    YYLabel *label = [YYLabel new];
    label.text = msg;
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor colorWithRed:0.033 green:0.685 blue:0.978 alpha:0.730];
    label.width = SCREEN_WIDTH;
    label.textContainerInset = UIEdgeInsetsMake(padding, padding, padding, padding);
    label.height = [msg heightForFont:label.font width:label.width] + 2 * padding;
    label.bottom = (kiOS7Later ? 88 : 0);
    [self.view addSubview:label];
    [UIView animateWithDuration:0.3 animations:^{
        label.top = (kiOS7Later ? 88 : 0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            label.bottom = (kiOS7Later ? 88 : 0);
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}

@end
