//
//  YYWebImageExampleCell.h
//  YYKitDemo
//
//  Created by linkiing on 2018/5/28.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

#define kCellHeight ceil((kScreenWidth) * 3.0 / 4.0)

@interface YYWebImageExampleCell : UITableViewCell

@property (nonatomic, strong) YYAnimatedImageView *webImageView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
- (void)setImageURL:(NSURL *)url;

@end
