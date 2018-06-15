//
//  YYImageExample.m
//  YYKitDemo
//
//  Created by linkiing on 2018/5/28.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import "YYImageExample.h"

@interface YYImageExample ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *classNames;
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation YYImageExample

#pragma mark - Initialize
- (void)InitializeData{
    self.titles = @[].mutableCopy;
    self.classNames = @[].mutableCopy;
    [self addCell:@"Animated Image" class:@"YYImageDisplayExample"];
    [self addCell:@"Progressive Image" class:@"YYImageProgressiveExample"];
    [self addCell:@"Web Image" class:@"YYWebImageExample"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self InitializeData];
}
- (void)addCell:(NSString *)title class:(NSString *)className {
    [self.titles addObject:title];
    [self.classNames addObject:className];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YY"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YY"];
    }
    cell.textLabel.text = _titles[indexPath.row];
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = self.classNames[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *ctrl = class.new;
        ctrl.title = _titles[indexPath.row];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    [_tableview deselectRowAtIndexPath:indexPath animated:YES];
}

@end
