//
//  YYFeedListExample.m
//  YYKitDemo
//
//  Created by linkiing on 2018/5/29.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import "YYFeedListExample.h"
#import "Constant.h"

@interface YYFeedListExample ()

@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *classNames;
@property (nonatomic, strong) NSMutableArray *images;

@end

@implementation YYFeedListExample

#pragma mark - Initialize
- (void)InitializeData{
    self.titles = @[].mutableCopy;
    self.classNames = @[].mutableCopy;
    self.images = @[].mutableCopy;
    self.title = @"Feed List Demo";
    //[self addCell:@"Twitter" class:@"T1HomeTimelineItemsViewController" image:@"Twitter.jpg"];
    [self addCell:@"Weibo" class:@"WBStatusTimelineViewController" image:@"Weibo.jpg"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self InitializeData];
}
- (void)addCell:(NSString *)title class:(NSString *)className image:(NSString *)imageName {
    [self.titles addObject:title];
    [self.classNames addObject:className];
    [self.images addObject:[YYImage imageNamed:imageName]];
}
#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YY"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YY"];
    }
    cell.textLabel.text = _titles[indexPath.row];
    cell.imageView.image = _images[indexPath.row];
    cell.imageView.clipsToBounds = YES;
    
    //调整图片大小
    CGSize itemSize = CGSizeMake(40, 40);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    cell.imageView.layer.cornerRadius = 40 / 2;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = self.classNames[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *ctrl = class.new;
        ctrl.title = _titles[indexPath.row];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
